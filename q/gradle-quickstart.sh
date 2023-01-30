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

defaultProjectName="quickstart"
defaultOrganization="org.myorg.quickstart"
defaultVersion="0.1-SNAPSHOT"
defaultFlinkVersion="${1:-1.16.1}"
# flink-docs-master/docs/dev/datastream/project-configuration/#gradle
# passes the scala version prefixed with a _, e.g.: _2.12
scalaBinaryVersionFromCmdArg="${2/_/}"
defaultScalaBinaryVersion="${scalaBinaryVersionFromCmdArg:-2.12}"

echo "This script creates a Flink project using Java and Gradle."

while [ $TRUE ]; do

  echo ""
  read -p "Project name ($defaultProjectName): " projectName
  projectName=${projectName:-$defaultProjectName}
  read -p "Organization ($defaultOrganization): " organization
  organization=${organization:-$defaultOrganization}
  read -p "Version ($defaultVersion): " version
  version=${version:-$defaultVersion}
  read -p "Flink version ($defaultFlinkVersion): " flinkVersion
  flinkVersion=${flinkVersion:-$defaultFlinkVersion}
  read -p "Scala version ($defaultScalaBinaryVersion): " scalaBinaryVersion
  scalaBinaryVersion=${scalaBinaryVersion:-$defaultScalaBinaryVersion}

  echo ""
  echo "-----------------------------------------------"
  echo "Project Name: ${projectName}"
  echo "Organization: ${organization}"
  echo "Version: ${version}"
  echo "Scala binary version: ${scalaBinaryVersion}"
  echo "Flink version: ${flinkVersion}"
  echo "-----------------------------------------------"
  read -p "Create Project? (Y/n): " createProject
  createProject=${createProject:-y}

  [ "$(isYes "${createProject}")" = "$TRUE" ] && break

done

directoryName=$(mkDir "${projectName}")

echo "Creating Flink project under ${directoryName}"

mkdir -p ${directoryName}
cd ${directoryName}

# Create the README file

cat > README <<EOF
A Flink application project using Java and Gradle.

To package your job for submission to Flink, use: 'gradle shadowJar'. Afterwards, you'll find the
jar to use in the 'build/libs' folder.

To run and test your application with an embedded instance of Flink use: 'gradle run'
EOF

# Create the gradle build files

cat > settings.gradle <<EOF
rootProject.name = '${projectName}'
EOF

cat > build.gradle <<EOF
plugins {
    id 'java'
    id 'application'
    // shadow plugin to produce fat JARs
    id 'com.github.johnrengelman.shadow' version '7.1.2'
}

ext {
    javaVersion = '1.8'
    flinkVersion = '${flinkVersion}'
    scalaBinaryVersion = '${scalaBinaryVersion}'
    slf4jVersion = '1.7.36'
    log4jVersion = '2.17.1'
    flinkVersionNew = flinkVersion.toString().replace("-SNAPSHOT", "") >= "1.16"
}

// artifact properties
group = '${organization}'
version = '${version}'
if (flinkVersionNew) {
    mainClassName = '${organization}.DataStreamJob'
} else {
    mainClassName = '${organization}.StreamingJob'
}
description = """Flink Quickstart Job"""

sourceCompatibility = javaVersion
targetCompatibility = javaVersion
tasks.withType(JavaCompile) {
    options.encoding = 'UTF-8'
}

applicationDefaultJvmArgs = ["-Dlog4j.configurationFile=log4j2.properties"]

// declare where to find the dependencies of your project
repositories {
    mavenCentral()
    maven {
        url "https://repository.apache.org/content/repositories/snapshots"
        mavenContent {
            snapshotsOnly()
        }
    }
}

// NOTE: We cannot use "compileOnly" or "shadow" configurations since then we could not run code
// in the IDE or with "gradle run". We also cannot exclude transitive dependencies from the
// shadowJar yet (see https://github.com/johnrengelman/shadow/issues/159).
// -> Explicitly define the // libraries we want to be included in the "flinkShadowJar" configuration!
configurations {
    flinkShadowJar // dependencies which go into the shadowJar

    // always exclude these (also from transitive dependencies) since they are provided by Flink
    flinkShadowJar.exclude group: 'org.apache.flink', module: 'force-shading'
    flinkShadowJar.exclude group: 'com.google.code.findbugs', module: 'jsr305'
    flinkShadowJar.exclude group: 'org.slf4j'
    flinkShadowJar.exclude group: 'org.apache.logging.log4j'
}

