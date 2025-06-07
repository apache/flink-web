---
title: Kod Stili ve Kalite Kılavuzu — Java
bookCollapseSection: false
bookHidden: true
---

# Kod Stili ve Kalite Kılavuzu — Java

#### [Önsöz]({{< relref "how-to-contribute/code-style-and-quality-preamble" >}})
#### [Pull Request'ler ve Değişiklikler]({{< relref "how-to-contribute/code-style-and-quality-pull-requests" >}})
#### [Genel Kodlama Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-common" >}})
#### [Java Dili Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-java" >}})
#### [Scala Dili Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-scala" >}})
#### [Bileşenler Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-components" >}})
#### [Biçimlendirme Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-formatting" >}})

## Java Dili Özellikleri ve Kütüphaneleri


### Ön Koşullar ve Loglama İfadeleri

* Parametrelerde asla dizeleri birleştirmeyin
    * <span style="text-decoration:underline;">Yapmayın:</span> `Preconditions.checkState(value <= threshold, "value must be below " + threshold)`
    * <span style="text-decoration:underline;">Yapmayın:</span> `LOG.debug("value is " + value)`
    * <span style="text-decoration:underline;">Yapın:</span> `Preconditions.checkState(value <= threshold, "value must be below %s", threshold)`
    * <span style="text-decoration:underline;">Yapın:</span> `LOG.debug("value is {}", value)`


### Generics

* **Raw type kullanmayın:** Kesinlikle gerekli olmadıkça raw type kullanmayın (bazen imza eşleşmeleri, diziler için gereklidir).
* **Kontrol edilmemiş dönüşümler için uyarıları bastırın:** Kaçınılamıyorsa uyarıları bastırmak için annotation ekleyin (örneğin "unchecked" veya "serial"). Aksi takdirde, generics hakkındaki uyarılar yapıyı doldurur ve ilgili uyarıları boğar.


### equals() / hashCode()

* **equals() / hashCode() yalnızca iyi tanımlandıklarında eklenmelidir.**
* İyi tanımlanmadıkları zaman **testlerde daha basit bir assertion sağlamak için eklenmemelidir**. Bu durumda hamcrest matcher'larını kullanın: [https://github.com/junit-team/junit4/wiki/matchers-and-assertthat](https://github.com/junit-team/junit4/wiki/matchers-and-assertthat)
* Yöntemlerin iyi tanımlanmadığının yaygın bir göstergesi, alanların bir alt kümesini dikkate almalarıdır (tamamen yardımcı alanlar dışında).
* Yöntemler mutable alanları dikkate aldığında, genellikle bir tasarım sorununuz vardır. `equals()`/`hashCode()` yöntemleri, türü bir anahtar olarak kullanmayı önerir, ancak imzalar türü değiştirmeye devam etmenin güvenli olduğunu gösterir.


### Java Serialization

* **Hiçbir şey için Java Serialization kullanmayın !!!**
* **Hiçbir şey için Java Serialization kullanmayın !!! !!!**
* **Hiçbir şey için Java Serialization kullanmayın !!! !!! !!!**
* Flink içinde, Java serialization, mesajları ve programları RPC aracılığıyla taşımak için kullanılır. Bu, Java serialization kullandığımız tek durumdur. Bu nedenle, bazı sınıfların serializable olması gerekir (RPC aracılığıyla taşınıyorlarsa).
* **Serializable sınıflar bir Serial Version UID tanımlamalıdır:**

  `private static final long serialVersionUID = 1L;`
* **Yeni sınıflar için Serial Version UID 1'den başlamalıdır** ve genellikle Java serialization uyumluluğu tanımına göre sınıfta yapılan her uyumsuz değişiklikte artırılmalıdır (örneğin: bir alanın türünü değiştirmek veya bir sınıfı sınıf hiyerarşisinde taşımak).


### Java Reflection

**Java'nın Reflection API'sini kullanmaktan kaçının**

