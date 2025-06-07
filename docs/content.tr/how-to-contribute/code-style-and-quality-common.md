---
title: Kod Stili ve Kalite Kılavuzu — Genel Kurallar
bookCollapseSection: false
bookHidden: true
---

# Kod Stili ve Kalite Kılavuzu — Genel Kurallar

#### [Önsöz]({{< relref "how-to-contribute/code-style-and-quality-preamble" >}})
#### [Pull Request'ler ve Değişiklikler]({{< relref "how-to-contribute/code-style-and-quality-pull-requests" >}})
#### [Genel Kodlama Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-common" >}})
#### [Java Dili Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-java" >}})
#### [Scala Dili Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-scala" >}})
#### [Bileşenler Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-components" >}})
#### [Biçimlendirme Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-formatting" >}})

<hr>

## 1. Telif Hakkı

Her dosya, başlık olarak Apache lisans bilgisini içermelidir.

```
/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
```

## 2. Araçlar

IDE araçlarını yapılandırmak için {{< docs_link file="flink-docs-stable/docs/flinkdev/ide_setup/" name="IDE Kurulum Kılavuzu">}}'nu takip etmenizi öneririz.


<!---
### Use inspections in IntelliJ

* Import the inspections settings into the IDE (see IDE setup guide)
    * TODO: Need to agree on a profile and export it (like checkstyle)
* Write the code such that inspection warnings are addressed
    * There are few exceptions where an inspection warning is not meaningful. In that case, suppress the inspection warning.
-->

### Uyarılar

* Sıfır uyarıya ulaşmaya çalışırız
* Mevcut kodda birçok uyarı olsa da, yeni değişiklikler ek derleyici uyarıları eklememeli
* Uyarıyı sağlıklı bir şekilde ele almak mümkün değilse (jeneriklerle çalışırken bazı durumlarda), uyarıyı bastırmak için bir ek açıklama ekleyin
* Yöntemleri kullanımdan kaldırırken, bunun ek uyarılar getirmediğinden emin olun



## 3. Yorumlar ve Kod Okunabilirliği


### Yorumlar

**Altın kural: Kodun anlaşılmasını desteklemek için gerektiği kadar yorum ekleyin, ancak gereksiz bilgi eklemeyin.**

Şunları düşünün:

* Kod <span style="text-decoration:underline;">ne</span> yapıyor?
* Kod bunu <span style="text-decoration:underline;">nasıl</span> yapıyor?
* Kod <span style="text-decoration:underline;">neden</span> böyle?

Kodun kendisi, mümkün olduğunca "<span style="text-decoration:underline;">ne</span>" ve "<span style="text-decoration:underline;">nasıl</span>" sorularını açıklamalıdır.

* Sınıfların rollerini ve yöntemlerin sözleşmelerini, yöntem adından açıkça anlaşılamadığı durumlarda tanımlamak için JavaDoc'ları kullanın ("ne" sorusu).
* Kodun akışı, "nasıl" sorusuna iyi bir açıklama sağlamalıdır.
  Değişken ve yöntem adlarını, kodun kendini belgelendirmesinin bir parçası olarak düşünün.
* Bir birim oluşturan daha büyük blokları, o bloğun ne yaptığını tanımlayan açıklayıcı bir isimle özel bir yönteme taşımak, kodun okunmasını genellikle kolaylaştırır.

Kod içi yorumlar, <span style="text-decoration:underline;">"neden"</span> sorusunu açıklamaya yardımcı olur.

* Örneğin `// bu belirli kod düzeni JIT'in şunu veya bunu daha iyi yapmasına yardımcı olur`
* Veya `// bu alanı burada null yapmak, gelecekteki yazma girişimlerinin daha hızlı başarısız olması anlamına gelir`
* Veya `// bu yöntemin gerçekte çağrıldığı argümanlarla, görünüşte naif olan bu yaklaşım aslında optimize edilmiş/akıllı sürümlerden daha iyi çalışır`

Kod içi yorumlar, kodun kendisinde zaten açık olan "ne" ve "nasıl" hakkında gereksiz bilgiler belirtmemelidir.

JavaDoc'lar anlamsız bilgiler belirtmemelidir (sadece Checkstyle denetleyicisini memnun etmek için).

__Yapmayın:__