// declare the dependencies for your production and test code
dependencies {
    // --------------------------------------------------------------
    // Compile-time dependencies that should NOT be part of the
    // shadow jar and are provided in the lib folder of Flink
    // --------------------------------------------------------------
    if (flinkVersionNew) {
        implementation "org.apache.flink:flink-streaming-java:\${flinkVersion}"
        implementation "org.apache.flink:flink-clients:\${flinkVersion}"
    } else {
        implementation "org.apache.flink:flink-streaming-java_\${scalaBinaryVersion}:\${flinkVersion}"
        implementation "org.apache.flink:flink-clients_\${scalaBinaryVersion}:\${flinkVersion}"
    }

    // --------------------------------------------------------------
    // Dependencies that should be part of the shadow jar, e.g.
    // connectors. These must be in the flinkShadowJar configuration!
    // --------------------------------------------------------------
    //flinkShadowJar "org.apache.flink:flink-connector-kafka:\${flinkVersion}"

    runtimeOnly "org.apache.logging.log4j:log4j-slf4j-impl:\${log4jVersion}"
    runtimeOnly "org.apache.logging.log4j:log4j-api:\${log4jVersion}"
    runtimeOnly "org.apache.logging.log4j:log4j-core:\${log4jVersion}"

    // Add test dependencies here.
    // testCompile "junit:junit:4.12"
}

// make compileOnly dependencies available for tests:
sourceSets {
    main.compileClasspath += configurations.flinkShadowJar
    main.runtimeClasspath += configurations.flinkShadowJar

    test.compileClasspath += configurations.flinkShadowJar
    test.runtimeClasspath += configurations.flinkShadowJar

    javadoc.classpath += configurations.flinkShadowJar
}

run.classpath = sourceSets.main.runtimeClasspath

jar {
    manifest {
        attributes 'Built-By': System.getProperty('user.name'),
                'Build-Jdk': System.getProperty('java.version')
    }
}

shadowJar {
    configurations = [project.configurations.flinkShadowJar]
}
EOF

# Download mvn quickstart template
if [[ "${flinkVersion}" == *-SNAPSHOT ]] ; then
    repopath=https://repository.apache.org/content/repositories/snapshots/org/apache/flink/flink-quickstart-java/
    build=`curl -s ${repopath}${flinkVersion}/maven-metadata.xml | grep '<value>' | head -1 | sed "s/.*<value>\([^<]*\)<\/value>.*/\1/"`
    quickstartJar=flink-quickstart-java-${build}.jar
else
    repopath=https://repository.apache.org/content/repositories/releases/org/apache/flink/flink-quickstart-java/
    quickstartJar=flink-quickstart-java-${flinkVersion}.jar
fi
quickstartJarUrl=${repopath}${flinkVersion}/${quickstartJar}

echo "Downloading QuickStart files from ${quickstartJarUrl}"
if curl -f "${quickstartJarUrl}" --output "${quickstartJar}" ; then
  echo "Extracting QuickStart files"
  jar xf "${quickstartJar}" archetype-resources/src
  rm "${quickstartJar}"
else
  echo "Failed to download ${quickstartJarUrl}"
  cd - >/dev/null
  exit 1
fi

# replace template variables and put files into the right folders

mkdir -p src/main/java/$(mkPackage ${organization})

find archetype-resources/src -name "*.java*" -exec bash -c 'sed "s/\${package}/${1}/g" < ${0} > "$(dirname ${0#archetype-resources/})/${2}/$(basename ${0#archetype-resources/})"' "{}" "${organization}" "$(mkPackage ${organization})" \;
mv archetype-resources/src/main/resources src/main/
rm -rf archetype-resources

echo "Done."

cd - >/dev/null
