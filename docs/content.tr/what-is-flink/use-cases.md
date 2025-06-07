---
title: Kullanım Örnekleri
bookCollapseSection: false
weight: 4
aliases:
- /use-cases.html
- /use-cases/index.html

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

# Kullanım Örnekleri

Apache Flink, geniş özellik seti sayesinde birçok farklı türde uygulamayı geliştirmek ve çalıştırmak için mükemmel bir seçimdir. Flink'in özellikleri arasında akış ve toplu işleme desteği, gelişmiş durum yönetimi, olay-zamanı işleme semantiği ve durum için tam olarak bir kez tutarlılık garantileri bulunur. Ayrıca Flink, YARN ve Kubernetes gibi çeşitli kaynak sağlayıcıları üzerinde, aynı zamanda çıplak metal donanım üzerinde bağımsız bir küme olarak da dağıtılabilir. Yüksek kullanılabilirlik için yapılandırıldığında, Flink'in tek bir arıza noktası yoktur. Flink'in binlerce çekirdeğe ve terabaytlarca uygulama durumuna ölçeklendiği, yüksek verim ve düşük gecikme süresi sağladığı ve dünyanın en zorlu akış işleme uygulamalarından bazılarına güç verdiği kanıtlanmıştır.

Aşağıda, Flink tarafından desteklenen en yaygın uygulama türlerini keşfediyor ve gerçek dünya örneklerine işaret ediyoruz.

* <a href="#olay-odakli-uygulamalar">Olay Odaklı Uygulamalar</a>
* <a href="#veri-analizi-uygulamalari">Veri Analizi Uygulamaları</a>
* <a href="#veri-hatti-uygulamalari">Veri Hattı Uygulamaları</a>

## Olay Odaklı Uygulamalar <a name="olay-odakli-uygulamalar"></a>

### Olay odaklı uygulamalar nedir?

Olay odaklı bir uygulama, bir veya daha fazla olay akışından olayları alan ve gelen olaylara hesaplamaları, durum güncellemelerini veya dış eylemleri tetikleyerek tepki veren durumlu bir uygulamadır.

Olay odaklı uygulamalar, ayrılmış hesaplama ve veri depolama katmanlarına sahip geleneksel uygulama tasarımının bir gelişimidir. Bu mimaride, uygulamalar uzak bir işlemsel veritabanından veri okur ve verileri bu veritabanına kalıcı hale getirir.

Buna karşılık, olay odaklı uygulamalar durumlu akış işleme uygulamalarına dayanır. Bu tasarımda, veri ve hesaplama birlikte bulunur, bu da yerel (bellek içi veya disk) veri erişimi sağlar. Hata toleransı, uzak kalıcı depolamaya periyodik olarak kontrol noktaları yazılarak sağlanır. Aşağıdaki şekil, geleneksel uygulama mimarisi ile olay odaklı uygulamalar arasındaki farkı göstermektedir.

<br>
<div>
  {{< img src="/img/usecases-eventdrivenapps.png" width="700px" >}}
</div>

### Olay odaklı uygulamaların avantajları nelerdir?

Uzak bir veritabanını sorgulamak yerine, olay odaklı uygulamalar verilerine yerel olarak erişir, bu da hem verim hem de gecikme açısından daha iyi performans sağlar. Uzak kalıcı depolamaya periyodik kontrol noktaları asenkron ve artımlı olabilir. Bu nedenle, kontrol noktası alma işleminin normal olay işleme üzerindeki etkisi çok küçüktür. Ancak, olay odaklı uygulama tasarımı sadece yerel veri erişiminden daha fazla yarar sağlar. Katmanlı mimaride, birden fazla uygulamanın aynı veritabanını paylaşması yaygındır. Bu nedenle, bir uygulama güncellemesi veya hizmetin ölçeklendirilmesi nedeniyle veri düzenini değiştirmek gibi veritabanındaki herhangi bir değişikliğin koordine edilmesi gerekir. Her olay odaklı uygulama kendi verilerinden sorumlu olduğundan, veri temsilindeki değişiklikler veya uygulamanın ölçeklendirilmesi daha az koordinasyon gerektirir.

### Flink olay odaklı uygulamaları nasıl destekler?

