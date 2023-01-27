---
authors:
- Ingo Buerk: null
  name: Ingo Buerk
- Daisy Tsang: null
  name: Daisy Tsang
date: "2021-09-07T00:00:00Z"
title: 'Implementing a custom source connector for Table API and SQL - Part Two '
---

In [part one](/2021/09/07/connector-table-sql-api-part1) of this tutorial, you learned how to build a custom source connector for Flink. In part two, you will learn how to integrate the connector with a test email inbox through the IMAP protocol and filter out emails using Flink SQL.

{% toc %}

# Goals

Part two of the tutorial will teach you how to:

- integrate a source connector which connects to a mailbox using the IMAP protocol
- use [Jakarta Mail](https://eclipse-ee4j.github.io/mail/), a Java library that can send and receive email via the IMAP protocol
- write [Flink SQL](https://ci.apache.org/projects/flink/flink-docs-release-1.13/docs/dev/table/sql/overview/) and execute the queries in the [Ververica Platform](https://www.ververica.com/apache-flink-sql-on-ververica-platform) for a nicer visualization

You are encouraged to follow along with the code in this [repository](https://github.com/Airblader/blog-imap). It provides a boilerplate project that also comes with a bundled [docker-compose](https://docs.docker.com/compose/) setup that lets you easily run the connector. You can then try it out with Flink’s SQL client.


# Prerequisites

This tutorial assumes that you have:

- followed the steps outlined in [part one](/2021/09/07/connector-table-sql-api-part1) of this tutorial
- some familiarity with Java and objected-oriented programming


# Understand how to fetch emails via the IMAP protocol

Now that you have a working source connector that can run on Flink, it is time to connect to an email server via [IMAP](https://en.wikipedia.org/wiki/Internet_Message_Access_Protocol) (an Internet protocol that allows email clients to retrieve messages from a mail server) so that Flink can process emails instead of test static data.

You will use [Jakarta Mail](https://eclipse-ee4j.github.io/mail/), a Java library that can be used to send and receive email via IMAP. For simplicity, authentication will use a plain username and password.

This tutorial will focus more on how to implement a connector for Flink. If you want to learn more about the details of how IMAP or Jakarta Mail work, you are encouraged to explore a more extensive implementation at this [repository](https://github.com/TNG/flink-connector-email). It offers a wide range of information to be read from emails, as well as options to ingest existing emails alongside new ones, connecting with SSL, and more. It also supports different formats for reading email content and implements some connector abilities such as [reading metadata](https://ci.apache.org/projects/flink/flink-docs-release-1.13/api/java/org/apache/flink/table/connector/source/abilities/SupportsReadingMetadata.html).

In order to fetch emails, you will need to connect to the email server, register a listener for new emails and collect them whenever they arrive, and enter a loop to keep the connector running.


# Add configuration options - server information and credentials

In order to connect to your IMAP server, you will need at least the following:

- hostname (of the mail server)
- port number
- username
- password

You will start by creating a class to encapsulate the configuration options. You will make use of [Lombok](https://projectlombok.org) to help with some boilerplate code. By adding the `@Data` and `@SuperBuilder` annotations, Lombok will generate these for all the fields of the immutable class.

```java
import lombok.Data;
import lombok.experimental.SuperBuilder;
import javax.annotation.Nullable;
import java.io.Serializable;

@Data
@SuperBuilder(toBuilder = true)
public class ImapSourceOptions implements Serializable {
    private static final long serialVersionUID = 1L;

    private final String host;
    private final @Nullable Integer port;
    private final @Nullable String user;
    private final @Nullable String password;
}
```

Now you can add an instance of this class to the `ImapSource` and `ImapTableSource` classes previously created (in part one) so it can be used there. Take note of the column names with which the table has been created. This will help later. You will also switch the source to be unbounded now as we will change the implementation in a bit to continuously listen for new emails.


<div class="note">
  <h5>Hint</h5>
  <p>The column names would be "subject" and "content" with the SQL executed in part one:</p>
  <pre><code class="language-sql">CREATE TABLE T (subject STRING, content STRING) WITH ('connector' = 'imap');</code></pre>
</div>


```java
import org.apache.flink.streaming.api.functions.source.RichSourceFunction;
import org.apache.flink.table.data.RowData;
import java.util.List;
import java.util.stream.Collectors;

public class ImapSource extends RichSourceFunction<RowData> {
    private final ImapSourceOptions options;
    private final List<String> columnNames;

    public ImapSource(
        ImapSourceOptions options,
        List<String> columnNames
    ) {
        this.options = options;
        this.columnNames = columnNames.stream()
            .map(String::toUpperCase)
            .collect(Collectors.toList());
    }

    // ...
}
```

```java
import org.apache.flink.table.connector.source.DynamicTableSource;
import org.apache.flink.table.connector.source.ScanTableSource;
import java.util.List;

public class ImapTableSource implements ScanTableSource {

    private final ImapSourceOptions options;
    private final List<String> columnNames;

    public ImapTableSource(
        ImapSourceOptions options,
        List<String> columnNames
    ) {
        this.options = options;
        this.columnNames = columnNames;
    }

    // …

    @Override
    public ScanRuntimeProvider getScanRuntimeProvider(ScanContext ctx) {
        final boolean bounded = false;
        final ImapSource source = new ImapSource(options, columnNames);
        return SourceFunctionProvider.of(source, bounded);
    }

    @Override
    public DynamicTableSource copy() {
        return new ImapTableSource(options, columnNames);
    }

    // …
}
```

Finally, in the `ImapTableSourceFactory` class, you need to create a `ConfigOption<>` for the hostname, port number, username, and password.  Then you need to report them to Flink. Host, user, and password are mandatory and can be added to `requiredOptions()`; the port is optional and can be added to `optionalOptions()` instead.

```java
import org.apache.flink.configuration.ConfigOption;
import org.apache.flink.configuration.ConfigOptions;
import org.apache.flink.table.factories.DynamicTableSourceFactory;

import java.util.HashSet;
import java.util.Set;

public class ImapTableSourceFactory implements DynamicTableSourceFactory {

    public static final ConfigOption<String> HOST = ConfigOptions.key("host").stringType().noDefaultValue();
    public static final ConfigOption<Integer> PORT = ConfigOptions.key("port").intType().noDefaultValue();
    public static final ConfigOption<String> USER = ConfigOptions.key("user").stringType().noDefaultValue();
    public static final ConfigOption<String> PASSWORD = ConfigOptions.key("password").stringType().noDefaultValue();

    // …

    @Override
    public Set<ConfigOption<?>> requiredOptions() {
        final Set<ConfigOption<?>> options = new HashSet<>();
        options.add(HOST);
        options.add(USER);
        options.add(PASSWORD);
        return options;
    }

    @Override
    public Set<ConfigOption<?>> optionalOptions() {
        final Set<ConfigOption<?>> options = new HashSet<>();
        options.add(PORT);
        return options;
    }
    // …
}
```

Now take a look at the `createDynamicTableSource()` function in the `ImapTableSourceFactory` class.  Recall that previously (in part one) you used a small helper utility [TableFactoryHelper](https://ci.apache.org/projects/flink/flink-docs-release-1.13/api/java/org/apache/flink/table/factories/FactoryUtil.TableFactoryHelper.html), that Flink offers which ensures that required options are set and that no unknown options are provided. You can now use it to automatically make sure that the required options of hostname, port number, username, and password are all provided when creating a table using this connector. The helper function will throw an error message if one required option is missing. You can also use it to access the provided options (`getOptions()`), convert them into an instance of the `ImapTableSource` class created earlier, and provide the instance to the table source:

```java
import java.util.List;
import java.util.stream.Collectors;
import org.apache.flink.table.factories.DynamicTableSourceFactory;
import org.apache.flink.table.factories.FactoryUtil;
import org.apache.flink.table.catalog.Column;

public class ImapTableSourceFactory implements DynamicTableSourceFactory {

    // ...

    @Override
    public DynamicTableSource createDynamicTableSource(Context ctx) {
        final FactoryUtil.TableFactoryHelper factoryHelper = FactoryUtil.createTableFactoryHelper(this, ctx);
        factoryHelper.validate();

        final ImapSourceOptions options = ImapSourceOptions.builder()
            .host(factoryHelper.getOptions().get(HOST))
            .port(factoryHelper.getOptions().get(PORT))
            .user(factoryHelper.getOptions().get(USER))
            .password(factoryHelper.getOptions().get(PASSWORD))
            .build();

        final List<String> columnNames = ctx.getCatalogTable().getResolvedSchema().getColumns().stream()
            .filter(Column::isPhysical)
            .map(Column::getName)
            .collect(Collectors.toList());

        return new ImapTableSource(options, columnNames);
    }
}
```
<div class="note">
  <h5>Hint</h5>
  <p>
    Ideally, you would use connector <a href="https://ci.apache.org/projects/flink/flink-docs-release-1.13/docs/connectors/table/overview/#metadata">metadata</a> instead of column names. You can refer again to the accompanying <a href="https://github.com/TNG/flink-connector-email">repository</a> which does implement this using metadata fields.
  </p>
</div>

To test these new configuration options, run:

```sh
$ cd testing/
$ ./build_and_run.sh
```

Once you see the [Flink SQL client](https://ci.apache.org/projects/flink/flink-docs-release-1.13/docs/dev/table/sqlclient/) start up, execute the following statements to create a table with your connector:

```sql
CREATE TABLE T (subject STRING, content STRING) WITH ('connector' = 'imap');

SELECT * FROM T;
```

This time it will fail because the required options are not provided:

```
[ERROR] Could not execute SQL statement. Reason:
org.apache.flink.table.api.ValidationException: One or more required options are missing.

Missing required options are:

host
password
user
```

#  Connect to the source email server

Now that you have configured the required options to connect to the email server, it is time to actually connect to the server.

Going back to the `ImapSource` class, you first need to convert the options given to the table source into a [Properties](https://docs.oracle.com/javase/tutorial/essential/environment/properties.html) object, which is what you can pass to the Jakarta library. You can also set various other properties here as well (i.e. enabling SSL).

The specific properties that the Jakarta library understands are documented [here](https://jakarta.ee/specifications/mail/1.6/apidocs/index.html?com/sun/mail/imap/package-summary.html).


```java
import org.apache.flink.streaming.api.functions.source.RichSourceFunction;
import org.apache.flink.table.data.RowData;
import java.util.Properties;

public class ImapSource extends RichSourceFunction<RowData> {
   // …

   private Properties getSessionProperties() {
        Properties props = new Properties();
        props.put("mail.store.protocol", "imap");
        props.put("mail.imap.auth", true);
        props.put("mail.imap.host", options.getHost());
        if (options.getPort() != null) {
            props.put("mail.imap.port", options.getPort());
        }

        return props;
    }
}
```

Now create a method (`connect()`) which sets up the connection:

```java
import jakarta.mail.*;
import com.sun.mail.imap.IMAPFolder;
import org.apache.flink.streaming.api.functions.source.RichSourceFunction;
import org.apache.flink.table.data.RowData;

public class ImapSource extends RichSourceFunction<RowData> {
    // …

    private transient Store store;
    private transient IMAPFolder folder;

    private void connect() throws Exception {
        final Session session = Session.getInstance(getSessionProperties(), null);
        store = session.getStore();
        store.connect(options.getUser(), options.getPassword());

        final Folder genericFolder = store.getFolder("INBOX");
        folder = (IMAPFolder) genericFolder;

        if (!folder.isOpen()) {
            folder.open(Folder.READ_ONLY);
        }
    }
}
```

You can now use this method to connect to the mail server when the source is created. Create a loop to keep the source running while collecting email counts. Lastly, implement methods to cancel and close the connection:

```java
import jakarta.mail.*;
import org.apache.flink.streaming.api.functions.source.RichSourceFunction;
import org.apache.flink.streaming.api.functions.source.SourceFunction;
import org.apache.flink.table.data.RowData;

public class ImapSource extends RichSourceFunction<RowData> {
    private transient volatile boolean running = false;

    // …

    @Override
    public void run(SourceFunction.SourceContext<RowData> ctx) throws Exception {
        connect();
        running = true;

        // TODO: Listen for new messages

        while (running) {
            // Trigger some IMAP request to force the server to send a notification
            folder.getMessageCount();
            Thread.sleep(250);
        }
    }

    @Override
    public void cancel() {
        running = false;
    }

    @Override
    public void close() throws Exception {
        if (folder != null) {
            folder.close();
        }

        if (store != null) {
            store.close();
        }
    }
}
```

There is a request trigger to the server in every loop iteration. This is crucial as it ensures that the server will keep sending notifications. A more sophisticated approach would be to make use of the IDLE protocol.

<div class="note">
  <h5>Note</h5>
  <p>Since the source is not checkpointable, no state fault tolerance will be possible.</p>
</div>


## Collect incoming emails

Now you need to listen for new emails arriving in the inbox folder and collect them. To begin, hardcode the schema and only return the email’s subject. Fortunately, Jakarta provides a simple hook (`addMessageCountListener()`) to get notified when new messages arrive on the server. You can use this in place of the “TODO” comment above:

```java
import jakarta.mail.*;
import jakarta.mail.event.MessageCountAdapter;
import jakarta.mail.event.MessageCountEvent;
import org.apache.flink.streaming.api.functions.source.RichSourceFunction;
import org.apache.flink.table.data.GenericRowData;
import org.apache.flink.table.data.StringData;
import org.apache.flink.table.data.RowData;

public class ImapSource extends RichSourceFunction<RowData> {
    @Override
    public void run(SourceFunction.SourceContext<RowData> ctx) throws Exception {
        // …

        folder.addMessageCountListener(new MessageCountAdapter() {
            @Override
            public void messagesAdded(MessageCountEvent e) {
                collectMessages(ctx, e.getMessages());
            }
        });

        // …
    }

    private void collectMessages(SourceFunction.SourceContext<RowData> ctx, Message[] messages) {
        for (Message message : messages) {
            try {
                ctx.collect(GenericRowData.of(StringData.fromString(message.getSubject())));
            } catch (MessagingException ignored) {}
        }
    }
}
```

Now build the project again and start up the SQL client:

```sh
$ cd testing/
$ ./build_and_run.sh
```

This time, you will connect to a [GreenMail server](https://greenmail-mail-test.github.io/greenmail/) which is started as part of the [setup](https://github.com/Airblader/blog-imap/blob/master/testing/docker-compose.yaml):

```sql
CREATE TABLE T (
    subject STRING
) WITH (
    'connector' = 'imap',
    'host' = 'greenmail',
    'port' = '3143',
    'user' = 'alice',
    'password' = 'alice'
);

SELECT * FROM T;
```

The query above should now run continuously but no rows will be produced since it is a test server. You need to first send an email to the server. If you have [mailx](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/mailx.html) installed, you can do so by executing in your terminal:

```sh
$ echo "This is the email body" | mailx -Sv15-compat \
        -s"Email Subject" \
        -Smta="smtp://alice:alice@localhost:3025" \
        alice@acme.org
```

The row “Email Subject” should now have appeared as a row in your output. Your source connector is working!

However, since you are still hard-coding the schema produced by the source, defining the table with a different schema will produce errors. You want to be able to define which fields of an email interest you and then produce the data accordingly. To do this, you will use the list of column names from earlier and then look at it when you collect the emails.

```java
import org.apache.flink.table.data.GenericRowData;
import org.apache.flink.table.data.RowData;
import org.apache.flink.table.data.TimestampData;

public class ImapSource extends RichSourceFunction<RowData> {

    private void collectMessages(SourceFunction.SourceContext<RowData> ctx, Message[] messages) {
        for (Message message : messages) {
            try {
                collectMessage(ctx, message);
            } catch (MessagingException ignored) {}
        }
    }

    private void collectMessage(SourceFunction.SourceContext<RowData> ctx, Message message)
        throws MessagingException {
        final GenericRowData row = new GenericRowData(columnNames.size());

        for (int i = 0; i < columnNames.size(); i++) {
            switch (columnNames.get(i)) {
                case "SUBJECT":
                    row.setField(i, StringData.fromString(message.getSubject()));
                    break;
                case "SENT":
                    row.setField(i, TimestampData.fromInstant(message.getSentDate().toInstant()));
                    break;
                case "RECEIVED":
                    row.setField(i, TimestampData.fromInstant(message.getReceivedDate().toInstant()));
                    break;
                // ...
            }
        }

        ctx.collect(row);
    }
}
```

You should now have a working source where you can select any of the columns that are supported. Try it out again in the SQL client, but this time specifying all the columns ("subject", "sent", "received") supported above:

```sql
CREATE TABLE T (
    subject STRING,
    sent TIMESTAMP(3),
    received TIMESTAMP(3)
) WITH (
    'connector' = 'imap',
    'host' = 'greenmail',
    'port' = '3143',
    'user' = 'alice',
    'password' = 'alice'
);

SELECT * FROM T;
```

Use the `mailx` command from earlier to send emails to the GreenMail server and you should see them appear. You can also try selecting only some of the columns, or write more complex queries.


# Test the connector with a real mail server on the Ververica Platform

If you want to test the connector with a real mail server, you can import it into [Ververica Platform Community Edition](https://www.ververica.com/getting-started). To begin, make sure that you have the Ververica Platform up and running.

Since the example connector in this blog post is still a bit limited, you will use the finished connector in this [repository](github.com/TNG/flink-connector-email) instead. You can clone that repository and build it the same way to obtain the JAR file.

For this example, let's connect to a Gmail account. This requires SSL and comes with an additional caveat that you need to enable two-factor authentication and create an application password to use instead of your real password.

First, head to SQL → Connectors. There you can create a new connector by uploading your JAR file. The platform will detect the connector options automatically. Afterwards, go back to the SQL Editor and you should now be able to use the connector.

<div class="row front-graphic">
  <img src="{{< siteurl >}}/img/blog/2021-09-07-connector-table-sql-api/VVP-SQL-Editor.png" alt="Ververica Platform - SQL Editor"/>
	<p class="align-center">Ververica Platform - SQL Editor</p>
</div>


# Summary

Apache Flink is designed for easy extensibility and allows users to access many different external systems as data sources or sinks through a versatile set of connectors. It can read and write data from databases, local and distributed file systems.

Flink also exposes APIs on top of which custom connectors can be built. In this two-part blog series, you explored some of these APIs and concepts and learned how to implement your own custom source connector that can read in data from an email inbox. You then used Flink to process incoming emails through the IMAP protocol and wrote some Flink SQL.
