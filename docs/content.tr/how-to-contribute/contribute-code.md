---
title: Kod Katkısında Bulunma
bookCollapseSection: false
weight: 17
---

# Kod Katkısında Bulunma

Apache Flink, gönüllülerin kod katkılarıyla bakımı yapılan, geliştirilen ve genişletilen bir projedir. Flink'e yapılan katkıları memnuniyetle karşılıyoruz, ancak projenin büyüklüğü ve kod tabanının yüksek kalitesini korumak için bu belgede açıklanan bir katkı sürecini takip ediyoruz.

**Lütfen istediğiniz zaman soru sormaktan çekinmeyin.** [Geliştirici e-posta listesine]({{< relref "community" >}}#mailing-lists) bir e-posta gönderin veya üzerinde çalıştığınız Jira sorununa yorum yapın.

**ÖNEMLİ**: Kod katkısında bulunmaya başlamadan önce lütfen bu belgeyi dikkatlice okuyun. Aşağıda açıklanan süreci ve yönergeleri izleyin. Apache Flink'e katkıda bulunmak, bir pull request açmakla başlamaz. Katkıda bulunanların önce bizimle iletişime geçerek genel yaklaşımı birlikte tartışmalarını bekliyoruz. Flink committer'ları ile fikir birliği olmadan, katkılar önemli ölçüde yeniden çalışma gerektirebilir veya incelenmeyecektir.

## Ne katkıda bulunacağınızı arıyorsunuz

Katkı için iyi bir fikriniz varsa, [kod katkı sürecine](#code-contribution-process) geçebilirsiniz.
Neye katkıda bulunabileceğinizi arıyorsanız, [Flink'in hata izleyicisinde]({{< relref "community" >}}#issue-tracker) atanmamış açık Jira sorunlarına göz atabilir ve ardından [kod katkı sürecini](#code-contribution-process) takip edebilirsiniz. Flink projesine çok yeniyseniz ve proje ve katkı süreci hakkında bilgi edinmek istiyorsanız, _starter_ etiketi ile işaretlenmiş [başlangıç sorunlarını](https://issues.apache.org/jira/issues/?filter=12349196) kontrol edebilirsiniz.

## Kod Katkı Süreci

<style>
.contribute-grid {
  margin-bottom: 10px;
  display: flex;
  flex-direction: column;
  margin-left: -2px;
  margin-right: -2px;
}

.contribute-grid .column {
  margin-top: 4px;
  padding: 0 2px;
}

@media only screen and (min-width: 480px) {
  .contribute-grid {
    flex-direction: row;
    flex-wrap: wrap;
  }

  .contribute-grid .column {
    flex: 0 0 50%;
  }

  .contribute-grid .column {
    margin-top: 4px;
  }
}

@media only screen and (min-width: 960px) {
  .contribute-grid {
    flex-wrap: nowrap;
  }

  .contribute-grid .column {
    flex: 0 0 25%;
  }

}

.contribute-grid .panel {
  height: 100%;
  margin: 0;
}

.contribute-grid .panel-body {
  padding: 10px;
}

.contribute-grid h2 {
  margin: 0 0 10px 0;
  padding: 0;
  display: flex;
  align-items: flex-start;
  border: none;
}

.contribute-grid .number {
  margin-right: 0.25em;
  font-size: 1.5em;
  line-height: 0.9;
}
</style>


<div class="alert alert-warning" role="alert">
    <b>Not:</b> Kod katkı süreci yakın zamanda değişti (Haziran 2019). Topluluk, pull request'lerden Jira'ya "geri basıncı" kaydırmaya <a href="https://lists.apache.org/thread.html/1e2b85d0095331606ad0411ca028f061382af08138776146589914f8@%3Cdev.flink.apache.org%3E">karar verdi</a>. Bu nedenle katkıda bulunanların, pull request açmadan önce fikir birliğine varmaları (bilete atanmaları ile belirtilir) gerekmektedir.
</div>


<div class="contribute-grid">
  <div class="column">
    <div class="panel panel-default">
      <div class="panel-body">
        <h2><span class="number">1</span><a href="#consensus">Tartış</a></h2>
        <p>Bir Jira bileti veya e-posta listesi tartışması oluşturun ve fikir birliğine varın</p>
        <p>Biletin önemi, ilgisi, kapsamı konusunda anlaşın, uygulama yaklaşımını tartışın ve değişikliği incelemeye ve birleştirmeye istekli bir committer bulun.</p>
        <p><b>Jira biletlerini yalnızca committer'lar atayabilir.</b></p>
      </div>
    </div>
  </div>
  <div class="column">
    <div class="panel panel-default">
      <div class="panel-body">
        <h2><span class="number">2</span><a href="#implement">Uygula</a></h2>
        <p>Değişikliği <a href="{{< relref "how-to-contribute/code-style-and-quality-preamble" >}}">Kod Stili ve Kalite Kılavuzu</a>'na ve Jira biletinde üzerinde anlaşılan yaklaşıma göre uygulayın.</p> <br />
        <p><b>Yaklaşım konusunda fikir birliği varsa (örneğin bilet size atanmışsa) uygulamaya başlayın</b></p>
      </div>
    </div>
  </div>
  <div class="column">
    <div class="panel panel-default">
      <div class="panel-body">
        <h2><span class="number">3</span><a href="#review">İnceleme</a></h2>
        <p>Bir pull request açın ve inceleyici ile çalışın.</p>
        <p><b>Atanmamış Jira biletlerine ait veya atanan kişi tarafından yazılmamış pull request'ler topluluk tarafından incelenmeyecek veya birleştirilmeyecektir.</b></p>
      </div>
    </div>
  </div>
  <div class="column">
    <div class="panel panel-default">
      <div class="panel-body">
        <h2><span class="number">4</span><a href="#merge">Birleştir</a></h2>
        <p>Flink'in bir committer'ı, katkının gereksinimleri karşılayıp karşılamadığını kontrol eder ve kodu kod tabanına birleştirir.</p>
      </div>
    </div>
  </div>
</div>

<div class="row">
  <div class="col-sm-12">
    <div class="panel panel-default">
      <div class="panel-body">
        Not: Yazım hataları veya sözdizimi hataları gibi <i>önemsiz</i> acil düzeltmeler, Jira bileti olmadan <code>[hotfix]</code> pull request'i olarak açılabilir.
      </div>
    </div>
  </div>
</div>



<a name="consensus"></a>

### 1. Jira Bileti Oluşturun ve Fikir Birliğine Varın


Apache Flink'e katkıda bulunmanın ilk adımı, Flink topluluğuyla fikir birliğine varmaktır. Bu, bir değişikliğin kapsamı ve uygulama yaklaşımı konusunda anlaşmak anlamına gelir.

Çoğu durumda tartışma, [Flink'in hata izleyicisi: Jira]({{< relref "community" >}}#issue-tracker)'da gerçekleşmelidir.

Aşağıdaki değişiklik türleri, [Flink Geliştirici e-posta listesinde]({{< relref "community" >}}#mailing-lists) bir `[DISCUSS]` konusu gerektirir:

- büyük değişiklikler (önemli yeni özellik; büyük yeniden düzenlemeler, birden fazla bileşeni içeren)
- potansiyel olarak tartışmalı değişiklikler veya konular
- yaklaşımların belirsiz olduğu veya birden fazla eşit yaklaşımın olduğu değişiklikler

Tartışma bir sonuca varmadan önce bu tür değişiklikler için bir Jira bileti açmayın.
Bir dev@ tartışmasına dayalı Jira biletlerinin o tartışmaya bağlantı vermesi ve sonucu özetlemesi gerekir.



**Bir Jira biletinin fikir birliğine varması için gereksinimler:**

- Resmi gereksinimler
    - *Başlık* sorunu kısaca açıklar.
    - *Açıklama*, sorunu veya özellik isteğini anlamak için gereken tüm ayrıntıları verir.
    - *Bileşen* alanı ayarlanmıştır: Birçok committer ve katkıda bulunan sadece Flink'in belirli alt sistemlerine odaklanır. Uygun bileşeni ayarlamak, dikkatlerini çekmek için önemlidir.
- Biletin geçerli bir sorunu çözdüğü ve Flink için **iyi bir uyum** olduğu konusunda **anlaşma** vardır.
  Flink topluluğu aşağıdaki hususları göz önünde bulundurur:
    - Katkı, özellikler veya bileşenlerin davranışını, önceki kullanıcıların programlarını ve kurulumlarını bozabilecek şekilde değiştiriyor mu? Eğer öyleyse, bu değişikliğin arzu edilir olduğu konusunda bir tartışma ve anlaşma olmalıdır.
    - Katkı kavramsal olarak Flink'e iyi uyuyor mu? Soyutlamaları/API'leri daha karmaşık hale getirecek kadar özel bir durum mu?
    - Özellik Flink'in mimarisine iyi uyuyor mu? Ölçeklenecek mi ve Flink'i gelecek için esnek tutacak mı, yoksa özellik Flink'i gelecekte kısıtlayacak mı?
    - Özellik, (mevcut bir parçanın iyileştirilmesinden ziyade) önemli bir yeni eklenti mi? Eğer öyleyse, Flink topluluğu bu özelliği sürdürmeyi taahhüt edecek mi?
    - Bu özellik, Flink'in yol haritası ve şu anda devam eden çabalarla iyi uyumlu mu?
    - Özellik, Flink kullanıcıları veya geliştiricileri için katma değer üretiyor mu? Yoksa ilgili kullanıcı veya geliştirici faydası sağlamadan regresyon riski mi getiriyor?
    - Katkı, örneğin Apache Bahir veya başka bir harici depoda yaşayabilir mi?
    - Bu, sadece açık kaynaklı bir projede commit almak için yapılan bir katkı mı (yazım hatalarını düzeltme, sadece zevk için stil değişiklikleri yapma)
- Sorunun nasıl çözüleceği konusunda **fikir birliği** vardır. Bu, aşağıdaki hususları içerir:
    - API ve veri geriye dönük uyumluluğu ve geçiş stratejileri
    - Test stratejileri
    - Flink'in derleme süresi üzerindeki etki
    - Bağımlılıklar ve lisansları

Eğer bir değişiklik Jira'daki tartışmada büyük veya tartışmalı bir değişiklik olarak tanımlanırsa, anlaşma ve fikir birliğine varmak için bir [Flink İyileştirme Önerisi (FLIP)](https://cwiki.apache.org/confluence/display/FLINK/Flink+Improvement+Proposals) veya [Geliştirici e-posta listesinde]({{< relref "community" >}}#mailing-lists) bir tartışma gerektirebilir.

Katkıda bulunanlar, bileti açtıktan sonra birkaç gün içinde bir committer'dan ilk tepkiyi alabilirler. Eğer bir bilet dikkat çekmezse, [geliştirici e-posta listesine]({{< relref "community" >}}#mailing-lists) ulaşmanızı öneririz. Flink topluluğunun bazen gelen tüm katkıları kabul etme kapasitesi olmadığını unutmayın.


Biletin tüm gereksinimleri karşılandığında, bir committer üzerinde çalışması için birini biletin *`Assignee`* alanına atayacaktır.
Yalnızca committer'ların birini atama izni vardır.

**Atanmamış Jira biletlerine ait pull request'ler topluluk tarafından incelenmeyecek veya birleştirilmeyecektir**.


<a name="implement"></a>

### 2. Değişikliğinizi uygulayın

Bir Jira sorununa atandıktan sonra, gerekli değişiklikleri uygulamaya başlayabilirsiniz.

Uygulama sırasında akılda tutulması gereken bazı diğer noktalar:

- [Bir Flink geliştirme ortamı kurun](https://cwiki.apache.org/confluence/display/FLINK/Setting+up+a+Flink+development+environment)
- Flink'in [Kod Stili ve Kalite Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-preamble" >}})'nu takip edin
- Jira sorunu veya tasarım belgesindeki tüm tartışmaları ve gereksinimleri dikkate alın.
- İlgisiz sorunları tek bir katkıda karıştırmayın.


<a name="review"></a>

### 3. Bir Pull Request Açın

Pull request açmadan önce dikkat edilmesi gerekenler:

- Tüm kontrollerin geçtiğinden, kodun derlendiğinden ve tüm testlerin geçtiğinden emin olmak için **`mvn clean verify`** komutunun değişikliklerinizde başarıyla çalıştığından emin olun.
- [Flink'in Uçtan Uca testlerini](https://github.com/apache/flink/tree/master/flink-end-to-end-tests#running-tests) çalıştırın.
- İlgisiz veya gereksiz yeniden biçimlendirme değişikliklerinin dahil edilmediğinden emin olun.
- Commit geçmişinizin gereksinimlere uyduğundan emin olun.
- Değişikliğinizin taban dalınızdaki en son commit'lere yeniden yazıldığından emin olun.
- Pull request'in ilgili Jira'ya atıfta bulunduğundan ve her Jira sorununun tam olarak bir pull request'e atandığından emin olun (bir Jira için birden fazla pull request varsa, önce bu durumu çözün)

Pull request açmadan önce veya açtıktan hemen sonra dikkate alınması gerekenler:

- Dalın [Azure DevOps](https://dev.azure.com/apache-flink/apache-flink/_build?definitionId=2) üzerinde başarıyla oluşturulduğundan emin olun.

Flink'teki kod değişiklikleri, [GitHub pull request'leri](https://help.github.com/en/articles/creating-a-pull-request) aracılığıyla incelenir ve kabul edilir.

[Bir pull request'i nasıl inceleyeceğiniz]({{< relref "how-to-contribute/reviewing-prs" >}}) konusunda, pull request inceleme sürecimizi de içeren ayrı bir kılavuz bulunmaktadır. Kod yazarı olarak, pull request'inizi tüm gereksinimleri karşılayacak şekilde hazırlamalısınız.

<a name="merge"></a>

### 4. Değişikliği birleştirin

İnceleme tamamlandıktan sonra kod, Flink'in bir committer'ı tarafından birleştirilecektir. Ardından Jira bileti kapatılacaktır.