Olay odaklı uygulamaların sınırları, bir akış işlemcisinin zamanı ve durumu ne kadar iyi işleyebildiği ile belirlenir. Flink'in öne çıkan özelliklerinin çoğu bu kavramlar etrafında yoğunlaşmıştır. Flink, tam olarak bir kez tutarlılık garantileri ile çok büyük veri hacimlerini (birkaç terabayta kadar) yönetebilen zengin bir durum ilkelleri seti sunar. Ayrıca, Flink'in olay zamanı desteği, yüksek düzeyde özelleştirilebilir pencere mantığı ve `ProcessFunction` tarafından sağlanan zamanın ince taneli kontrolü, gelişmiş iş mantığının uygulanmasını sağlar. Bunun yanında, Flink, veri akışlarında kalıpları tespit etmek için Karmaşık Olay İşleme (CEP) için bir kütüphane sunar.

Ancak, Flink'in olay odaklı uygulamalar için öne çıkan özelliği, kaydetme noktaları için sağladığı destektir. Bir kaydetme noktası, uyumlu uygulamalar için başlangıç noktası olarak kullanılabilen tutarlı bir durum görüntüsüdür. Bir kaydetme noktası ile, bir uygulama güncellenebilir veya ölçeği uyarlanabilir ya da bir uygulamanın birden çok sürümü A/B testi için başlatılabilir.

### Tipik olay odaklı uygulamalar nelerdir?

* <a href="https://www.youtube.com/watch?v=Do7C4UJyWCM/">Dolandırıcılık tespiti</a>
* <a href="https://www.youtube.com/watch?v=rJNH5WhWAj4/">Anomali tespiti</a>
* <a href="https://www.youtube.com/watch?v=_yHds9SvMfE/">Kural tabanlı uyarı</a>
* <a href="https://jobs.zalando.com/tech/blog/complex-event-generation-for-business-process-monitoring-using-apache-flink/">İş süreci izleme</a>
* <a href="https://www.youtube.com/watch?v=0cJ565r2FVI/">Web uygulaması (sosyal ağ)</a>

## Veri Analizi Uygulamaları <a name="veri-analizi-uygulamalari"></a>

### Veri analizi uygulamaları nedir?

Analitik işler, ham verilerden bilgi ve içgörü çıkarır. Geleneksel olarak, analizler, kaydedilmiş olayların sınırlı veri kümeleri üzerinde toplu sorgular veya uygulamalar olarak gerçekleştirilir. Analizin sonucuna en son verileri dahil etmek için, analiz edilen veri kümesine eklenmesi ve sorgu veya uygulamanın yeniden çalıştırılması gerekir. Sonuçlar bir depolama sistemine yazılır veya raporlar olarak yayınlanır.

Gelişmiş bir akış işleme motoruyla, analizler gerçek zamanlı olarak da gerçekleştirilebilir. Sonlu veri kümelerini okumak yerine, akış sorguları veya uygulamaları gerçek zamanlı olay akışlarını alır ve olaylar tüketildikçe sürekli olarak sonuçlar üretir ve günceller. Sonuçlar ya harici bir veritabanına yazılır ya da dahili durum olarak korunur. Bir gösterge paneli uygulaması, harici veritabanından en son sonuçları okuyabilir veya doğrudan uygulamanın dahili durumunu sorgulayabilir.

Apache Flink, aşağıdaki şekilde gösterildiği gibi akış ve toplu analitik uygulamaları destekler.

<div>
  {{< img src="/img/usecases-analytics.png" width="700px" >}}
</div>

### Akış analizi uygulamalarının avantajları nelerdir?

Sürekli akış analizinin toplu analize göre avantajları, periyodik içe aktarma ve sorgu yürütmenin ortadan kaldırılması nedeniyle olaylardan içgörüye çok daha düşük gecikme ile sınırlı değildir. Toplu sorguların aksine, akış sorguları, periyodik içe aktarmalar ve girdinin sınırlı doğası nedeniyle ortaya çıkan giriş verilerindeki yapay sınırlarla uğraşmak zorunda değildir.

Bir diğer yön, daha basit bir uygulama mimarisidir. Bir toplu analitik hattı, veri alımını ve sorgu yürütmeyi periyodik olarak planlamak için birkaç bağımsız bileşenden oluşur. Böyle bir hattı güvenilir bir şekilde çalıştırmak kolay değildir çünkü bir bileşenin arızaları hattın sonraki adımlarını etkiler. Buna karşılık, Flink gibi gelişmiş bir akış işlemcisi üzerinde çalışan bir akış analizi uygulaması, veri alımlarından sürekli sonuç hesaplamasına kadar tüm adımları içerir. Bu nedenle, motorun arıza kurtarma mekanizmasına güvenebilir.

