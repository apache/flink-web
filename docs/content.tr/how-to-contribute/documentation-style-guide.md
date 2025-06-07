---
title: Dokümantasyon Stil Kılavuzu
bookCollapseSection: false
weight: 21
---

# Dokümantasyon Stil Kılavuzu

Bu kılavuz, Flink dokümantasyonunu yazma ve katkıda bulunma konusunda temel stil kurallarına genel bir bakış sağlar. Mevcut dokümantasyonu iyileştirme ve genişletme konusundaki topluluk çabasına katkı yolculuğunuzu desteklemek ve dokümantasyonu daha **erişilebilir**, **tutarlı** ve **kapsayıcı** hale getirmeye yardımcı olmak amacıyla hazırlanmıştır.

## Dil

Flink dokümantasyonu **ABD İngilizcesi** ve **Çince** dillerinde sürdürülür — dokümantasyonu genişletirken veya güncellerken, her iki sürüm de tek bir pull request ile ele alınmalıdır. Çince diline aşina değilseniz, katkınızın şu ek adımlarla tamamlandığından emin olun:

* [JIRA]({{< relref "community" >}}#issue-tracker) üzerinde chinese-translation bileşeni ile etiketlenmiş bir çeviri bileti açın;
* Bileti orijinal katkı JIRA biletine bağlayın.

Mevcut dokümantasyonu Çince'ye çevirmeye katkıda bulunmak için stil kılavuzları mı arıyorsunuz? [Bu çeviri şartnamesine](https://cwiki.apache.org/confluence/display/FLINK/Flink+Translation+Specifications) danışabilirsiniz.

## Dil Stili

Aşağıda, yazılarınızda okunabilirliği ve erişilebilirliği sağlamaya yardımcı olabilecek bazı temel kurallar bulabilirsiniz. Dil stili hakkında daha derin ve eksiksiz bir inceleme için [Genel Yönlendirici İlkeler](#genel-yönlendirici-i̇lkeler) bölümüne de bakın.

### Ses ve Ton

* **Etken çatı kullanın.** [Etken çatı](https://medium.com/@DaphneWatson/technical-writing-active-vs-passive-voice-485dfaa4e498), kısalığı destekler ve içeriği daha çekici hale getirir. Bir cümledeki fiilin ardından _zombiler tarafından_ ifadesini eklerseniz ve hala mantıklı oluyorsa, edilgen çatı kullanıyorsunuz demektir.

  * **Etken Çatı**
    "Bu örneği IDE'nizde veya komut satırında çalıştırabilirsiniz."
  * **Edilgen Çatı**
    "Bu örnek, IDE'nizde veya komut satırında çalıştırılabilir (zombiler tarafından)."

* **Biz değil, siz kullanın.** _Biz_ kullanmak bazı kullanıcılar için kafa karıştırıcı ve küçümseyici olabilir, "hepimiz gizli bir kulübün üyesiyiz ve _sen_ bir üyelik daveti almadın" izlenimi verebilir. Kullanıcıya _siz_ olarak hitap edin.

* **Cinsiyet ve kültüre özgü dilden kaçının.** Dokümantasyonda cinsiyet belirtmeye gerek yoktur: teknik yazı [cinsiyet açısından nötr](https://techwhirl.com/gender-neutral-technical-writing/) olmalıdır. Ayrıca, kendi dilinizde veya kültürünüzde doğal kabul ettiğiniz jargon ve gelenekler, başka yerlerde genellikle farklıdır. Mizah bunun tipik bir örneğidir: bir kültürde harika bir şaka, başka bir kültürde yanlış anlaşılabilir.

* **Eylemleri nitelendirmekten ve önyargılı değerlendirmelerden kaçının.** Bir eylemi tamamlamakta zorlanan veya hayal kırıklığına uğrayan bir kullanıcı için _hızlı_ veya _kolay_ gibi kelimeler kullanmak, kötü bir dokümantasyon deneyimine yol açabilir.

* **İfadeleri vurgulamak için BÜYÜK HARFLER kullanmaktan kaçının.** Anahtar kelimeleri **kalın** veya _italik_ yazı tipini kullanarak vurgulamak genellikle daha nazik görünür. Önemli ancak açık olmayan ifadelere dikkat çekmek istiyorsanız, bunları uygun bir HTML etiketi ile vurgulanan bir etiketle başlayan ayrı paragraflara gruplamayı deneyin:
    * `<span class="label label-info">Not</span>`
    * `<span class="label label-warning">Uyarı</span>`
    * `<span class="label label-danger">Tehlike</span>`

### Flink'e Özgü Terimleri Kullanma

Terimlerin net tanımlarını kullanın veya bir şeyin ne anlama geldiği konusunda, diğer dokümantasyon sayfaları veya {{< docs_link file="flink-docs-stable/docs/concepts/glossary" name="Flink Sözlüğü">}} gibi yararlı kaynaklara bağlantı ekleyerek ek talimatlar sağlayın. Sözlük hala geliştirilme aşamasındadır, bu nedenle bir pull-request açarak yeni terimler de önerebilirsiniz.

## Depo

Markdown dosyaları (.md), kapsanan konuyu özetleyen, **küçük harfle** yazılmış ve kelimeler arasında **tire (-)** ile ayrılmış kısa bir isme sahip olmalıdır. Çince sürüm dosyı, İngilizce sürümle aynı isme sahip olmalı, ancak **content.zh** klasöründe saklanmalıdır.

## Sözdizimi

Dokümantasyon web sitesi [Hugo](https://gohugo.io/) kullanılarak oluşturulur ve sayfalar, web yayıncılığı için hafif taşınabilir bir format olan (ancak bununla sınırlı olmayan) [Markdown](https://daringfireball.net/projects/markdown/syntax) ile yazılır.

### Genişletilmiş Sözdizimi

Markdown ayrıca [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/) ve düz [HTML](http://www.simplehtmlguide.com/cheatsheet.php) ile birlikte de kullanılabilir. Örneğin, bazı katkıda bulunanlar görüntüler için HTML etiketleri kullanmayı tercih eder ve bu karışımı serbestçe kullanabilirler.

### Ön Kısım (Front Matter)

Markdown'a ek olarak, her dosya, sayfada değişkenleri ve meta verileri ayarlamak için kullanılacak bir YAML [ön kısım bloğu](https://jekyllrb.com/docs/front-matter/) içerir. Ön kısım, dosyadaki ilk şey olmalı ve üçlü çizgili satırlar arasında geçerli bir YAML kümesi olarak belirtilmelidir.

### Apache Lisansı

Her dokümantasyon dosyası için, ön kısımdan hemen sonra Apache Lisansı ifadesi gelmelidir. Her iki dil sürümü için de bu blok ABD İngilizcesinde belirtilmeli ve aşağıdaki örnekteki ile tam olarak aynı kelimelerle kopyalanmalıdır.


```
---
title: Concepts
layout: redirect
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
```

Aşağıda, Flink dokümantasyonunda en yaygın kullanılan ön kısım değişkenleri bulunmaktadır.

<font size="3">
<table width="100%" class="table table-bordered">
  <thead>
  <tr>
    <th></th>
    <th style="vertical-align : middle;"><center><b>Değişken</b></center></th>
    <th style="vertical-align : middle;"><center><b>Olası Değerler</b></center></th>
    <th style="vertical-align : middle;"><center><b>Açıklama</b></center></th>
  </tr>
  <tr>
    <td><b>Layout</b></td>
    <td>layout</td>
    <td>{base,plain,redirect}</td>
    <td>Kullanılacak düzen dosyası. Düzen dosyaları <i>_layouts</i> dizini altında bulunur.</td>
  </tr>
  <tr>
    <td><b>İçerik</b></td>
    <td>title</td>
    <td>%s</td>
    <td>Sayfa için en üst düzey (Seviye-1) başlık olarak kullanılacak başlık.</td>
  </tr>
  <tr>
	    <td rowspan="4" style="vertical-align : middle;"><b>Navigasyon</b></td>
	    <td>nav-id</td>
	    <td>%s</td>
	    <td>Sayfanın ID'si. Diğer sayfalar bu ID'yi nav-parent_id olarak kullanabilir.</td>
	  </tr>
	  <tr>
	    <td>nav-parent_id</td>
	    <td>{root,%s}</td>
	    <td>Üst sayfanın ID'si. En düşük navigasyon seviyesi root'tur.</td>
	  </tr>
	  <tr>
	    <td>nav-pos</td>
	    <td>%d</td>
	    <td>Navigasyon seviyesi başına sayfaların göreceli konumu.</td>
	  </tr>
	  <tr>
	    <td>nav-title</td>
	    <td>%s</td>
	    <td>Varsayılan bağlantı metnini (başlık) geçersiz kılmak için kullanılacak başlık.</td>
	  </tr>
 </thead>
</table>
</font>

`_config.yml` altında bulunan dokümantasyon genelindeki bilgiler ve yapılandırma ayarları da site değişkeni aracılığıyla ön kısma sunulur. Bu ayarlara aşağıdaki sözdizimi kullanılarak erişilebilir:

```liquid
{{ "{{ site.CONFIG_KEY " }}}}
```
Yer tutucu, dokümantasyon oluşturulurken `CONFIG_KEY` adlı değişkenin değeriyle değiştirilecektir.

## Biçimlendirme

Aşağıdaki bölümlerde, tutarlı ve gezinmesi kolay dokümantasyon yazma konusunda sizi başlatacak temel biçimlendirme kuralları listelenmiştir.

### Başlıklar

Markdown'da başlıklar, başında diyez işareti (#) olan herhangi bir satırdır; diyez sayısı başlık düzeyini gösterir. Başlıklar iç içe ve ardışık olmalıdır — stil nedeniyle asla bir başlık düzeyini atlamayın!

<font size="3">
<table width="100%" class="table table-bordered">
  <thead>
  <tr>
    <th style="vertical-align : middle;"><center><b>Sözdizimi</b></center></th>
    <th style="vertical-align : middle;"><center><b>Seviye</b></center></th>
    <th style="vertical-align : middle;"><center><b>Açıklama</b></center></th>
  </tr>
  <tr>
    <td># Başlık</td>
    <td><center>Seviye-1</center></td>
    <td>Sayfa başlığı Ön Kısımda tanımlanır, bu nedenle bu seviye <b>kullanılmamalıdır</b>.</td>
  </tr>
  <tr>
    <td>## Başlık</td>
    <td><center>Seviye-2</center></td>
    <td>Bölümler için başlangıç seviyesi. İçeriği daha yüksek düzeydeki konulara veya hedeflere göre düzenlemek için kullanılır.</td>
  </tr>
  <tr>
    <td>### Başlık</td>
    <td><center>Seviye-3</center></td>
    <td rowspan="2" style="vertical-align : middle;">Alt bölümler. Destekleyici bilgileri veya görevleri ayırmak için her Bölümde kullanılır.</td>
  </tr>
  <tr>
    <td>#### Başlık</td>
    <td><center>Seviye-4</center></td>
  </tr>
</thead>
</table>
</font>

#### En İyi Uygulama

Başlıkların ifadesinde açıklayıcı bir dil kullanın. Örneğin, dinamik tablolar hakkında bir dokümantasyon sayfası için, "Arka Plan" veya "Teknik Bilgi" yerine "Dinamik Tablolar ve Sürekli Sorgular" daha açıklayıcıdır.

### İçindekiler

Dokümantasyon oluşturulurken, **İçindekiler** (TOC) otomatik olarak aşağıdaki işaretleme satırı kullanılarak sayfanın başlıklarından oluşturulur:

```liquid
{{ "{:toc" }}}
```

**Seviye-3**'e kadar tüm başlıklar dikkate alınır. Belirli bir başlığı TOC'den hariç tutmak için:

```liquid
{{ "# Hariç Tutulan Başlık
{:.no_toc" }}}
```

#### En İyi Uygulama

Ele alınan konuya kısa ve öz bir giriş yazın ve bunu TOC'den önce yerleştirin. Temel mesajların bir taslağı gibi küçük bir bağlam, dokümantasyonun tutarlı olmasını ve her bilgi seviyesindeki kişiler tarafından anlaşılabilir olmasını sağlamada uzun bir yol kat eder.


### Navigasyon

Dokümantasyon oluşturulurken, navigasyon her sayfanın [ön kısım değişkenleri](#ön-kısım-front-matter) içinde yapılandırılan özellikler kullanılarak tanımlanır.

Kapsamlı dokümantasyon sayfalarında, kullanıcıların manuel olarak yukarı kaydırmadan sayfanın başına gidebilmelerini sağlayan _Başa Dön_ bağlantıları kullanmak mümkündür. İşaretlemede bu, dokümantasyon oluşturulduğunda varsayılan bir bağlantı ile değiştirilen bir yer tutucu olarak uygulanır:

```liquid
{{ "{% top " }}%}
```

#### En İyi Uygulama

Başa Dön bağlantılarını en azından her Seviye-2 bölümünün sonunda kullanmanız önerilir.

### Açıklamalar

Dokümantasyona uç durumları, sıkı ilişkili bilgileri veya bilinmesi güzel bilgileri dahil etmek istediğinizde, bunları özel açıklamalar kullanarak vurgulamak çok iyi bir uygulamadır.

* Yararlı olabilecek bir ipucu veya bilgi parçasını vurgulamak için:

  ```html
  <div class="alert alert-info"> // Bilgi Mesajı </div>
  ```

* Tuzakların tehlikesini bildirmek veya takip edilmesi kritik öneme sahip önemli bir bilgi parçasına dikkat çekmek için:

  ```html
  <div class="alert alert-danger"> // Tehlike Mesajı </div>
  ```

### Bağlantılar

Dokümantasyona bağlantılar eklemek, kullanıcıyı üzerine yazma riski olmadan konuyu daha iyi anlamasına yönlendirmenin etkili bir yoludur.

* **Sayfadaki bölümlere bağlantılar.** Her başlık, bir sayfa içinde doğrudan bağlantı vermek için örtük bir tanımlayıcı oluşturur. Bu tanımlayıcı, başlığı küçük harfe çevirerek ve iç boşlukları kısa çizgilerle değiştirerek oluşturulur.

    * **Başlık:** ## Başlık Adı
    * **ID:** #başlık-adı
  <p></p>

  ```liquid 
  [Bağlantı Metni](#başlık-adı) 
  ```

* **Flink dokümantasyonunun diğer sayfalarına bağlantılar.**

  ```liquid 
  [Bağlantı Metni]({% link path/to/link-page.md %})
  ```

* **Harici sayfalara bağlantılar**

  ```liquid 
  [Bağlantı Metni](external_url)
  ```

#### En İyi Uygulama

Eylem veya hedef hakkında bilgi veren açıklayıcı bağlantılar kullanın. Örneğin, "Daha Fazla Bilgi" veya "Buraya Tıklayın" bağlantıları kullanmaktan kaçının.

### Görsel Öğeler

Şekiller ve diğer görsel öğeler kök _fig_ klasörü altına yerleştirilir ve dokümantasyon sayfalarında bağlantılara benzer bir sözdizimi kullanılarak referans gösterilebilir:

```liquid 
{{< img src="/fig/image_name.png" alt="Resim Metni" width="200px" >}}
```

#### En İyi Uygulama

Akış şemaları, tablolar ve şekilleri uygun veya gerekli olduğunda ek açıklama için kullanın, ancak asla tek başına bilgi kaynağı olarak kullanmayın. Bu öğelere dahil edilen herhangi bir metnin okunabilecek kadar büyük olduğundan ve genel çözünürlüğün yeterli olduğundan emin olun.

### Kod

* **Satır içi kod.** Normal metin akışında küçük kod parçaları veya dil yapılarına referanslar çevreleyen ters tırnak işaretleriyle ( **\`** ) vurgulanmalıdır.

* **Kod blokları.** Kendi başına yeterli örnekleri, özellik tanıtımlarını, en iyi uygulamaların gösterimini veya diğer yararlı senaryoları temsil eden kod, uygun [sözdizimi vurgulaması](https://github.com/rouge-ruby/rouge/wiki/List-of-supported-languages-and-lexers) ile çevrili bir kod bloğu kullanılarak sarılmalıdır. Bunu işaretleme ile elde etmenin bir yolu:

  ````liquid
  ```java 
     // Java Kodu
  ```
  ````

Birden fazla programlama dili belirtirken, her kod bloğu bir sekme olarak şekillendirilmelidir:

  ```html
  <div class="codetabs" markdown="1">

	  <div data-lang="java" markdown="1"> 

	  ```java
	   // Java Kodu
	  ```

	  </div>

	  <div data-lang="scala" markdown="1">

	  ```scala
	   // Scala Kodu
	  ```

	  </div> 

  </div>
  ```

Bu kod blokları genellikle öğrenmek ve keşfetmek için kullanılır, bu nedenle akılda tutulması gereken bazı en iyi uygulamalar vardır:

* **Anahtar geliştirme görevlerini sergileyin.** Kod örneklerini, kullanıcılar için anlamlı olan yaygın uygulama senaryoları için saklayın. Daha uzun ve karmaşık örnekleri öğreticiler veya adım adım kılavuzlar için bırakın.

* **Kodun bağımsız olduğundan emin olun.** Kod örnekleri kendi kendine yeterli olmalı ve harici bağımlılıklara sahip olmamalıdır (belirli konnektörlerin nasıl kullanılacağına ilişkin örnekler gibi aykırı durumlar hariç). Joker karakterler kullanmadan tüm import ifadelerini dahil edin, böylece yeni başlayanlar hangi paketlerin kullanıldığını anlayabilir ve öğrenebilir.

* **Kısayollardan kaçının.** Örneğin, gerçek dünya kodunda yapacağınız gibi istisnaları ve temizleme işlemlerini ele alın.

* **Yorumlar ekleyin, ancak abartmayın.** Kodun ana işlevselliğini ve okunmasından açık olmayabilecek olası tuzakları açıklayan bir giriş sağlayın. Uygulama ayrıntılarını açıklamak ve beklenen çıktıyı tanımlamak için yorumlar kullanın.

* **Kod bloklarındaki komutlar.** Komutlar, `bash` sözdizimi vurgulanan kod blokları kullanılarak belgelenebilir. Dokümantasyona komut eklerken aşağıdaki hususlar dikkate alınmalıdır:
    * **Uzun parametre adları kullanın.** Uzun parametre adları, okuyucunun komutun amacını anlamasına yardımcı olur. Bunlar, kısa muadillerine göre tercih edilmelidir.
    * **Satır başına bir parametre.** Uzun parametre adları kullanmak, komutu okumayı muhtemelen zorlaştırır. Her satıra bir parametre koymak okunabilirliği artırır. Kopyala ve yapıştır işlemini desteklemek için her ara satırın sonunda satır sonunu belirten bir ters eğik çizgi `\` eklemeniz gerekir.
    * **Girinti**. Each new parameter line should be indented by 6 spaces.
    * **Komut başlangıcını belirtmek için `$` öneki kullanın**. Birden fazla komut olduğunda kod bloğunun okunabilirliği kötüleşebilir. Her yeni komutun önüne dolar işareti `$` koymak bir komutun başlangıcını belirlemeye yardımcı olur.

  Doğru biçimlendirilmiş bir komut şöyle görünür:

```bash
$ ./bin/flink run-application \
--target kubernetes-application \
-Dkubernetes.cluster-id=my-first-application-cluster \
-Dkubernetes.container.image=custom-image-name \
local:///opt/flink/usrlib/my-flink-job.jar
```

## Genel Yönlendirici İlkeler

Bu stil kılavuzu, **Erişilebilir**, **Tutarlı**, **Nesnel**, **Mantıklı** ve **Kapsayıcı** dokümantasyon için temel oluşturma gibi kapsayıcı bir amaca sahiptir.

#### Erişilebilir

Flink topluluğu çeşitli ve uluslararasıdır, bu nedenle dokümantasyon yazarken geniş ve küresel düşünmeniz gerekir. Herkes İngilizceyi anadil düzeyinde konuşmaz ve Flink (ve genel olarak stream processing) ile ilgili deneyim seviyesi mutlak yeni başlayanlardan deneyimli ileri düzey kullanıcılara kadar değişir. Ürettiğiniz içerikte teknik doğruluğu ve dilsel netliği sağlayın, böylece tüm kullanıcılar tarafından anlaşılabilsin.

#### Tutarlı

Bu stil kılavuzunda detaylandırılan temel kurallara bağlı kalın ve metni yazım, büyük harf kullanımı, kısa çizgi kullanımı, kalın ve italik yazma konusunda aynı şekilde biçimlendirmek için kendi en iyi yargınızı kullanın. Doğru dilbilgisi, noktalama ve yazım arzu edilir, ancak sert bir gereklilik değildir — dokümantasyon katkıları her düzeyde dil yeterliliğine açıktır.

#### Nesnel

Cümlelerinizi kısa ve öz tutun. Bir kural olarak, eğer bir cümle 14 kelimeden kısaysa, okuyucular muhtemelen içeriğinin yüzde 90'ını anlayacaktır. 25'ten fazla kelime içeren cümleler genellikle anlaşılması daha zordur ve mümkün olduğunda gözden geçirilmeli ve bölünmelidir. Kısa ve öz olmak ve iyi bilinen anahtar kelimeler kullanmak, kullanıcıların ilgili dokümantasyona az çabayla ulaşmalarını sağlar.

#### Mantıklı

Çoğu kullanıcının çevrimiçi içeriği tarayacağını ve sadece [yüzde 28'ini](https://www.nngroup.com/articles/website-reading/) okuyacağını unutmayın. Bu, ilgili fikirleri açık bir bilgi hiyerarşisinde bir araya getirmenin ve odaklanmış, açıklayıcı başlıklar kullanmanın önemini vurgular. Her bölümün ilk iki paragrafına en ilgili bilgileri yerleştirmek, kullanıcı için "harcanan zamanın geri dönüşünü" artıran iyi bir uygulamadır.

#### Kapsayıcı

İçeriğin tüm kullanıcılar tarafından bulunabilir ve onlara açık olmasını sağlamak için olumlu bir dil ve somut, ilişkilendirilebilir örnekler kullanın. Dokümantasyon diğer dillere çevrilir, bu nedenle basit bir dil ve tanıdık kelimeler kullanmak çeviri çabasını da azaltmaya yardımcı olur.