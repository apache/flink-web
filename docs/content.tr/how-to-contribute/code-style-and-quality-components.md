---
title: Kod Stili ve Kalite Kılavuzu — Bileşenler Kılavuzu
bookCollapseSection: false
bookHidden: true
---

# Kod Stili ve Kalite Kılavuzu — Bileşenler Kılavuzu

#### [Önsöz]({{< relref "how-to-contribute/code-style-and-quality-preamble" >}})
#### [Pull Request'ler ve Değişiklikler]({{< relref "how-to-contribute/code-style-and-quality-pull-requests" >}})
#### [Genel Kodlama Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-common" >}})
#### [Java Dili Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-java" >}})
#### [Scala Dili Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-scala" >}})
#### [Bileşenler Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-components" >}})
#### [Biçimlendirme Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-formatting" >}})

## Bileşene Özel Kılavuzlar

_Belirli bileşenlerdeki değişiklikler hakkında ek kılavuzlar._


### Konfigürasyon Değişiklikleri

Konfigürasyon seçeneği nerede olmalıdır?

* <span style="text-decoration:underline;">'flink-conf.yaml':</span> İşler arasında standartlaştırmak isteyebileceğiniz yürütme davranışıyla ilgili tüm konfigürasyon. Bunu, birinin "ops" şapkasıyla veya diğer ekiplere bir stream processing platformu sağlayan birinin ayarlayacağı parametreler olarak düşünün.

* <span style="text-decoration:underline;">'ExecutionConfig'</span>: Yürütme sırasında operatörler tarafından ihtiyaç duyulan, belirli bir Flink uygulamasına özgü parametreler. Tipik örnekler watermark aralığı, serializer parametreleri, nesne yeniden kullanımıdır.
* <span style="text-decoration:underline;">ExecutionEnvironment (kodda)</span>: Belirli bir Flink uygulamasına özgü olan ve yalnızca program / veri akışı oluşturmak için gereken, yürütme sırasında operatörler içinde gerekmeyen her şey.

Konfigürasyon anahtarlarının adlandırılması:

* Konfigürasyon anahtarı adları hiyerarşik olmalıdır.
  Konfigürasyonu iç içe nesneler (JSON tarzı) olarak düşünün

  ```
  taskmanager: {
    jvm-exit-on-oom: true,
    network: {
      detailed-metrics: false,
      request-backoff: {
        initial: 100,
        max: 10000
      },
      memory: {
        fraction: 0.1,
        min: 64MB,
        max: 1GB,
        buffers-per-channel: 2,
        floating-buffers-per-gate: 16
      }
    }
  }
  ```

* Sonuç olarak konfigürasyon anahtarları şöyle olmalıdır:

  **DEĞİL** `"taskmanager.detailed.network.metrics"`

  **Bunun yerine** `"taskmanager.network.detailed-metrics"`


### Connector'lar

Connector'lar tarihsel olarak uygulanması zordur ve thread'ler, concurrency ve checkpointing'in birçok yönüyle başa çıkmaları gerekir.