### Flink veri analizi uygulamalarını nasıl destekler?

Flink, sürekli akış ve toplu analiz için çok iyi destek sağlar. Özellikle, toplu ve akış sorguları için birleşik semantiğe sahip ANSI uyumlu bir SQL arayüzü sunar. SQL sorguları, kaydedilmiş olayların statik bir veri kümesi üzerinde veya gerçek zamanlı bir olay akışında çalıştırılıp çalıştırılmadığına bakılmaksızın aynı sonucu hesaplar. Kullanıcı tanımlı fonksiyonlar için zengin destek, özel kodun SQL sorgularında yürütülebilmesini sağlar. Daha da fazla özel mantık gerekiyorsa, Flink'in DataStream API veya DataSet API daha düşük seviyeli kontrol sağlar.

### Tipik veri analizi uygulamaları nelerdir?

* <a href="https://www.youtube.com/watch?v=izYsMQWeUbE/">Telekom ağlarının kalite izlemesi</a>
* Mobil uygulamalarda <a href="https://www.youtube.com/watch?v=17tUR4TsvpM/">ürün güncellemelerinin analizi ve deney değerlendirmesi</a> in mobile applications
* Tüketici teknolojisinde <a href="https://eng.uber.com/athenax/">canlı verilerin anlık analizi</a> in consumer technology
* Büyük ölçekli grafik analizi

## Veri Hattı Uygulamaları <a name="veri-hatti-uygulamalari"></a>

### Veri hatları nedir?

Çıkar-dönüştür-yükle (ETL), veri depolama sistemleri arasında veri dönüştürmek ve taşımak için yaygın bir yaklaşımdır. Genellikle ETL işleri, işlemsel veritabanı sistemlerinden analitik bir veritabanına veya bir veri ambarına veri kopyalamak için periyodik olarak tetiklenir.

Veri hatları, ETL işleriyle benzer bir amaca hizmet eder. Verileri dönüştürür ve zenginleştirir, bir depolama sisteminden diğerine taşıyabilirler. Ancak, periyodik olarak tetiklenmek yerine sürekli akış modunda çalışırlar. Bu nedenle, sürekli olarak veri üreten kaynaklardan kayıtları okuyabilir ve düşük gecikme ile hedeflerine taşıyabilirler. Örneğin, bir veri hattı, yeni dosyalar için bir dosya sistemi dizinini izleyebilir ve verilerini bir olay günlüğüne yazabilir. Başka bir uygulama, bir olay akışını bir veritabanına somutlaştırabilir veya aşamalı olarak bir arama dizini oluşturabilir ve iyileştirebilir.

Aşağıdaki şekil, periyodik ETL işleri ile sürekli veri hatları arasındaki farkı göstermektedir.

<div>
  {{< img src="/img/usecases-datapipelines.png" width="700px" >}}
</div>

### Veri hatlarının avantajları nelerdir?

Sürekli veri hatlarının periyodik ETL işlerine göre açık avantajı, verilerin hedefine taşınmasının gecikme süresinin azaltılmasıdır. Ayrıca, veri hatları daha çok yönlüdür ve sürekli olarak veri tüketebilir ve yayabildiği için daha fazla kullanım durumu için kullanılabilir.

### Flink veri hatlarını nasıl destekler?

Birçok yaygın veri dönüştürme veya zenginleştirme görevi, Flink'in SQL arayüzü (veya Table API) ve kullanıcı tanımlı fonksiyonlar için desteği ile ele alınabilir. Daha gelişmiş gereksinimlere sahip veri hatları, daha genel olan DataStream API kullanılarak gerçekleştirilebilir. Flink, Kafka, Kinesis, Elasticsearch ve JDBC veritabanı sistemleri gibi çeşitli depolama sistemlerine zengin bir konnektör seti sağlar. Ayrıca, dizinleri izleyen dosya sistemleri için sürekli kaynaklar ve zaman gruplu bir şekilde dosya yazan havuzlar sunar.

### Tipik veri hattı uygulamaları nelerdir?

* E-ticarette <a href="https://ververica.com/blog/blink-flink-alibaba-search">gerçek zamanlı arama dizini oluşturma</a>
* E-ticarette <a href="https://engineering.zalando.com/posts/2016/03/apache-showdown-flink-vs.-spark.html">sürekli ETL</a>