```
/**
 * The symbol expression.
 */
public class CommonSymbolExpression {}
```
__Yapın:__

```
/**
 * An expression that wraps a single specific symbol.
 * A symbol could be a unit, an alias, a variable, etc.
 */
public class CommonSymbolExpression {}
```


### Dallar ve İç İçe Geçme

If koşulunu çevirerek ve erken çıkarak, kapsamların derin iç içe geçmesinden kaçının.

__Yapmayın:__

```
if (a) {
    if (b) {
        if (c) {
            the main path
        }
    }
}
```

__Yapın:__

```
if (!a) {
	return ..
}

if (!b) {
	return ...
}

if (!c) {
	return ...
}

the main path
```


## 4. Tasarım ve Yapı

Bunun ne olduğunu tam olarak belirtmek zor olduğu gibi, iyi tasarım için bazı özellikler vardır. Bu özellikler varsa, iyi bir yönde olduğu ihtimali yüksektir. Bu özellikler elde edilemiyorsa, tasarımın hatalı olduğu ihtimali yüksektir.


### Immutability ve Eager Initialization

1. Mümkün olduğunca immutable türler kullanmayı deneyin, özellikle API'ler, mesajlar, tanımlayıcılar, özellikler, yapılandırma, vb.
2. İyi bir genel yaklaşım, bir sınıfın mümkün olduğunca çok alanını `final` yapmayı denemektir.
3. Haritaların anahtarları olarak kullanılan sınıfların tamamen sabit ve sadece `final` alanları olmalıdır (muhtemelen yardımcı alanlar hariç, örneğin ilk önce yüklenen hash kodları).
4. Sınıfları ilk önce tamamlanana kadar kullanılabilir hale getirin. Kurucu tamamlanana kadar nesne kullanılamaz.


### Değiştirilebilir Alanların Null Olabilirliği

Nullability için Flink kod tabanı, aşağıdaki konvansiyonları takip etmeyi hedefler:

* Alanlar, parametreler ve dönüş türleri her zaman null olmayan, eğer bunun aksi belirtilmediği sürece
* Tüm alanlar, parametreler ve yöntem türleri, null olabilecekleri için `@javax.annotation.Nullable` ile işaretlenmelidir.
  Böylece, IntelliJ'den tüm bölümlerde null değerleri hakkında düşünmeniz gerektiğini bildirir.
* Tüm değişken (final olmayan) alanlar için varsayım, alan değeri değişirken her zaman bir değer olduğudur.
    * Bu, bu nesnenin ömrü boyunca bu gerçekten null olmayabileceğini değil, değişken değeri değişirken her zaman bir değer olduğunu görmek için iki kere kontrol etmek gerektiğini gösterir.

_Not: Bu, `@Nonnull` ek açıklamaları genellikle gerekli olmadığını, ancak önceki ek açıklama ile geçersiz kılmak için veya null olmayı belirtmek için bir bağlamda kullanılabilir._

