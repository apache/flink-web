---
title: İndirmeler
bookCollapseSection: false
weight: 5
menu_weight: 2
---
<!--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->

# Apache Flink® İndirmeleri

## Apache Flink

Apache Flink® {{< param FlinkStableVersion >}}, en son kararlı sürümdür.

{{% flink_download "flink" %}}

## Apache Flink konnektörleri

Bunlar, ana Flink sürümlerinden ayrı olarak yayınlanan konnektörlerdir.

{{% flink_download "flink_connectors" %}}

## Apache Flink CDC

Apache Flink® CDC {{< param FlinkCDCStableShortVersion >}}, en son kararlı sürümdür.

{{% flink_download "flink_cdc" %}}

## Apache Flink Stateful Functions

Apache Flink® Stateful Functions {{< param StateFunStableShortVersion >}}, en son kararlı sürümdür.

{{% flink_download "statefun" %}}

## Apache Flink ML

Apache Flink® ML {{< param FlinkMLStableShortVersion >}}, en son kararlı sürümdür.

{{% flink_download "flink_ml" %}}

## Apache Flink Kubernetes Operator

Apache Flink® Kubernetes Operator {{< param FlinkKubernetesOperatorStableShortVersion >}}, en son kararlı sürümdür.

{{% flink_download "flink_kubernetes_operator" %}}

## Ek Bileşenler

Bunlar, Flink projesinin geliştirdiği ve ana Flink sürümünün bir parçası olmayan bileşenlerdir:

{{% flink_download "additional_components" %}}

## Hash'leri ve İmzaları Doğrulama

Sürümlerimizle birlikte, `*.sha512` dosyalarında sha512 hash'leri ve `*.asc` dosyalarında kriptografik imzalar da sağlıyoruz. Apache Software Foundation, herhangi bir sürüm imzalama [KEYS](https://downloads.apache.org/flink/KEYS) dosyasını kullanarak takip edebileceğiniz kapsamlı bir [hash ve imza doğrulama eğitimi](http://www.apache.org/info/verification.html) sunmaktadır.

## Maven Bağımlılıkları

### Apache Flink

Projenize Apache Flink'i dahil etmek için `pom.xml` dosyanıza aşağıdaki bağımlılıkları ekleyebilirsiniz. Bu bağımlılıklar yerel bir yürütme ortamı içerir ve böylece yerel testleri destekler.

- **Scala API**: Scala API'sini kullanmak için, `flink-java` artifact id'sini `flink-scala_2.12` ile ve `flink-streaming-java`'yı `flink-streaming-scala_2.12` ile değiştirin.

```xml
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-java</artifactId>
  <version>{{< param FlinkStableVersion >}}</version>
</dependency>
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-streaming-java</artifactId>
  <version>{{< param FlinkStableVersion >}}</version>
</dependency>
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-clients</artifactId>
  <version>{{< param FlinkStableVersion >}}</version>
</dependency>
```

### Apache Flink Stateful Functions

Projenize Apache Flink Stateful Functions'ı dahil etmek için `pom.xml` dosyanıza aşağıdaki bağımlılıkları ekleyebilirsiniz.

```xml
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>statefun-sdk</artifactId>
  <version>{{< param StateFunStableVersion >}}</version>
</dependency>
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>statefun-flink-harness</artifactId>
  <version>{{< param StateFunStableVersion >}}</version>
</dependency>
```

`statefun-sdk` bağımlılığı, uygulamalar geliştirmeye başlamak için ihtiyacınız olan tek bağımlılıktır.
`statefun-flink-harness` bağımlılığı, uygulamanızı bir IDE'de yerel olarak test etmenizi sağlayan yerel bir yürütme ortamı içerir.

### Apache Flink ML

Projenize Apache Flink ML'yi dahil etmek için `pom.xml` dosyanıza aşağıdaki bağımlılıkları ekleyebilirsiniz.

```xml
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-ml-core</artifactId>
  <version>{{< param FlinkMLStableVersion >}}</version>
</dependency>
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-ml-iteration</artifactId>
  <version>{{< param FlinkMLStableVersion >}}</version>
</dependency>
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-ml-lib</artifactId>
  <version>{{< param FlinkMLStableVersion >}}</version>
</dependency>
```

İleri düzey kullanıcılar, hedef kullanım senaryoları için yalnızca minimum Flink ML bağımlılık setini içe aktarabilirler:

- Özel ML algoritmaları geliştirmek için `flink-ml-core` artifact'ini kullanın.
- İterasyon gerektiren özel ML algoritmaları geliştirmek için `flink-ml-core` ve `flink-ml-iteration` artifact'lerini kullanın.
- Flink ML'den hazır ML algoritmalarını kullanmak için `flink-ml-lib` artifact'ini kullanın.

### Apache Flink Kubernetes Operator

Projenize Apache Flink Kubernetes Operator'ı dahil etmek için `pom.xml` dosyanıza aşağıdaki bağımlılıkları ekleyebilirsiniz.

```xml
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-kubernetes-operator</artifactId>
  <version>{{< param FlinkKubernetesOperatorStableVersion >}}</version>
</dependency>
```

## Eski sürümler için Güncelleme Politikası

Mart 2017 itibariyle, Flink topluluğu mevcut ve önceki küçük sürümü hata düzeltmeleri ile destekleme [kararı aldı](https://lists.apache.org/thread/qf4hot3gb1dgvh4csxv2317263b6omm4). Eğer 1.2.x mevcut sürüm ise, 1.1.y desteklenen önceki küçük sürümdür. Her iki sürüm de kritik sorunlar için hata düzeltmeleri alacaktır.

Mart 2023 itibariyle, Flink topluluğu yeni bir Flink küçük sürümünün yayınlanmasıyla birlikte, desteğini kaybeden Flink küçük sürümündeki çözülmüş kritik/engelleyici sorunlar için son bir hata düzeltme sürümü yapma [kararı aldı](https://lists.apache.org/thread/9w99mgx3nw5tc0v26wcvlyqxrcrkpzdz). Eğer 1.16.1 mevcut sürüm ve 1.15.4 en son önceki yama sürümü ise, 1.17.0 yayınlandığında çözülmüş kritik/engelleyici sorunları temizlemek için bir 1.15.5 oluşturacağız.

Topluluğun her zaman daha eski sürümler için hata düzeltme sürümlerini tartışmaya açık olduğunu unutmayın. Bunun için lütfen geliştiricilerle dev@flink.apache.org e-posta listesinden iletişime geçin.

## Tüm kararlı sürümler

Tüm Flink sürümleri, sağlama toplamları ve kriptografik imzalar dahil olmak üzere [https://archive.apache.org/dist/flink/](https://archive.apache.org/dist/flink/) üzerinden erişilebilir. Yazı yazıldığı sırada, bu aşağıdaki sürümleri içermektedir:

{{% flink_archive "release_archive" %}}