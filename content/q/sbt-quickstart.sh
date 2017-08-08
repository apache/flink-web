#!/bin/bash

################################################################################
#  Licensed to the Apache Software Foundation (ASF) under one
#  or more contributor license agreements.  See the NOTICE file
#  distributed with this work for additional information
#  regarding copyright ownership.  The ASF licenses this file
#  to you under the Apache License, Version 2.0 (the
#  "License"); you may not use this file except in compliance
#  with the License.  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
# limitations under the License.
################################################################################

declare -r TRUE=0
declare -r FALSE=1

# takes a string and returns true if it seems to represent "yes"
function isYes() {
  local x=$1
  [ $x = "y" -o $x = "Y" -o $x = "yes" ] && echo $TRUE; return
  echo $FALSE
}

function mkDir() {
  local x=$1
  echo ${x// /-} | tr '[:upper:]' '[:lower:]'
}

function mkPackage() {
  local x=$1
  echo ${x//./\/}
}

defaultProjectName="Flink Project"
defaultOrganization="org.example"
defaultVersion="0.1-SNAPSHOT"
defaultScalaVersion="2.11.7"
defaultFlinkVersion="1.3.2"

echo "This script creates a Flink project using Scala and SBT."

while [ $TRUE ]; do

  echo ""
  read -p "Project name ($defaultProjectName): " projectName
  projectName=${projectName:-$defaultProjectName}
  read -p "Organization ($defaultOrganization): " organization
  organization=${organization:-$defaultOrganization}
  read -p "Version ($defaultVersion): " version
  version=${version:-$defaultVersion}
  read -p "Scala version ($defaultScalaVersion): " scalaVersion
  scalaVersion=${scalaVersion:-$defaultScalaVersion}
  read -p "Flink version ($defaultFlinkVersion): " flinkVersion
  flinkVersion=${flinkVersion:-$defaultFlinkVersion}

  echo ""
  echo "-----------------------------------------------"
  echo "Project Name: $projectName"
  echo "Organization: $organization"
  echo "Version: $version"
  echo "Scala version: $scalaVersion"
  echo "Flink version: $flinkVersion"
  echo "-----------------------------------------------"
  read -p "Create Project? (Y/n): " createProject
  createProject=${createProject:-y}

  [ "$(isYes "$createProject")" = "$TRUE" ] && break

done

directoryName=$(mkDir "$projectName")

echo "Creating Flink project under $directoryName"

mkdir -p ${directoryName}/src/main/{resources,scala}
mkdir -p ${directoryName}/project

# Create the README file

echo "A Flink application project using Scala and SBT.

To run and test your application use SBT invoke: 'sbt run'

In order to run your application from within IntelliJ, you have to select the classpath of the 'mainRunner' module in the run/debug configurations. Simply open 'Run -> Edit configurations...' and then select 'mainRunner' from the "Use classpath of module" dropbox." > ${directoryName}/README

# Create the build.sbt file

echo "resolvers in ThisBuild ++= Seq(\"Apache Development Snapshot Repository\" at \"https://repository.apache.org/content/repositories/snapshots/\", Resolver.mavenLocal)

name := \"$projectName\"

version := \"$version\"

organization := \"$organization\"

scalaVersion in ThisBuild := \"$scalaVersion\"

val flinkVersion = \"$flinkVersion\"

val flinkDependencies = Seq(
  \"org.apache.flink\" %% \"flink-scala\" % flinkVersion % \"provided\",
  \"org.apache.flink\" %% \"flink-streaming-scala\" % flinkVersion % \"provided\")

lazy val root = (project in file(\".\")).
  settings(
    libraryDependencies ++= flinkDependencies
  )

mainClass in assembly := Some(\"$organization.Job\")

// make run command include the provided dependencies
run in Compile <<= Defaults.runTask(fullClasspath in Compile, mainClass in (Compile, run), runner in (Compile, run))

// exclude Scala library from assembly
assemblyOption in assembly := (assemblyOption in assembly).value.copy(includeScala = false)" > ${directoryName}/build.sbt

# Create idea.sbt file for mainRunner module for IntelliJ

echo "lazy val mainRunner = project.in(file(\"mainRunner\")).dependsOn(RootProject(file(\".\"))).settings(
  // we set all provided dependencies to none, so that they are included in the classpath of mainRunner
  libraryDependencies := (libraryDependencies in RootProject(file(\".\"))).value.map{
    module =>
      if (module.configurations.equals(Some(\"provided\"))) {
        module.copy(configurations = None)
      } else {
        module
      }
  }
)" > ${directoryName}/idea.sbt

# Create assembly plugin file

echo "addSbtPlugin(\"com.eed3si9n\" % \"sbt-assembly\" % \"0.14.1\")" > ${directoryName}/project/assembly.sbt

# Create package structure

mkdir -p ${directoryName}/src/main/scala/$(mkPackage $organization)

# Create simple job skeleton

echo "package $organization

/**
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * \"License\"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an \"AS IS\" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import org.apache.flink.api.scala._

/**
 * Skeleton for a Flink Job.
 *
 * You can also generate a .jar file that you can submit on your Flink
 * cluster. Just type
 * {{{
 *   sbt clean assembly
 * }}}
 * in the projects root directory. You will find the jar in
 * target/scala-2.11/Flink\ Project-assembly-0.1-SNAPSHOT.jar
 *
 */
object Job {
  def main(args: Array[String]) {
    // set up the execution environment
    val env = ExecutionEnvironment.getExecutionEnvironment

    /**
     * Here, you can start creating your execution plan for Flink.
     *
     * Start with getting some data from the environment, like
     * env.readTextFile(textPath);
     *
     * then, transform the resulting DataSet[String] using operations
     * like:
     *   .filter()
     *   .flatMap()
     *   .join()
     *   .group()
     *
     * and many more.
     * Have a look at the programming guide:
     *
     * http://flink.apache.org/docs/latest/programming_guide.html
     *
     * and the examples
     *
     * http://flink.apache.org/docs/latest/examples.html
     *
     */


    // execute program
    env.execute(\"Flink Scala API Skeleton\")
  }
}" > ${directoryName}/src/main/scala/$(mkPackage $organization)/Job.scala

# Create WordCount example

echo "package $organization

/**
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * \"License\"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an \"AS IS\" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import org.apache.flink.api.scala._

/**
 * Implements the \"WordCount\" program that computes a simple word occurrence histogram
 * over some sample data
 *
 * This example shows how to:
 *
 *   - write a simple Flink program.
 *   - use Tuple data types.
 *   - write and use user-defined functions.
 */
object WordCount {
  def main(args: Array[String]) {

    // set up the execution environment
    val env = ExecutionEnvironment.getExecutionEnvironment

    // get input data
    val text = env.fromElements(\"To be, or not to be,--that is the question:--\",
      \"Whether 'tis nobler in the mind to suffer\", \"The slings and arrows of outrageous fortune\",
      \"Or to take arms against a sea of troubles,\")

    val counts = text.flatMap { _.toLowerCase.split(\"\\\\W+\") }
      .map { (_, 1) }
      .groupBy(0)
      .sum(1)

    // execute and print result
    counts.print()

  }
}
" > ${directoryName}/src/main/scala/$(mkPackage $organization)/WordCount.scala

# Create SocketTextStreamWordCount example

echo "package $organization

/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * \"License\"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an \"AS IS\" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import org.apache.flink.streaming.api.scala._

/**
 * This example shows an implementation of WordCount with data from a text socket.
 * To run the example make sure that the service providing the text data is already up and running.
 *
 * To start an example socket text stream on your local machine run netcat from a command line,
 * where the parameter specifies the port number:
 *
 * {{{
 *   nc -lk 9999
 * }}}
 *
 * Usage:
 * {{{
 *   SocketTextStreamWordCount <hostname> <port> <output path>
 * }}}
 *
 * This example shows how to:
 *
 *   - use StreamExecutionEnvironment.socketTextStream
 *   - write a simple Flink Streaming program in scala.
 *   - write and use user-defined functions.
 */
object SocketTextStreamWordCount {

  def main(args: Array[String]) {
    if (args.length != 2) {
      System.err.println(\"USAGE:\nSocketTextStreamWordCount <hostname> <port>\")
      return
    }

    val hostName = args(0)
    val port = args(1).toInt

    val env = StreamExecutionEnvironment.getExecutionEnvironment

    //Create streams for names and ages by mapping the inputs to the corresponding objects
    val text = env.socketTextStream(hostName, port)
    val counts = text.flatMap { _.toLowerCase.split(\"\\\\W+\") filter { _.nonEmpty } }
      .map { (_, 1) }
      .keyBy(0)
      .sum(1)

    counts print

    env.execute(\"Scala SocketTextStreamWordCount Example\")
  }

}
" > ${directoryName}/src/main/scala/$(mkPackage $organization)/SocketTextStreamWordCount.scala
