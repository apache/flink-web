---
title: Pull Request'leri İnceleme
bookCollapseSection: false
weight: 18
---

# Bir Pull Request Nasıl İncelenir

Bu kılavuz, kod katkılarını incelemek isteyen tüm committer'lar ve katkıda bulunanlar içindir. Çabanız için teşekkür ederiz - iyi incelemeler, bir açık kaynak projesinin en önemli ve kritik parçalarından biridir. Bu kılavuz, topluluğun aşağıdaki şekilde incelemeler yapmasına yardımcı olmayı amaçlamaktadır:

* Katkıda bulunanlar iyi bir katkı deneyimi yaşarlar.
* İncelemelerimiz yapılandırılmıştır ve bir katkının tüm önemli yönlerini kontrol eder.
* Flink'te yüksek kod kalitesini korumayı sağlarız.
* Katkıda bulunanların ve inceleyicilerin, daha sonra reddedilen bir katkıyı geliştirmek için çok zaman harcadığı durumlardan kaçınırız.

## İnceleme Kontrol Listesi

Her inceleme aşağıdaki altı yönü kontrol etmelidir. **Bu yönleri sırayla kontrol etmenizi teşvik ediyoruz; böylece resmi gereksinimler karşılanmadığında veya değişikliği kabul etmek için toplulukta fikir birliği olmadığında, ayrıntılı kod kalitesi incelemelerine zaman harcamaktan kaçınmış olursunuz.**

### 1. Katkı İyi Tanımlanmış mı?

Katkının, iyi bir incelemeyi desteklemek için yeterince iyi tanımlanıp tanımlanmadığını kontrol edin. Önemsiz değişiklikler ve düzeltmeler uzun bir açıklama gerektirmez. Uygulama tam olarak [Jira'daki veya geliştirme e-posta listesindeki önceki tartışmaya göre]({{< relref "how-to-contribute/contribute-code" >}}#consensus) ise, sadece o tartışmaya kısa bir referans yeterlidir.
Uygulama, fikir birliği tartışmasında üzerinde anlaşılan yaklaşımdan farklıysa, katkının daha fazla incelenmesi için uygulamanın ayrıntılı bir açıklaması gereklidir.

İşlevselliği veya davranışı değiştiren herhangi bir pull request, bu değişikliklerin büyük resmini açıklamalıdır, böylece incelemeler neye bakacaklarını bilirler (ve değişikliğin ne yaptığını anlamak için kodu incelemek zorunda kalmazlar).


**Aşağıdaki 2, 3 ve 4. sorular koda bakmadan cevaplanabiliyorsa katkı iyi tanımlanmıştır.**

-----

### 2. Değişikliğin veya Özelliğin Flink'e Girmesi Konusunda Fikir Birliği Var mı?

Bu soru doğrudan bağlantılı Jira sorunuyla cevaplanabilir. Önceden fikir birliği olmadan oluşturulan pull request'ler için, [fikir birliği aramak için Jira'da bir tartışma]({{< relref "how-to-contribute/contribute-code" >}}) gerekecektir.


`[hotfix]` pull request'leri için, pull request'te fikir birliği kontrolü yapılması gerekir.


-----

### 3. Katkı Bazı Belirli Committer'lardan Dikkat Gerektiriyor mu ve Bu Committer'lardan Zaman Taahhüdü Var mı?

Bazı değişiklikler belirli committer'ların dikkatini ve onayını gerektirir. Örneğin, performansa çok duyarlı olan veya dağıtılmış koordinasyon ve hata toleransı üzerinde kritik bir etkisi olan parçalardaki değişiklikler, bileşene derinlemesine aşina olan bir committer'dan girdiye ihtiyaç duyar.

Kural olarak, Pull Request açıklaması şablondaki "Bu pull request aşağıdaki parçalardan birini potansiyel olarak etkiliyor mu" bölümündeki sorulardan birine 'evet' ile cevap verdiğinde özel dikkat gereklidir.

Bu soru şu şekilde cevaplanabilir:

* *Özel dikkat gerektirmez*
* *X için özel dikkat gerektirir (X, örneğin kontrol noktası oluşturma, jobmanager vb. olabilir).*
* *@committerA, @contributorB tarafından X için özel dikkat var*

**Pull request özel dikkat gerektiriyorsa, etiketlenen committer'lardan/katkıda bulunanlardan biri nihai onayı vermelidir.**

----

### 4. Uygulama, Üzerinde Anlaşılan Genel Yaklaşımı/Mimariyi Takip Ediyor mu?

Bu adımda, bir katkının Jira'daki veya e-posta listelerindeki önceki tartışmada üzerinde anlaşılan yaklaşımı takip edip etmediğini kontrol ediyoruz.

Bu soru mümkün olduğunca Pull Request açıklamasından (veya bağlantılı Jira'dan) cevaplanabilmelidir.

Değişikliğin bireysel kısımları hakkında yorum yapmak gibi ayrıntılara girmeden önce bunu kontrol etmenizi öneririz.

----

### 5. Genel Kod Kalitesi İyi mi, Flink'te Sürdürmek İstediğimiz Standartları Karşılıyor mu?

Bu, gerçek değişikliklerin ayrıntılı kod incelemesidir ve şunları kapsar:

* Değişiklikler Jira biletinde veya tasarım belgesinde açıklanan şeyi yapıyor mu?
* Kod doğru yazılım mühendisliği uygulamalarını takip ediyor mu? Kod doğru, sağlam, bakımı yapılabilir, test edilebilir mi?
* Performansa duyarlı bir kısmı değiştirirken, değişiklikler performans bilinciyle yapılmış mı?
* Değişiklikler testlerle yeterince kapsanmış mı?
* Testler hızlı çalışıyor mu, yani ağır entegrasyon testleri sadece gerektiğinde mi kullanılıyor?
* Kod formatı Flink'in checkstyle desenini takip ediyor mu?
* Kod, ek derleyici uyarıları getirmekten kaçınıyor mu?
* Bağımlılıklar değiştirildiyse, NOTICE dosyaları güncellendi mi?

Kod yönergeleri [Flink Kod Stili ve Kalite Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-preamble" >}})'nda bulunabilir.

----

### 6. İngilizce ve Çince Belgeler Güncellendi mi?

Pull request yeni bir özellik tanıtıyorsa, özellik belgelenmelidir. Flink topluluğu hem İngilizce hem de Çince belgeleri sürdürmektedir. Bu nedenle her iki belge de güncellenmelidir. Çince diline aşina değilseniz, lütfen Çince belge çevirisi için `chinese-translation` bileşenine atanmış bir Jira açın ve bunu mevcut Jira sorunu ile ilişkilendirin. Çince diline aşinaysanız, her iki tarafı da bir pull request'te güncellemeniz teşvik edilir.

[Belgelere nasıl katkıda bulunulacağı]({{< relref "how-to-contribute/contribute-documentation" >}}) hakkında daha fazla bilgi alın.