---
title: Yol Haritası
bookCollapseSection: false
weight: 6
aliases:
- /roadmap.html
- /roadmap/index.html
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

# Yol Haritası

**Önsöz:** Bu yol haritası, kullanıcılara ve katkıda bulunanlara, çabaların ait olduğu ana başlıklar altında gruplandırılmış devam eden çalışmaların yüksek düzeyde bir özetini sunmayı amaçlamaktadır. Flink'te bu kadar çok şey olup biterken, bu yol haritasının projenin yönünü anlamaya yardımcı olacağını umuyoruz. Yol haritası, hem erken aşamadaki çabaları hem de neredeyse tamamlanmış çabaları içermektedir, böylece kullanıcılar bu gelişmelerin genel durumu ve yönü hakkında daha iyi bir izlenim edinebilirler.

Daha fazla ayrıntı ve çeşitli küçük değişiklikler [FLIPs](https://cwiki.apache.org/confluence/display/FLINK/Flink+Improvement+Proposals) sayfasında bulunabilir.

Yol haritası sürekli olarak güncellenmektedir. Kullanıcı için nasıl görüneceği konusunda fikir birliğine varıldığında ve kabaca neye benzeyeceğine karar verildiğinde, yeni özellikler ve çabalar yol haritasına eklenmelidir.

**Son Güncelleme:** 2023-09-01

## Feature Radar

Özellik radarı, kullanıcılara özellik olgunluğu ve hangi özelliklerin kullanım ömrünün sonuna yaklaştığı konusunda rehberlik etmeyi amaçlamaktadır. Sorularınız için lütfen geliştirici posta listesiyle iletişime geçin:
[dev@flink.apache.org](mailto:dev@flink.apache.org)

<div>
  {{< img src="/img/flink_feature_radar_4.svg" width="700px" >}}
</div>

#### Feature Stages

- **MVP:** Bir göz atın, gelecekte size yardımcı olup olamayacağını değerlendirin.
- **Beta:** Bundan faydalanabilirsiniz, ancak özelliği dikkatle değerlendirmelisiniz.
- **Ready and Evolving:** Üretimde kullanıma hazır, ancak Flink'i yükselttiğinizde gelecekte uygulamanızda ve kurulumunuzda bazı ayarlamalar yapmanız gerekebileceğini unutmayın.
- **Stable:** Üretimde sınırsız kullanım
- **Approaching End-of-Life:** Kararlı, hala kullanmakta serbestsiniz, ancak alternatifleri düşünün. Yeni uzun ömürlü projeler için iyi bir eşleşme değil.
- **Deprecated:** Şimdi alternatifleri aramaya başlayın

## Odaklandığımız Senaryolar

### Batch / Streaming Unification and Mixing

Flink, özünde "toplu işlemeyi akışın özel bir durumu olarak" yürüten bir akış veri sistemidir. Toplu işlerin verimli yürütülmesi kendi başına güçlüdür; ancak daha da önemlisi, toplu işleme yetenekleri (sınırlı akışların verimli işlenmesi), toplu ve akış uygulamalarının sorunsuz bir şekilde birleştirilmesi için yol açar.
Birleştirilmiş akış/toplu işleme, akış veri paradigmasını daha üst bir seviyeye taşır: Kullanıcılara gerçek zamanlı ve gecikmeli uygulamaları arasında tutarlı semantik sağlar. Ayrıca, akış uygulamalarının genellikle toplu (sınırlı akış) işlemeyle tamamlanması gerekir, örneğin hatalardan veya veri kalitesi sorunlarından sonra verileri yeniden işlerken ya da yeni uygulamaları başlatırken. Birleştirilmiş bir API ve sistem bunu çok daha kolay hale getirir.

Hem DataStream API hem de SQL, aynı uygulamayı toplu ve akış modlarında yürütmek için birleşik API sağlar. Birleştirmeyi çok daha sorunsuz hale getirmek için birleşik Source API ([FLIP-27](https://cwiki.apache.org/confluence/display/FLINK/FLIP-27%3A+Refactor+Source+Interface)) ve SinkV2 API ([FLIP-191](https://cwiki.apache.org/confluence/display/FLINK/FLIP-191%3A+Extend+unified+Sink+interface+to+support+small+file+compaction)) gibi bazı çabalar olmuştur. Birleştirmenin ötesinde, bir adım daha ileri gitmek istiyoruz. Amacımız, gelecekte sorunsuz bir deneyim sağlamak için toplu/akış yürütme arasında karıştırma ve geçiş yapmaktır. Bazı görevler tamamlandığında ve sınırlı akış programları son bir kontrol noktasıyla kapandığında kontrol noktası oluşturmayı destekliyoruz ([FLIP-147](https://cwiki.apache.org/confluence/display/FLINK/FLIP-147%3A+Support+Checkpoints+After+Tasks+Finished)). Karışık toplu/akış yürütmeye sahip işler hakkında ilk tartışmalar ve tasarımlar var, bu nedenle bu alandaki daha fazla haber için takipte kalın.

- Geçmiş verilerin sınırlı akışını ve artımlı verilerin sınırsız akışını işlemek için dinamik kontrol noktası aralığı ([FLIP-309](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=255069517)).
- Bir akıştaki sınırlı kısmın ve sınırsız kısmın sınırı için olay bildirim mekanizması. Bu, [FLINK-19830](https://issues.apache.org/jira/browse/FLINK-19830) gibi birçok heyecan verici özelliğin ve iyileştirmenin önünü açabilir.
- Son bir kontrol noktasına sahip bir toplu işle (sınırlı akış programı) durumları önyükleme ve kontrol noktasından ve durumdan bir akış işiyle (sınırsız akış programı) işlemeye devam etme.

### Unified SQL Platform 

Topluluk, Flink'i birleşik (toplu ve akış) SQL analitik platformu için güçlü bir temel haline getirmek için çalışmaktadır ve bunu yapmaya devam etmektedir.

SQL, kullanıcılara ad-hoc analizler ve sürekli sorgular için aynı sorguları kullanmasına olanak tanıyan çok güçlü çapraz-toplu-akış semantiğine sahiptir. Flink zaten verimli bir birleşik sorgu motoru ve geniş bir entegrasyon seti içerir. Kullanıcı geri bildirimleriyle, bunlar sürekli olarak iyileştirilmektedir.

#### SQL Stream/Batch İşleme Motorunun Ötesine Geçmek

- Flink SQL tabanlı işleri güncelleme deneyimi oldukça zahmetli olmuştur, çünkü savepoints/checkpoints'ten geri yüklemeyi imkansız hale getiren yeni iş grafikleri oluşturabilirdi. Halihazırda MVP olarak gönderilen [FLIP-190](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=191336489) bunu hedeflemektedir.
- Stream-batch işleme motorunun yeteneklerini genişletmek ve Flink'i birleşik SQL platformu için hazır hale getirmek için, Flink'in veri ve metadatayı daha iyi yönetmesine olanak tanıyan devam eden bir çaba var, bunlar arasında [DELETE/UPDATE](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=235838061), [Call Procedures](https://cwiki.apache.org/confluence/display/FLINK/FLIP-311%3A+Support+Call+Stored+Procedure), [rich DDLs](https://cwiki.apache.org/confluence/display/FLINK/FLIP-305%3A+Support+atomic+for+CREATE+TABLE+AS+SELECT%28CTAS%29+statement), [Time Travel](https://cwiki.apache.org/confluence/display/FLINK/FLIP-308%3A+Support+Time+Travel) ve benzerleri bulunmaktadır. Bu, özellikle Flink ve Paimon/Iceberg/Hudi ile bir lakehouse oluşturmak için yararlıdır.
- Flink SQL için JSON veri tipini desteklemek üzere bazı ilk tartışmalar var. Bu, Flink SQL'in yarı yapılandırılmış verileri daha iyi analiz etmesini ve NoSQL veritabanlarına daha iyi uyum sağlamasını sağlayabilir.

#### Platform Altyapısı

- [FLIP-163](https://cwiki.apache.org/confluence/display/FLINK/FLIP-163%3A+SQL+Client+Improvements)'ten sonra topluluk, SQL istemcisini kullanırken kullanıcı deneyimini iyileştirmeyi amaçlayan bir dizi SQL İstemcisi kullanılabilirlik iyileştirmesi ([FLIP-189](https://cwiki.apache.org/confluence/display/FLINK/FLIP-189%3A+SQL+Client+Usability+Improvements), [FLIP-222](https://cwiki.apache.org/confluence/display/FLINK/FLIP-222%3A+Support+full+job+lifecycle+statements+in+SQL+client)) üzerinde yeniden çalışıyor.
- Flink ile üretim SQL platformlarının oluşturulmasını basitleştirmek için, [SQL Gateway](https://nightlies.apache.org/flink/flink-docs-master/docs/dev/table/sql-gateway/overview/) bileşenini Flink SQL platformunun hizmeti olarak iyileştiriyoruz. Bunun etrafında uygulama modunu desteklemek ([FLIP-316](https://cwiki.apache.org/confluence/display/FLINK/FLIP-316%3A+Introduce+SQL+Driver)), JDBC sürücü istemcisi ([FLIP-293](https://cwiki.apache.org/confluence/display/FLINK/FLIP-293%3A+Introduce+Flink+Jdbc+Driver+For+Sql+Gateway)), kalıcı katalog kaydı ([FLIP-295](https://cwiki.apache.org/confluence/display/FLINK/FLIP-295%3A+Support+lazy+initialization+of+catalogs+and+persistence+of+catalog+configurations#FLIP295:Supportlazyinitializationofcatalogsandpersistenceofcatalogconfigurations-Motivation)), kimlik doğrulama ve yüksek kullanılabilirlik dahil olmak üzere devam eden birçok heyecan verici özellik var.

#### Yaygın Diller için Destek

- Hive sözdizimi uyumluluğu, kullanıcıların mevcut Hive SQL görevlerini sorunsuz bir şekilde Flink'e taşımasına yardımcı olabilir ve Hive sözdizimi ile aşina olan kullanıcıların, Flink'te kayıtlı tabloları sorgulamak için Hive sözdizimini kullanarak SQL yazması kolaylaştırır. Şu ana kadar, Hive qtest suite kullanılarak ölçülen Hive sözdizimi uyumluluğu %94,1'e ulaşmıştır. Flink topluluğu, uyumluluğu ve yürütme performansını sürekli olarak iyileştirmektedir ([FLINK-29717](https://issues.apache.org/jira/browse/FLINK-29717)).
- [FLIP-216](https://cwiki.apache.org/confluence/display/FLINK/FLIP-216%3A++Introduce+pluggable+dialect+and+plan+for+migrating+Hive+dialect) ile şimdi Hive sözdizimi örneği üzerinde takılabilir SQL lehçeleri tanıtma girişimi var. Bu, Flink'in gelecekte örneğin Spark SQL ve PostgreSQL gibi diğer SQL lehçelerini desteklemesini kolaylaştırır.

### Streaming Warehouse'lara Doğru

Flink, akış işleme için önde gelen teknoloji ve fiili standart haline gelmiştir. Akış ve toplu veri işlemeyi birleştirme kavramı giderek daha fazla tanınmakta ve giderek daha fazla şirkette başarıyla uygulanmaktadır. Akış-toplu analitiği daha da birleştirmek için, Flink, Streaming Warehouse kavramını önermiştir. Bu yeni kavram, sadece hesaplamayı değil, aynı zamanda depolamayı da birleştirmeyi, verilerin gerçek zamanlı olarak akmasını ve işlenmesini sağlamayı amaçlamaktadır. Sonuç olarak, ambarındaki veriler her zaman günceldir ve bundan üretilen analizler veya içgörüler, işletmenin mevcut durumunu yansıtır. Bu, geleneksel veri ambarlarının avantajlarını gerçek zamanlı içgörülerle birleştirir.

Apache Flink topluluğu, akış-toplu birleşik depolama vizyonuyla Flink Table Store alt projesini ([FLIP-188](https://cwiki.apache.org/confluence/display/FLINK/FLIP-188%3A+Introduce+Built-in+Dynamic+Table+Storage)) başlattı. Proje hızla büyürken, Flink Table Store [Apache kuluçka merkezine katıldı](https://lists.apache.org/thread/pz5f9cvpyk4q9vltd7z088q5368v412t) ve [Apache Paimon](https://github.com/apache/incubator-paimon/) adında bağımsız bir proje oldu. Apache Paimon'un [dokümantasyon](https://paimon.apache.org/docs/master/project/roadmap/) altında kendi yol haritası vardır. Birleşik depolama, Flink'in akış-toplu birleşik uygulamaların performansını ve deneyimini iyileştirmesi için yol açar.

OLAP, Flink akış-toplu veri işlemeden sonra önemli bir senaryodur; kullanıcılar, akış ambarındaki verileri analiz etmek için bir OLAP motoruna ihtiyaç duyar. Flink, "OLAP'ı toplu işlemenin özel bir durumu olarak" yürütebilir ve topluluk, akış ve toplu işlemeyi etkilemeden kısa ömürlü işler için iyileştirme olasılığını keşfetmeye çalışmaktadır. Bu, sahip olunması güzel bir özelliktir ve Flink'in birleşik akış-toplu-OLAP veri işleme sistemi haline gelmesinde kullanıcılar için büyük değer sağlayacaktır.

Verimli bir akış ambarı oluşturmak için, Flink'te iyileştirilmesi gereken birçok şey var, örneğin:
- Veri ve metaveriyi yönetmek için zengin ambar API'lerini desteklemek, örneğin: CTAS/RTAS ([FLIP-303](https://cwiki.apache.org/confluence/display/FLINK/FLIP-303%3A+Support+REPLACE+TABLE+AS+SELECT+statement)), CALL ([FLIP-311](https://cwiki.apache.org/confluence/display/FLINK/FLIP-311%3A+Support+Call+Stored+Procedure)), TRUNCATE ([FLIP-302](https://cwiki.apache.org/confluence/display/FLINK/FLIP-302%3A+Support+TRUNCATE+TABLE+statement+in+batch+mode)) ve benzerleri.
- Akış sorguları için akış lakehouse'larında istatistiklerle CBO (cost-based optimizations).
- Akış sorguları için veri okuma ve işlemeyi azaltmak amacıyla akış lakehouse'taki düzen ve indeksleri en iyi şekilde kullanmak.
- OLAP sorgularını düşük gecikme ve eşzamanlı yürütme ile desteklemek için kısa ömürlü işlere yönelik iyileştirmeler.

## Engine Evolution

### Ayrıştırılmış Durum Yönetimi

Flink'in en büyük avantajlarından biri, verimli ve kullanımı kolay durum yönetimi mekanizmasıdır. Ancak bu mekanizma, doğduğundan beri çok az gelişmiştir ve bulut-yerel çağ için uygun değildir. Son birkaç sürümde, durum anlık görüntüsü alma prosedürünü (FLIP-76 [unaligned checkpoint](https://flink.apache.org/2020/10/15/from-aligned-to-unaligned-checkpoints-part-1-checkpoints-alignment-and-backpressure/), FLIP-158 [generic incremental checkpoint](https://flink.apache.org/2022/05/30/improving-speed-and-stability-of-checkpointing-with-generic-log-based-incremental-checkpoints/)) ve [state repartitioning](https://flink.apache.org/2022/10/28/announcing-the-release-of-apache-flink-1.16/#rocksdb-rescaling-improvement--rescaling-benchmark) iyileştirmek için önemli çabalar sarf ettik. Bunu yaparken, özellikle büyük durumları olan büyük işler için, hesaplama ve durum yönetiminin birlikte sınırlandırılmasından kaynaklanan birçok sorun (örneğin yavaş durum anlık görüntüsü alma ve durum kurtarma) olduğunu kademeli olarak keşfettik. Bu nedenle, Flink 2.0'dan başlayarak, Flink hesaplamasını ve durum yönetimini ayrıştırmayı hedefliyoruz ve bunun modern bir bulut-yerel mimari için daha uygun olduğuna inanıyoruz.

Yeni tasarımda, DFS birincil depolama olarak kullanılır. Kontrol noktaları operatörler arasında paylaşılabilir, böylece aynı durum tablosunun birden çok kopyasını hesaplamak ve depolamak zorunda kalmayız. Bu kontrol noktaları temel alınarak sorgulanabilir durum API'leri sağlanabilir. Durum dosyalarının sıkıştırılması ve temizlenmesi artık aynı Task manager'a bağlı değildir, böylece daha iyi yük dengelemesi yapabilir ve ani CPU ve ağ yoğunluklarından kaçınabiliriz.

### Flink API'lerinin Evrimi

Flink 2.0 yaklaşırken, topluluk Apache Flink'in API'lerini geliştirmeyi planlıyor.
- Flink'in daha hızlı ilerlemesini sağlamak için Flink 2.0'da uzun süredir kullanımdan kaldırılmış bazı API'leri kaldırmayı planlıyoruz, bunlar arasında:
  - DataSet API, tüm Scala API'leri, eski SinkV1 API, eski TableSource/TableSink API
  - DataStream API, Table API ve REST API'deki kullanımdan kaldırılmış metotlar / alanlar / sınıflar
  - Kullanımdan kaldırılmış yapılandırma seçenekleri ve metrikler
- Ayrıca uzun vadede eski SourceFunction / SinkFunction API'lerini ve Queryable State API'yi emekliye ayırmayı planlıyoruz. Bu kısa süre içinde gerçekleşmeyebilir, çünkü kullanıcıların bu API'lerden geçiş yapmaları için gerekli ön koşullar şu anda tam olarak karşılanmamıştır.
- Mevcut DataStream API'nin, çözmek için önemli değişiklikler gerektiren Flink dahili uygulamalarına maruz kalma ve bağımlılıklar gibi bazı sorunlarının farkındayız. Sorunsuz bir geçiş deneyimi sağlamak için topluluk, uzun vadede DataStream API'nin yerini kademeli olarak almayı amaçlayan yeni bir ProcessFunction API tasarlıyor.

### Bir Uygulama Olarak Flink

Bu çabaların amacı, (uzun süreli akış) Flink uygulamalarını dağıtmayı doğal hissettirmektir. Bir küme başlatıp o kümeye bir iş göndermek yerine, bu çabalar bir akış işini kendi kendine yeten bir uygulama olarak dağıtmayı destekler.

Örneğin, basit bir Kubernetes dağıtımı gibi; ekstra iş akışları olmadan normal bir uygulama gibi dağıtılmış ve ölçeklendirilmiş.
- Şu anda topluluk tarafından geliştirilen bir Flink Kubernetes Operator alt projesi var ve [dokümantasyon](https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-main/docs/development/roadmap/) altında kendi yol haritası bulunuyor.
- Uygulama olarak akış sorgusu. SQL İstemcisi/Gateway'in uygulama modunda SQL işleri göndermesini desteklemek ([FLIP-316](https://cwiki.apache.org/confluence/display/FLINK/FLIP-316%3A+Introduce+SQL+Driver#FLIP316:IntroduceSQLDriver-Motivation)).

### Performans

Hem Flink akış hem de toplu işleme performansını iyileştirmeye yönelik sürekli çalışma.

#### Büyük Ölçekli Akış İşleri

- Streaming Join, büyük ölçekli durumu nedeniyle Flink kullanıcıları için bir baş ağrısıdır. Topluluk, minibatch join, multi-way join ve tekrarlanan durumları azaltma gibi akış birleştirme performansını daha da iyileştirmek için çok çaba sarf etmektedir.
- Topluluk ayrıca sırasız async lookup join ve processing-time temporal join ([FLIP-326](https://cwiki.apache.org/confluence/display/FLINK/FLIP-326%3A+Enhance+Watermark+to+Support+Processing-Time+Temporal+Join)) gibi bazı diğer birleştirmeleri sürekli olarak iyileştirmekte ve üzerinde çalışmaktadır. Bunlar, akış birleştirmeleri için çok verimli alternatifler olabilir.
- Flink SQL ile veri değişikliği yakalama ve işleme yaygın olarak kullanılmaktadır ve topluluk, bu durumda maliyet ve performansı iyileştirmektedir, örneğin normalize ve materialize durumunu azaltmak gibi.

#### Daha Hızlı Toplu Sorgular

Topluluğun amacı, Flink'in sınırlı akışlardaki (toplu kullanım durumları) performansını özel toplu işlemcilerinkiyle rekabet edebilir hale getirmektir. Flink'in bazı toplu işleme kullanım durumlarını yaygın olarak kullanılan toplu işlemcilerden daha hızlı ele aldığı gösterilmiş olsa da, bunun daha geniş kullanım durumları için de geçerli olmasını sağlamak için bazı devam eden çabalar var:
Topluluk, veri kaynaklarından okunan verilerin G/Ç maliyetlerini en aza indirmeyi amaçlayan Dynamic Partition Pruning ([DPP](https://cwiki.apache.org/confluence/display/FLINK/FLIP-248%3A+Introduce+dynamic+partition+pruning)) tanıttı. G/Ç ve karıştırma maliyetlerini daha da azaltmak için Runtime Filter ([FLIP-324](https://cwiki.apache.org/confluence/display/FLINK/FLIP-324%3A+Introduce+Runtime+Filter+for+Flink+Batch+Jobs)) gibi devam eden bazı çabalar var.
Operator Fusion CodeGen ([FLIP-315](https://cwiki.apache.org/confluence/display/FLINK/FLIP-315+Support+Operator+Fusion+Codegen+for+Flink+SQL)), sanal fonksiyon çağrılarını ortadan kaldıran ve ara veriler için CPU kayıtlarını kullanan tek bir optimize edilmiş operatöre bir operatör DAG'ını birleştirerek bir sorgunun yürütme performansını iyileştirir.
Topluluk, bazı adaptif toplu yürütme ve zamanlamayı ([FLIP-187](https://cwiki.apache.org/confluence/display/FLINK/FLIP-187%3A+Adaptive+Batch+Scheduler)) desteklemiştir. En verimli sorgu yürütme planını seçmek için çalışma zamanı istatistiklerini kullanan Adaptive Query Execution gibi daha geniş adaptif durumları desteklemeye çalışıyoruz.
Topluluk, OLAP'ı desteklemek için kısa ömürlü işler için planlayıcı ve yürütme performansını iyileştirmeye başladı ([FLINK-25318](https://issues.apache.org/jira/browse/FLINK-25318)). Flink, "OLAP'ı toplu işlemenin özel bir durumu olarak" yürütür, Session Cluster'da düşük gecikmeli ve eşzamanlı sorguları yürütmek için Flink'i genişletmeye çalışıyoruz ve kullanıcılar birleşik Flink motorunda akış, toplu ve OLAP veri işleme gerçekleştirebilir.

### Kararlılık

Topluluk, hataları daha iyi tolere ederek ve kurtarma sürecini hızlandırarak işlerin kararlılığını iyileştirmeye devam etmektedir.

Ortamın istikrarsızlığı kaçınılmazdır. Bu, JobManager ve TaskManager düğümlerinin çökmesine veya veri işlemenin yavaşlamasına yol açabilir. Topluluk, veri işlemeyi yavaşlatan sorunlu makinelerin etkisini azaltmak için toplu işler için speculative execution ([FLIP-168](https://cwiki.apache.org/confluence/display/FLINK/FLIP-168%3A+Speculative+Execution+for+Batch+Job), [FLIP-245](https://cwiki.apache.org/confluence/display/FLINK/FLIP-245%3A+Source+Supports+Speculative+Execution+For+Batch+Job), [FLIP-281](https://cwiki.apache.org/confluence/display/FLINK/FLIP-281+Sink+Supports+Speculative+Execution+For+Batch+Job)) tanıttı.

JobManager düğümü çökmesi, genellikle toplu bir iş için kabul edilemezdir çünkü işin en baştan yeniden çalıştırılması gerekir. Bu nedenle, topluluk bitmiş aşamaları yeniden çalıştırmaktan kaçınmak için JobManager kurtarma sürecini iyileştirmeyi planlıyor. Planlanan bir diğer iyileştirme ise, JobManager düğümü beklenmedik şekilde kapandığında, JobManager çökmesinin etkisini daha da azaltmak için çalışan görevleri korumaktır. Bu, periyodik kontrol noktaları olsa bile akış işlerine de fayda sağlayabilir, bu durumda veri işlemede kesinti veya gerilemeyi önlemek için.

### Kullanılabilirlik

Zaman zaman insanların, Flink'in işlevsellik açısından güçlü olmasına rağmen, onu ustalaşmanın o kadar da kolay olmadığını söylediğini duyuyoruz. Bu sesler duyuldu. Topluluk, Flink'in kullanılabilirliğini iyileştirmek için çeşitli çabalar üzerinde çalışmaktadır.

Kullanıcıların belirtmesi gereken yapılandırma seçeneklerinin sayısını azaltmanın yanı sıra, bunları anlamayı ve ayarlamayı daha kolay hale getirmek için çalışıyoruz. Bu şunları içerir:
Anlamak ve kullanmak için Flink dahili bilgisinin derinlemesine bilinmesini gerektiren seçenekleri kaldırmak.
Flink'in mümkün olduğunda uygun davranışa otomatik ve dinamik olarak karar vermesini sağlamak.
Kullanıcıların çoğu durumda bunlara dokunmak zorunda kalmaması için seçeneklerin varsayılan değerlerini iyileştirmek.
Gerektiğinde daha kolay anlaşılması ve çalışılması için seçeneklerin tanımını ve açıklamasını iyileştirmek.

Bu yönde bazı ilerlemeler kaydettik. Flink 1.17, TPC-DS üzerinde yeterince iyi performans elde etmek için 10'dan az yapılandırma gerektiriyor. Hibrit karıştırma, farklı karıştırma modları arasında dinamik olarak geçiş yapmayı destekler ve bellek ayak izini işin paralelliğinden ayırır.


## Geliştirici Deneyimi

### Ekosistem
Apache Flink'in kendi başına kullanıldığı neredeyse hiçbir kullanım durumu yoktur. Kendisini birçok veri ile ilgili referans mimarisinin bir parçası olarak kabul ettirmiştir. Aslında sincap logosunun birçok yönü kapsadığını göreceksiniz.

Tüm konnektörler ileride harici bir depoda barındırılacak ve bunlardan birçoğu başarıyla dışsallaştırılmıştır. [E-posta listesi konusu](https://lists.apache.org/thread/8k1xonqt7hn0xldbky1cxfx3fzh6sj7h)'na bakın.
Birinci sınıf vatandaş olarak Katalog. Flink kataloğu, kullanıcıların DDL'leri/şemaları manuel olarak kaydetmeden harici sistemlere bağlanan toplu ve akış sorguları yayınlamasına olanak tanır. Konnektörler için en yüksek öncelikte Katalog'u desteklemek önerilir. Topluluk, konnektörler için daha fazla katalog destekleme üzerinde çalışıyor (örn. [GlueCatalog](https://cwiki.apache.org/confluence/display/FLINK/FLIP-277%3A+Native+GlueCatalog+Support+in+Flink), [SchemaRegistryCatalog](https://cwiki.apache.org/confluence/display/FLINK/FLIP-125%3A+Confluent+Schema+Registry+Catalog)).
Daha fazla yeni konnektör tanıtma üzerinde devam eden çalışmalar var (örn. [Pinot](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=177045634), [Redshift](https://cwiki.apache.org/confluence/display/FLINK/FLIP-307%3A++Flink+Connector+Redshift), [ClickHouse](https://cwiki.apache.org/confluence/display/FLINK/FLIP-202%3A+Introduce+ClickHouse+Connector))


### Dokümantasyon

Dokümantasyonun bakımını ve yapısını (daha sezgisel gezinme/okuma) basitleştirmek için çeşitli özel çabalar var.

- Docs Tech Stack: [FLIP-157](https://cwiki.apache.org/confluence/display/FLINK/FLIP-157+Migrate+Flink+Documentation+from+Jekyll+to+Hugo)
- Genel Dokümantasyon Yapısı: [FLIP-42](https://cwiki.apache.org/confluence/display/FLINK/FLIP-42%3A+Rework+Flink+Documentation)
- SQL Dokümantasyonu: [FLIP-60](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=127405685)