`Optional` bir yöntem için dönüş türü için iyi bir çözümdür, böylece null dönüş türleri `Optional` ile değiştirilebilir. Bkz. [Java Optional'un kullanımı]({{< relref "how-to-contribute/code-style-and-quality-java" >}}#java-optional).


### Kod Duplicasyonunu Önleme

1. Her zaman kodu/kopyalamak veya benzer bir tür işlevi farklı bir yerde yeniden oluşturmak için, değişiklikleri yeniden kullanmak/soyutlamak/soyutlamak için yollarını düşünün.
2. Farklı özellemeler arasındaki ortak davranışlar, başka bir bileşene (veya paylaşılan bir sınıfa) paylaşılmalıdır.
3. Her zaman "özel statik final" sabitleri kullanın, aksi takdirde farklı yerlerde dizeler veya diğer özel değerleri tekrarlamak. Sabitler, bir sınıfın üst üye alanında bildirilmelidir.


### Test Edilebilirlik İçin Tasarım

Test edilebilir kod genellikle iyi bir bütünleşik işlevi ve dışarıdan yeniden kullanılabilir olarak yapılır.

Bir özet veya sorunlar / belirtiler ve önerilen yeniden düzenleme, PDF'deki bağlantıda bulunabilir. Lütfen not, PDF'deki örnekler genellikle bir bağımlılık enjeksiyon çerçevesi (Guice) kullanır, ancak bunun aynı şekilde çalışmadığını unutmayın.[^1]

[http://misko.hevery.com/attachments/Guide-Writing%20Testable%20Code.pdf](http://misko.hevery.com/attachments/Guide-Writing%20Testable%20Code.pdf)

Burada en önemli noktaların kısa bir özeti bulunmaktadır.


**Bağımlılıkları Enjekte Et**

Reusability, bağımlılıkları oluşturan kurucuların (alanları atayan nesneler) oluşturmamasına yardımcı olur, ancak bunları parametreler olarak kabul ederler.

* Etkili bir şekilde, kurucuların `new` anahtar kelimesi olmaması gerekir.
* Özel durumlar, yeni boş bir koleksiyon (`new ArrayList<>()`) veya benzer yardımcı alanları oluşturmaktır (yalnızca temel bağımlılıkları olan nesneler).

Tam nesne oluşturmak için kolay / okunabilirlik için, tüm nesneyi bağımlılıklarıyla oluşturmak için fabrika yöntemleri veya ek olarak kullanılabilir ekstra kurucular ekleyin.

Hiçbir zaman, bir testte nesne alanlarını değiştirmek için yansıma veya "Beyaz Kutu" util'ini kullanmanız gerekmez veya PowerMock'i kullanmanız gerekmez.


**"Çok İşlevli" Önleme**

Eğer test sırasında büyük bir diğer bileşen setine ihtiyacınız varsa (çok işlevli), yeniden düzenlemeyi düşünün.

Test etmek istediğiniz bileşen/sınıf, muhtemelen başka bir geniş bileşene (ve bunun uygulamasına) bağlıdır, yerine minimal arayüz (soyutlama) gerekli için.

Bu durumda, arayüzleri (minimal gerekli arayüzü çıkarın) ve bu durumda test stub sağlayın.

* Örneğin, S3RecoverableMultiPartUploader test etmek için gerçek S3 erişimi gerekiyorsa
  o zaman S3 erişimi, bir arayüzün ve testin bunu test stub ile değiştirmesi gerekir
* Bu, doğal olarak bağımlılıkları enjekte etmeyi gerektirir (bkz. yukarıda)

⇒ Lütfen not, bu adımlar genellikle test uygulamak için daha fazla çaba gerektirir, ancak diğer bileşenlerde değişiklikler yapılırken testlerin daha dayanıklı olmasını sağlar, yani diğer bileşenlerde değişiklikler yapılırken testleri değiştirmeniz gerekmez.

### Performans Duyarlılığı

Biz, kodun "koordinasyon" ve kodun "veri işleme" olduğunu kavramakla ilgilenebiliriz. Koordinasyon kodu her zaman basitlik ve temizlik için favori olmalıdır. Veri işleme kodu, performans için yüksek performans gerektiren ve performans için optimize edilmelidir.

Bu, genel fikirlerin bölümlerdeki üstünü uygulamak anlamına gelir, ancak belki bazı noktalarda bazı yönleri atlamak için daha fazla performans için mümkündür.


**Hangi kod yolları veri işleme yollarıdır?**

* <span style="text-decoration:underline;">Kayıt bazı yolları:</span> Kayıt bazı yöntemler ve kod yolları, her kayıt için çağrılır. Örneğin, Bağlayıcılar, Serileştiriciler, Durum Sonları, Formatlar, Görevler, Operatörler, Ölçümler, çalışma zamanı veri yapıları, vb.
* <span style="text-decoration:underline;">I/O yöntemleri:</span> Mesajları veya veri parçalarını tamponlar arasında taşımak. Örnekler, RPC sistemi, Ağ Yığını, Dosya Sistemleri, Kodlayıcılar / Kod Çözücüler, vb.


**Performans kritik kodun ne yaptığını öğrendiği şeyler**

* Mutable nesneleri (ve bazen GC'ye basınç atmak için) kullanmak, bazen immutability için ödün vermek anlamına gelir.
* Temel türleri, temel türlerin dizilerini veya MemorySegment/ByteBuffer kullanıp temel türlerine ve byte dizilerine anlamını kodlamak, bunları ayrı sınıflar ve nesneler kullanıp kullanmamak anlamına gelir.
* Kodu, çok kayıt için çalışırken pahalı işleri (ayırma, arama, sanal yöntem çağrıları, vb.) çok kayıt için çalışırken çalışırken amortize etmek için yapılandırın.
* Okunabilirlik için optimize edilmiş kod düzeni, JIT için değil, okunabilirlik için değil, JIT derleyicisinin içine almak anlamına gelir. Örnekler, başka bir sınıfın alanlarını içine alıp (JIT'in bunu çalışma zamanında işlemesi sorgulanırken) veya kodu JIT derleyicisinin içine almak için yapılandırın, veya döngüleri içine alıp, vektörizasyonu, vb.



## 5. Eşzamanlılık ve İş Parçacığı

**Çoğunluk kod yolları herhangi bir eşzamanlılık gerektirmez.** Doğru iç içe işlevler, neredeyse her zaman ihtiyacınızı ortadan kaldırır.

* Flink çekirdeği ve çalışma zamanı, bu inşa bloklarını sağlamak için eşzamanlılık kullanır.
  Örnekler, RPC sistemi, Ağ Yığını, Görevlerin posta kutusu modeli veya bazı önceden tanımlı Kaynak / Kuyruk yardımcılarıdır.
* Flink çekirdeği ve çalışma zamanı, bu yapı bloklarını sağlamak için eşzamanlılık kullanır.
  Örnekler, RPC sistemi, Ağ Yığını, Görevlerin posta kutusu modeli veya bazı önceden tanımlı Kaynak / Kuyruk yardımcılarıdır.
* Tamamen bu noktada değiliz, ancak kendi eşzamanlılığını uygulayan herhangi bir yeni eklenti, temel sistem yapı blokları kategorisine girmedikçe inceleme altında olmalıdır.
* Katkıda bulunanlar, eşzamanlı kod uygulamaları gerektiğini düşünüyorlarsa, mevcut bir soyutlama/yapı bloğu olup olmadığını veya bir tane eklenip eklenmemesi gerektiğini görmek için committer'lar ile iletişime geçmelidir.


**Bir bileşen geliştirirken iş parçacığı modeli ve senkronizasyon noktaları hakkında önceden düşünün.**

* Örneğin: tek iş parçacıklı, engelleyici, engelleyici olmayan, senkron, asenkron, çok iş parçacıklı, iş parçacığı havuzu, mesaj kuyrukları, volatile, senkronize blok/yöntemler, muteksler, atomikler, geri çağrılar, …
* Bu şeyleri doğru almak ve bunlar hakkında önceden düşünmek, sınıf arayüzlerini/sorumluluklarını tasarlamaktan daha da önemlidir, çünkü sonradan değiştirmek çok daha zordur.


**Mümkünse her şekilde iş parçacıklarını kullanmaktan kaçınmaya çalışın.**

* Eğer bir iş parçacığı başlatmak için bir durumunuz olduğunu düşünüyorsanız, bunu açıkça incelenmesi gereken bir şey olarak pull request'te belirtin.


**İş parçacıklarını kullanmanın başlangıçta göründüğünden çok daha zor olduğunu unutmayın**

* İş parçacıklarının temiz bir şekilde kapatılması çok zordur.
* Kesintileri sağlam bir şekilde ele almak (hem yavaş kapatmadan hem de canlı kilitlerden kaçınmak) neredeyse bir Java Sihirbazı gerektirir.
* İş parçacıklarından temiz hata yayılımını tüm durumlarda sağlamak, titiz bir tasarım gerektirir.
* Çok iş parçacıklı uygulama/bileşen/sınıfın karmaşıklığı, her ek senkronizasyon noktası/blok/kritik bölüm ile üstel olarak artar. Kodunuz başlangıçta anlaşılması kolay olabilir, ancak hızlı bir şekilde bu noktanın ötesine geçebilir.
* Çok iş parçacıklı kodun düzgün şekilde test edilmesi temel olarak imkansızdır, alternatif yaklaşımlar (asenkron kod, engelleyici olmayan kod, mesaj kuyrukları ile aktör modeli gibi) test edilmesi oldukça kolaydır.
* Genellikle çok iş parçacıklı kod, modern donanımda alternatif yaklaşımlara kıyasla daha az verimlidir.


**java.util.concurrent.CompletableFuture'dan haberdar olun**

* Diğer eşzamanlı kodlarda olduğu gibi, bir CompletableFuture kullanmaya nadiren ihtiyaç olmalıdır.
* Bir future'ı tamamlamak, açıkça bir tamamlama yürütücüsü belirtilmedikçe, sonucun tamamlanmasını bekleyen zincirlenmiş herhangi bir future'ı çağrı iş parçacığında da tamamlayacaktır.
* Bu, örneğin Scheduler / ExecutionGraph'ın bölümlerinde olduğu gibi, tüm yürütme senkron / tek iş parçacıklı olması gerekiyorsa kasıtlı olabilir.
    * Flink, tek iş parçacıklı bir RPC uç noktası çalıştığı gibi aynı iş parçacığında zincirlenmiş işleyicileri çağırmaya izin vermek için bir "ana iş parçacığı yürütücüsü" kullanır.
* Bu, future'ı tamamlayan iş parçacığı hassas bir iş parçacığı ise beklenmedik olabilir.
    * Bu durumda, bir yürütücü mevcut olduğunda `future.complete(value)` yerine `CompletableFuture.supplyAsync(value, executor)` kullanmak daha iyi olabilir.
* Bir future'ın tamamlanmasını beklerken engellendiğinizde, her zaman sonuç için bir zaman aşımı sağlayın ve zaman aşımlarını açıkça ele alın.
* Şunları beklemek istiyorsanız `CompletableFuture.allOf()`/`anyOf()`, `ExecutorCompletionService` veya `org.apache.flink.runtime.concurrent.FutureUtils#waitForAll` kullanın: tüm sonuçlar/herhangi bir sonuç/tüm sonuçlar ancak (yaklaşık) tamamlanma sırasına göre ele alınan.




## 6. Bağımlılıklar ve Modüller

* **Bağımlılık ayak izini küçük tutun**
    * Ne kadar çok bağımlılık olursa, topluluğun bunları bir bütün olarak yönetmesi o kadar zorlaşır.
    * Bağımlılık yönetimi, bağımlılık çakışmaları, lisansları ve ilgili bildirimleri sürdürme ve güvenlik açıklarını ele almayı içerir.
    * Bağımlılığın gelecekteki çakışmaları önlemek için gölgelenip/yeniden konumlandırıp konumlandırılmaması gerektiğini tartışın.
* **Sadece bir yöntem için bağımlılık eklemeyin**
    * Mümkünse Java'nın yerleşik araçlarını kullanın.
    * Eğer yöntem Apache lisanslı ise, uygun atıf ile yöntemi bir Flink yardımcı sınıfına kopyalayabilirsiniz.
* **Bağımlılıkların beyanı**
    * Açıkça dayandığınız bağımlılıkları beyan edin, ister doğrudan içe aktarıp kullandığınız sınıfları sağlasın, isterse Log4J gibi doğrudan kullandığınız bir hizmet sağlasın.
    * Geçişli bağımlılıklar yalnızca çalışma zamanında ihtiyaç duyulan ancak kendinizin kullanmadığınız bağımlılıkları sağlamalıdır.
    * [[kaynak](https://stackoverflow.com/questions/15177661/maven-transitive-dependencies)]
* **Maven modüllerindeki sınıfların konumu**
    * Yeni bir sınıf oluşturduğunuzda, nereye koyacağınızı düşünün.
    * Bir sınıf gelecekte birden fazla modül tarafından kullanılabilir ve bu durumda bir `common` modülüne ait olabilir.



## 7. Test Etme

### Araçlar

Kod tabanımızı test çerçevesi ve iddia kütüphanesi olarak [JUnit 5](https://junit.org/junit5/docs/current/user-guide/) ve [AssertJ](https://assertj.github.io/doc/)'ye taşıyoruz.

Belirli bir neden olmadığı sürece, Flink'e yeni testlerle katkıda bulunurken ve hatta mevcut testleri değiştirirken JUnit 5 ve AssertJ kullandığınızdan emin olun. Hamcrest, JUnit iddialarını ve `assert` yönergesini kullanmayın.
Testlerinizi okunabilir hale getirin ve AssertJ tarafından veya bazı flink modülleri tarafından sağlanan [özel iddialar](https://assertj.github.io/doc/#assertj-core-custom-assertions) tarafından sağlanan iddia mantığını çoğaltmayın.
Örneğin, şundan kaçının:

```java
assert list.size() == 10;
for (String item : list) {
    assertTrue(item.length() < 10);
}
```

Ve bunun yerine şunu kullanın:

```java
assertThat(list)
    .hasSize(10)
    .allMatch(item -> item.length() < 10);
```

### Hedefli testler yazın

* <span style="text-decoration:underline;">Uygulamaları değil sözleşmeleri test edin</span>: Bir dizi eylemden sonra, bileşenlerin belirli bir durumda olduğunu test edin, bileşenlerin bir dizi dahili durum değişikliği izlediğini test etmek yerine.
    * Örneğin, tipik bir anti-pattern, testin bir parçası olarak belirli bir yöntemin çağrılıp çağrılmadığını kontrol etmektir.
* Bunu uygulamanın bir yolu, bir birim testi yazarken _Düzenle_, _Harekete Geç_, _İddia Et_ test yapısını takip etmeye çalışmaktır ([https://xp123.com/articles/3a-arrange-act-assert/](https://xp123.com/articles/3a-arrange-act-assert/))

  Bu, testin mekaniğinden ziyade testin amacını (test altındaki senaryo nedir) iletmeye yardımcı olur. Teknik detaylar, test sınıfının altındaki statik yöntemlere gider.

  Bu modeli takip eden Flink'teki testlerin örnekleri şunlardır:

    * [https://github.com/apache/flink/blob/master/flink-core/src/test/java/org/apache/flink/util/LinkedOptionalMapTest.java](https://github.com/apache/flink/blob/master/flink-core/src/test/java/org/apache/flink/util/LinkedOptionalMapTest.java)
    * [https://github.com/apache/flink/blob/master/flink-filesystems/flink-s3-fs-base/src/test/java/org/apache/flink/fs/s3/common/writer/RecoverableMultiPartUploadImplTest.java](https://github.com/apache/flink/blob/master/flink-filesystems/flink-s3-fs-base/src/test/java/org/apache/flink/fs/s3/common/writer/RecoverableMultiPartUploadImplTest.java)


### Mockito'dan Kaçının - Yeniden Kullanılabilir Test Uygulamaları Kullanın

* Mockito tabanlı testler, işlevselliğin çoğaltılmasını ve etki yerine uygulamayı test etmeyi teşvik ederek uzun vadede bakımı maliyetli olma eğilimindedir.
    * Daha fazla ayrıntı: [https://docs.google.com/presentation/d/1fZlTjOJscwmzYadPGl23aui6zopl94Mn5smG-rB0qT8](https://docs.google.com/presentation/d/1fZlTjOJscwmzYadPGl23aui6zopl94Mn5smG-rB0qT8)
* Bunun yerine, yeniden kullanılabilir test uygulamaları ve yardımcı programlar oluşturun.
    * Bu şekilde, bazı sınıflar değiştiğinde, sadece birkaç test yardımcı programı veya sahte nesneyi güncellemek zorunda kalırız.

### JUnit testlerinde zaman aşımlarından kaçının

Genel olarak, JUnit testlerinde yerel zaman aşımları ayarlamaktan kaçınmalı, bunun yerine Azure'daki global zaman aşımına güvenmeliyiz. Global zaman aşımı, oluşturma zaman aşımına uğramadan hemen önce iş parçacığı dökümlerini alarak hata ayıklamayı kolaylaştırır.

Aynı zamanda, manuel olarak ayarladığınız herhangi bir zaman aşımı değeri keyfidir. Çok düşük ayarlanırsa, test kararsızlıkları elde edersiniz. Çok düşük ne demek, donanım ve mevcut kullanım (özellikle G/Ç) gibi çok sayıda faktöre bağlıdır. Dahası, yerel bir zaman aşımı daha fazla bakım gerektiriyor. Bir oluşturmayı ayarlayabileceğiniz bir düğme daha. Testi biraz değiştirirseniz, zaman aşımını da iki kez kontrol etmeniz gerekir. Bu nedenle, sadece zaman aşımlarını artıran oldukça fazla commit olmuştur.


[^1]: We are keeping such frameworks out of Flink, to make debugging easier and avoid dependency clashes.
