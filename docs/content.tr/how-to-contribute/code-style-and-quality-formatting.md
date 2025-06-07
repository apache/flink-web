---
title: Kod Stili ve Kalite Kılavuzu — Biçimlendirme Kılavuzu
bookCollapseSection: false
bookHidden: true
---

# Kod Stili ve Kalite Kılavuzu — Biçimlendirme Kılavuzu

#### [Önsöz]({{< relref "how-to-contribute/code-style-and-quality-preamble" >}})
#### [Pull Request'ler ve Değişiklikler]({{< relref "how-to-contribute/code-style-and-quality-pull-requests" >}})
#### [Genel Kodlama Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-common" >}})
#### [Java Dili Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-java" >}})
#### [Scala Dili Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-scala" >}})
#### [Bileşenler Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-components" >}})
#### [Biçimlendirme Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-formatting" >}})

## Java Kodu Biçimlendirme Stili

IDE'yi otomatik olarak kod stilini kontrol edecek şekilde ayarlamanızı öneriyoruz. Lütfen {{< docs_link file="flink-docs-stable/docs/flinkdev/ide_setup/" name="IDE Kurulum Kılavuzu">}} sayfasını takip ederek
{{< docs_link file="flink-docs-stable/docs/flinkdev/ide_setup/#code-formatting" name="spotless">}} ve
{{< docs_link file="flink-docs-stable/docs/flinkdev/ide_setup/#checkstyle-for-java" name="checkstyle">}} araçlarını kurun.

### Lisans

* **Apache lisans başlıkları.** Dosyalarınızda Apache Lisans başlıklarının olduğundan emin olun. Kodu derlediğinizde RAT eklentisi bunu kontrol eder.

### Import İfadeleri

* **Paket bildirimi öncesinde ve sonrasında boş satır.**
* **Kullanılmayan import ifadeleri olmamalı.**
* **Gereksiz import ifadeleri olmamalı.**
* **Wildcard import ifadeleri olmamalı.** Bunlar, koda ekleme yaparken ve bazı durumlarda yeniden düzenleme sırasında bile sorunlara neden olabilir.
* **Import sıralaması.** Import ifadeleri alfabetik olarak sıralanmalı, aşağıdaki bloklara ayrılmalı ve her blok arasında boş bir satır olmalıdır:
    * &lt;org.apache.flink.* 'den importlar&gt;
    * &lt;org.apache.flink.shaded.* 'den importlar&gt;
    * &lt;diğer kütüphanelerden importlar&gt;
    * &lt;javax.* 'den importlar&gt;
    * &lt;java.* 'den importlar&gt;
    * &lt;scala.* 'den importlar&gt;
    * &lt;static importlar&gt;


### İsimlendirme

* **Paket adları bir harfle başlamalı ve büyük harf veya özel karakterler içermemelidir.**
  **Non-private static final alanlar büyük harf olmalı ve kelimeler alt çizgilerle ayrılmalıdır.**(`MY_STATIC_VARIABLE`)
* **Non-static alanlar/metodlar küçük deve (camel) case olmalıdır.** (`myNonStaticField`)


### Boşluklar

* **Tablar ve boşluklar.** Girinti için tab yerine boşluk kullanıyoruz.
* **Satır sonunda boşluk olmamalı.**
* **Operatörler/anahtar kelimeler etrafında boşluklar.** Operatörler (`+`, `=`, `>`, …) ve anahtar kelimeler (`if`, `for`, `catch`, …) satırın başında veya sonunda olmadıkları sürece önlerinde ve arkalarında bir boşluk olmalıdır.


### Uzun İfadelerde Satır Düzenleme Kuralları

Genel olarak, kod okunabilirliğini artırmak için uzun satırlardan kaçınılmalıdır. Aynı soyutlama düzeyinde çalışan kısa ifadeler kullanmaya çalışın. Uzun ifadeleri, daha fazla yerel değişken tanımlayarak, yardımcı metodlar oluşturarak vb. yollarla kısaltın.

Uzun satırların iki temel kaynağı şunlardır:

* **Fonksiyon tanımında veya çağrısında uzun argüman listesi**: `void func(type1 arg1, type2 arg2, ...)`
* **Uzun zincirleme metod çağrı dizisi**: `list.stream().map(...).reduce(...).collect(...)...`

Uzun satırları kırma kuralları:

* Satır uzunluk sınırını aşıyorsa veya kırmanın kod okunabilirliğini artıracağını düşünüyorsanız argüman listesini veya çağrı zincirini kırın
* Bir satırı kırdığınızda, ilk argüman/çağrı da dahil olmak üzere her argüman/çağrı ayrı bir satırda olmalıdır
* Her yeni satır, üst fonksiyon adının veya çağrılan öğenin satırına göre bir ek girinti (fonksiyon tanımı için iki) içermelidir

Fonksiyon argümanları için ek kurallar:

* Açılış parantezi her zaman üst fonksiyon adının bulunduğu satırda kalır
* Olası fırlatılan istisna listesi asla kırılmaz ve satır uzunluğu limitini aşsa bile aynı son satırda kalır
* Son argüman hariç, fonksiyon argümanının bulunduğu her satır aynı satırda kalan bir virgülle bitmelidir

Fonksiyon argümanları listesini kırma örneği:

```
public void func(
    int arg1,
    int arg2,
    ...) throws E1, E2, E3 {

}
```

Zincirleme bir çağrıda nokta işareti her zaman, o zincirleme çağrının kendi satırında, çağrının başında yer alır.

Zincirleme çağrılar listesini kırma örneği:

```
values
    .stream()
    .map(...)
    .collect(...);
```


### Süslü Parantezler

* **Sol süslü parantezler (<code>{</code>) yeni bir satıra yerleştirilmemelidir.**
* <strong>Sağ süslü parantezler (<code>}</code>) her zaman satırın başına yerleştirilmelidir.</strong>
* <strong>Bloklar.</strong> <code>if</code>, <code>for</code>, <code>while</code>, <code>do</code>, … gibi ifadelerden sonra gelen tüm ifadeler, her zaman süslü parantezlerle bir blok içinde kapsüllenmelidir (blok bir ifade içerse bile).


### Javadoc'lar

* **Tüm public/protected metodlar ve sınıflar bir Javadoc'a sahip olmalıdır.**
* **Javadoc'un ilk cümlesi bir nokta ile bitmelidir.**
* **Paragraflar yeni bir satırla ayrılmalı ve <p> ile başlamalıdır.**


### Erişim Belirteçleri (Modifiers)

* **Gereksiz erişim belirteçleri olmamalı.** Örneğin, interface metodlarında public erişim belirteçleri.
* **JLS3 erişim belirteci sıralamasını takip edin.** Erişim belirteçleri şu sırayla düzenlenmelidir: public, protected, private, abstract, static, final, transient, volatile, synchronized, native, strictfp.


### Dosyalar

* **Tüm dosyalar <code>\n</code> ile bitmelidir.**
* <strong>Dosya uzunluğu 3000 satırı geçmemelidir.</strong>


### Çeşitli

* **Diziler Java tarzında tanımlanmalıdır.** Örneğin, `public String[] array`.
* **Flink Preconditions kullanın.** Homojenliği artırmak için, Apache Commons Validate veya Google Guava yerine tutarlı bir şekilde `org.apache.flink.Preconditions` metodları olan `checkNotNull` ve `checkArgument` kullanın.

[^1]: Bu tür framework'leri hata ayıklamayı kolaylaştırmak ve bağımlılık çakışmalarını önlemek için Flink'in dışında tutuyoruz.
