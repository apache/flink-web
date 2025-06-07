---
title: Kod Stili ve Kalite Kılavuzu — Scala
bookCollapseSection: false
bookHidden: true
---

# Kod Stili ve Kalite Kılavuzu — Scala

#### [Önsöz]({{< relref "how-to-contribute/code-style-and-quality-preamble" >}})
#### [Pull Request'ler ve Değişiklikler]({{< relref "how-to-contribute/code-style-and-quality-pull-requests" >}})
#### [Genel Kodlama Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-common" >}})
#### [Java Dili Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-java" >}})
#### [Scala Dili Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-scala" >}})
#### [Bileşenler Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-components" >}})
#### [Biçimlendirme Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-formatting" >}})

## Scala Dili Özellikleri

### Scala'nın Kullanılacağı (ve Kullanılmayacağı) Yerler

**Scala'yı Scala API'leri veya saf Scala kütüphaneleri için kullanırız.**

**Temel API'lerde ve runtime bileşenlerinde Scala kullanmıyoruz. Bu bileşenlerden mevcut Scala kullanımını (kod ve dependency'ler) kaldırmayı hedefliyoruz.**

⇒ Bu Scala'yı sevmediğimizden değil, "doğru iş için doğru araç" yaklaşımının bir sonucudur (aşağıya bakın).

API'ler için, temeli Java'da geliştiririz ve Scala'yı üzerine katmanlarız.

* Bu geleneksel olarak hem Java hem de Scala için en iyi birlikte çalışabilirliği sağlamıştır
* Bu, Scala API'sini güncel tutmak için özel çaba gerektiği anlamına gelir

Neden temel API'lerde ve runtime'da Scala kullanmıyoruz?

* Geçmiş göstermiştir ki Scala, işlevsellikte zor değişikliklerle çok hızlı gelişmektedir. Her Scala sürüm yükseltmesi, Flink topluluğu için oldukça büyük bir çaba gerektiren bir süreçti.
* Scala her zaman Java sınıflarıyla iyi etkileşim kurmaz, örneğin Scala'nın görünürlük kapsamları farklı çalışır ve genellikle Java kullanıcılarına istenilenin ötesinde daha fazla erişim sağlar
* Scala, artifact/dependency yönetimine ek bir karmaşıklık katmanı ekler.
    * Runtime'da Akka gibi Scala'ya bağlı kütüphaneleri tutmak isteyebiliriz, ancak bunları bir arayüz aracılığıyla soyutlamak ve ayrı bir classloader'da yüklemek, bunları korumalı tutmak ve sürüm çakışmalarını önlemek için gerekebilir.
* Scala, bilgili Scala programcılarının, Scala konusunda daha az bilgili programcıların anlaması çok zor olan kodlar yazmasını çok kolaylaştırır. Bu, çeşitli deneyim seviyelerine sahip geniş bir topluluğa sahip bir açık kaynak projesi için özellikle zordur. Bununla başa çıkmak, Scala özellik setini büyük ölçüde kısıtlamak anlamına gelir, bu da Scala'yı kullanmanın asıl amacının önemli bir kısmını engeller.


### API Eşitliği

Java API ve Scala API'yi işlevsellik ve kod kalitesi açısından senkronize tutun.

Scala API, Java API'lerinin tüm özelliklerini de kapsamalıdır.

Scala API'leri, DataStream API'den aşağıdaki örnek gibi bir "tamlık testi"ne sahip olmalıdır: [https://github.com/apache/flink/blob/master/flink-streaming-scala/src/test/scala/org/apache/flink/streaming/api/scala/StreamingScalaAPICompletenessTest.scala](https://github.com/apache/flink/blob/master/flink-streaming-scala/src/test/scala/org/apache/flink/streaming/api/scala/StreamingScalaAPICompletenessTest.scala)


### Dil Özellikleri

* **Scala implicit'lerinden kaçının.**
    * Scala'nın implicit'leri sadece Table API expression'ları veya type information extraction gibi kullanıcı odaklı API iyileştirmeleri için kullanılmalıdır.
    * Bunları dahili "sihir" için kullanmayın.
* **Class üyeleri için açık tip belirtin.**
    * Class field'ları ve method dönüş tipleri için implicit tip çıkarımına güvenmeyin:

      **Yapmayın:**
        ```
        var expressions = new java.util.ArrayList[String]()
        ```

      **Yapın:**
        ```
        var expressions: java.util.List[String] = new java.util.ArrayList[]()
        ```

    * Stack'teki yerel değişkenler için tip çıkarımı kullanmak sorun değildir.
* **Katı görünürlük kullanın.**
    * Scala'nın paket özel özelliklerinden (private[flink] gibi) kaçının ve bunun yerine normal private/protected kullanın.
    * `private[flink]` ve `protected` üyelerin Java'da public olduğunu unutmayın.
    * `private[flink]`'in hala Flink tarafından sağlanan örneklerde tüm üyeleri açığa çıkardığını unutmayın.


### Kod Biçimlendirme

**Kodunuzu yapılandırmak için satır kaydırmayı kullanın.**

* Scala'nın fonksiyonel doğası, uzun dönüşüm zincirlerine izin verir (`x.map().map().foreach()`).
* Geliştiricileri kodlarını yapılandırmaya zorlamak için, satır uzunluğu 100 karakterle sınırlıdır.
* Daha iyi bakım yapılabilirlik için dönüşüm başına bir satır kullanın.