[FLIP-27](https://cwiki.apache.org/confluence/display/FLINK/FLIP-27%3A+Refactor+Source+Interface)'nin bir parçası olarak, kaynaklar için bunu çok daha basit hale getirmek için çalışıyoruz. Yeni kaynakların artık concurrency/threading ve checkpointing'in herhangi bir yönüyle başa çıkması gerekmemelidir.

Yakın gelecekte sink'ler için benzer bir FLIP beklenebilir.


### Örnekler

Örnekler kendine yeterli olmalı ve çalıştırmak için Flink dışında sistemler gerektirmemelidir. Kafka connector gibi belirli connector'ların nasıl kullanılacağını gösteren örnekler hariç. Kullanılması uygun olan kaynak/sink'ler, üretimde kullanılmaması gereken ancak işlerin nasıl çalıştığını keşfetmek için oldukça kullanışlı olan `StreamExecutionEnvironment.socketTextStream` ve dosya tabanlı kaynak/sink'lerdir. (Streaming için sürekli dosya kaynağı vardır)

Örnekler ayrıca saf oyuncak örnekler olmamalı, gerçek dünya kodu ile tamamen soyut örnekler arasında bir denge kurmalıdır. WordCount örneği artık oldukça eskimiş olsa da, işlevselliği vurgulayan ve yararlı şeyler yapabilen basit kodun iyi bir örneğidir.

Örnekler ayrıca yorumlarda yoğun olmalıdır. Sınıf düzeyindeki Javadoc'ta örneğin genel fikrini açıklamalı ve kod boyunca neler olduğunu ve hangi işlevselliğin kullanıldığını açıklamalıdır. Beklenen giriş verileri ve çıkış verileri de açıklanmalıdır.

Örnekler, `bin/flink run path/to/myExample.jar --param1 … --param2` kullanarak bir örnek çalıştırabilmeniz için parametre ayrıştırmayı içermelidir.


### Table & SQL API


#### Semantik

**SQL standardı ana doğruluk kaynağı olmalıdır.**

* Sözdizimi, semantik ve özellikler SQL ile uyumlu olmalıdır!
* Tekerleği yeniden icat etmemize gerek yok. Çoğu sorun endüstri genelinde zaten tartışılmış ve SQL standardında yazılmıştır.
* En yeni standarda güveniyoruz (bu belgeyi yazarken SQL:2016 veya ISO/IEC 9075:2016 ([indirme](https://standards.iso.org/ittf/PubliclyAvailableStandards/c065143_ISO_IEC_TR_19075-5_2016.zip)). Her bölüm çevrimiçi olarak mevcut değildir, ancak hızlı bir web araması burada yardımcı olabilir.

Standarttan sapmaları veya satıcıya özgü yorumları tartışın.

* Bir sözdizimi veya davranış bir kez tanımlandığında kolayca geri alınamaz.
* Standardı genişletmek veya yorumlamak gereken katkılar, toplulukla kapsamlı bir tartışma gerektirir.
* Lütfen, Postgres, Microsoft SQL Server, Oracle, Hive, Calcite, Beam gibi diğer satıcıların bu tür durumları nasıl ele aldığı hakkında bazı ilk araştırmaları yaparak committer'lara yardımcı olun.


Table API'yi SQL ve Java/Scala programlama dünyası arasında bir köprü olarak düşünün.

* Table API, ilişkisel modeli takip eden analitik programlar için Gömülü Alana Özgü bir Dildir.
  Sözdizimi ve adlar açısından SQL standardını katı bir şekilde takip etmesi gerekmez, ancak daha sezgisel hissetmeye yardımcı oluyorsa, bir programlama dilinin fonksiyonları ve özellikleri adlandıracağı/yapacağı şekilde daha yakın olabilir.
* Table API'nin bazı SQL olmayan özellikleri olabilir (örn. map(), flatMap() vb.) ancak yine de "SQL gibi hissetmelidir". Mümkünse fonksiyonlar ve işlemler eşit semantik ve isimlendirmeye sahip olmalıdır.


#### Yaygın hatalar

* Bir özellik eklerken SQL'in tip sistemini destekleyin.
    * Bir SQL fonksiyonu, connector'ı veya formatı, en başından itibaren çoğu SQL tipini doğal olarak desteklemelidir.
    * Desteklenmeyen tipler kafa karışıklığına yol açar, kullanılabilirliği sınırlar ve aynı kod yollarına birden çok kez dokunarak ek yük oluşturur.
    * Örneğin, bir `SHIFT_LEFT` fonksiyonu eklerken, katkının sadece `INT` için değil, aynı zamanda `BIGINT` veya `TINYINT` için de yeterince genel olduğundan emin olun.


#### Test etme

Null olabilirliği test edin.

* SQL doğal olarak neredeyse her işlem için `NULL`'u destekler ve 3 değerli bir boolean mantığına sahiptir.
* Her özelliği null olabilirlik açısından da test ettiğinizden emin olun.


Tam entegrasyon testlerinden kaçının

* Bir Flink mini-cluster'ı başlatmak ve bir SQL sorgusu için üretilen kodun derlenmesini gerçekleştirmek pahalıdır.
* Planlayıcı testleri veya API çağrılarının varyasyonları için entegrasyon testlerinden kaçının.
* Bunun yerine, bir planlayıcıdan çıkan optimize edilmiş planı doğrulayan birim testleri kullanın. Veya doğrudan bir runtime operatörünün davranışını test edin.


#### Uyumluluk

Yama sürümlerinde fiziksel plan değişiklikleri getirmeyin!

* Streaming SQL'de durum için geriye dönük uyumluluk, fiziksel yürütme planının sabit kalması gerçeğine dayanır. Aksi takdirde, oluşturulan Operatör Adları/ID'leri değişir ve durum eşleştirilemez ve geri yüklenemez.
* Dolayısıyla, optimize edilmiş bir streaming pipeline'ının fiziksel planında değişikliklere yol açan her hata düzeltmesi uyumluluğu bozar.
* Sonuç olarak, farklı optimizer planlarına yol açan türdeki değişiklikler şimdilik yalnızca ana sürümlerde birleştirilebilir.


#### Scala / Java birlikte çalışabilirliği (eski kod parçaları)

Arayüzleri tasarlarken Java'yı aklınızda tutun.

* Bir sınıfın gelecekte bir Java sınıfıyla etkileşime girip girmeyeceğini düşünün.
* Java kodu ile sorunsuz entegrasyon için arayüzlerde Java koleksiyonları ve Java Optional kullanın.
* Bir sınıf Java'ya dönüştürülmeye tabi tutulacaksa, yapım için .copy() veya apply() gibi case class'ların özelliklerini kullanmayın.
* Saf Scala kullanıcı odaklı API'ler, Scala ile doğal ve idiomatik ("scalaesk") entegrasyon için saf Scala koleksiyonları/yinelenebilirleri/vb. kullanmalıdır.