* Java'nın Reflection API'si belirli durumlarda çok kullanışlı bir araç olabilir, ancak her durumda bir hack'tir ve alternatifler araştırılmalıdır. Flink'in reflection kullanması gereken tek durumlar şunlardır:
    * Başka bir modülden dinamik olarak implementasyonları yükleme (web UI, ek serializer'lar, pluggable query processor'lar gibi).
    * TypeExtractor sınıfı içinde türleri çıkarma. Bu yeterince kırılgandır ve TypeExtractor sınıfının dışında yapılmamalıdır.
    * Bir sınıfın/metodun tüm sürümlerde bulunduğunu varsayamadığımız için reflection kullanmamız gereken, JDK sürümleri arası özelliklerin bazı durumları.
* Testlerde metodlara veya alanlara erişmek için reflection'a ihtiyacınız varsa, bu genellikle daha derin mimari sorunlara işaret eder, örneğin yanlış scoping, ilgi alanlarının kötü ayrımı veya test edilen sınıfa component'ler/dependency'ler sağlamanın temiz bir yolunun olmadığı durumlar.


### Collections

* **ArrayList ve ArrayDeque, listenin ortasında sık sık ekleme ve silme yapıldığı durumlar dışında neredeyse her zaman LinkedList'ten üstündür.**
* **Map'ler için, birden çok lookup gerektiren pattern'lardan kaçının**
    * `get()` öncesinde `contains()` → `get()` ve null kontrolü
    * `put()` öncesinde `contains()` → `putIfAbsent()` veya `computeIfAbsent()`
    * Key'ler üzerinde yineleme, value'ları alma → `entrySet()` üzerinde yineleme
* **Bir collection için initial capacity'i yalnızca bunun için iyi kanıtlanmış bir neden varsa ayarlayın**, aksi takdirde kodu karıştırmayın. **Map'ler** durumunda bu daha da yanıltıcı olabilir çünkü Map'in load factor'ü etkili bir şekilde capacity'i azaltır.


### Java Optional

* Nullable değerler için `Optional` kullanmadığınız yerlerde **@Nullable annotation kullanın**.
* `Optional` kullanımının kritik kodda **performance degradation'a yol açacağını kanıtlayabiliyorsanız, @Nullable'a fallback yapın**.
* Kanıtlanmış bir performans endişesi durumu dışında, API/public method'larda **nullable değerleri döndürmek için her zaman Optional kullanın**.
* Bunun yerine ya metodu overload edin ya da fonksiyon argümanları seti için Builder pattern kullanın, **Optional'ı bir fonksiyon argümanı olarak kullanmayın**.
    * Not: Kodun basitleştirildiğine inanıyorsanız, private helper method'da bir Optional argümanına izin verilebilir
      ([örnek](https://github.com/apache/flink/blob/master/flink-formats/flink-avro/src/main/java/org/apache/flink/formats/avro/typeutils/AvroFactory.java#L95)).
* **Class field'ları için Optional kullanmayın**.


### Lambda Expressions

* Non-capturing lambda'ları tercih edin (dış scope'daki referansları içermeyen lambda'lar). Capturing lambda'lar her çağrı için yeni bir nesne instance'ı oluşturmalıdır. Non-capturing lambda'lar, her invocation için aynı instance'ı kullanabilir.

  **yapmayın:**
  ```
  map.computeIfAbsent(key, x -> key.toLowerCase())
  ```

  **yapın:**
  ```
  map.computeIfAbsent(key, k -> k.toLowerCase());
  ```

* Inline lambda'lar yerine method reference'ları düşünün

  **yapmayın**:
  ```
  map.computeIfAbsent(key, k-> Loader.load(k));
  ```

  **yapın:**
  ```
  map.computeIfAbsent(key, Loader::load);
  ```


### Java Streams

* Performance-critical olan herhangi bir kodda Java Streams kullanmaktan kaçının.
* Java Streams kullanmanın ana motivasyonu, kod readability'sini geliştirmek olmalıdır. Bu nedenle, data-intensive olmayan, ancak koordinasyonla ilgilenen kod parçaları için iyi bir match olabilirler.
* İkinci durumda bile, scope'u bir metod ile veya bir internal class içindeki birkaç private metod ile sınırlamaya çalışın.


