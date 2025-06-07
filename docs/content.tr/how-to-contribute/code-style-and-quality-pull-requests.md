---
title: Kod Stili ve Kalite Kılavuzu — Pull Request'ler ve Değişiklikler
bookCollapseSection: false
bookHidden: true
---

# Kod Stili ve Kalite Kılavuzu — Pull Request'ler ve Değişiklikler

#### [Önsöz]({{< relref "how-to-contribute/code-style-and-quality-preamble" >}})
#### [Pull Request'ler ve Değişiklikler]({{< relref "how-to-contribute/code-style-and-quality-pull-requests" >}})
#### [Genel Kodlama Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-common" >}})
#### [Java Dili Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-java" >}})
#### [Scala Dili Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-scala" >}})
#### [Bileşenler Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-components" >}})
#### [Biçimlendirme Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-formatting" >}})

<hr>

**Gerekçe:** Katkıda bulunanlara, pull request'leri daha kolay ve daha kapsamlı bir şekilde incelenebilecekleri bir duruma getirmek için biraz ekstra çaba harcamalarını istiyoruz. Bu, topluluğa birçok açıdan yardımcı olur:

* İncelemeler çok daha hızlıdır ve böylece katkılar daha erken birleştirilir.
* Katkılardaki daha az sorunu gözden kaçırarak daha yüksek kod kalitesini sağlayabiliriz.
* Committer'lar aynı sürede daha fazla katkıyı inceleyebilir, bu da Flink'in yaşadığı yüksek katkı oranıyla başa çıkmaya yardımcı olur.

Lütfen bu kılavuzu takip etmeyen katkıların incelenmesinin daha uzun süreceğini ve bu nedenle genellikle topluluk tarafından daha düşük öncelikle ele alınacağını anlayın. Bu kötü niyet değil, yapılandırılmamış Pull Request'leri incelemenin eklediği karmaşıklıktan kaynaklanmaktadır.


## 1. JIRA Sorunu ve İsimlendirme

Pull request'in bir [JIRA sorununa](https://issues.apache.org/jira/projects/FLINK/issues) karşılık geldiğinden emin olun.

İstisnalar, JavaDoc'lardaki veya dokümantasyon dosyalarındaki yazım hatalarının düzeltilmesi gibi ****acil düzeltmelerdir****.


Pull request'i `[FLINK-XXXX][bileşen] Pull request'in başlığı` şeklinde adlandırın, burada `FLINK-XXXX` gerçek sorun numarasıyla değiştirilmelidir. Bileşenler, JIRA sorununda kullanılanlarla aynı olmalıdır.

Acil düzeltmeler, örneğin `[hotfix][docs] Olay zamanı tanıtımındaki yazım hatasını düzelt` veya `[hotfix][javadocs] PuncuatedWatermarkGenerator için JavaDoc'u genişlet` şeklinde adlandırılmalıdır.


## 2. Açıklama

Katkıyı tanımlamak için lütfen pull request şablonunu doldurun. Lütfen inceleyen kişinin sorunu ve çözümü yalnızca koddan değil, açıklamadan da anlamasını sağlayacak şekilde açıklayın.

İyi açıklanmış bir pull request'in mükemmel bir örneği [https://github.com/apache/flink/pull/7264](https://github.com/apache/flink/pull/7264) 'tür.

Açıklamanın PR tarafından çözülen problem için yeterli olduğundan emin olun. Küçük değişiklikler bir duvar metni gerektirmez. İdeal durumlarda, sorun Jira sorunununda açıklanmıştır ve açıklama büyük ölçüde oradan kopyalanabilir.

Uygulama sırasında ek açık sorular/sorunlar keşfedildiyse ve bunlarla ilgili bir seçim yaptıysanız, bunları pull request metninde açıklayın, böylece inceleyenler varsayımları iki kez kontrol edebilsin. Bir örnek [https://github.com/apache/flink/pull/8290](https://github.com/apache/flink/pull/8290) (Bölüm "Açık Mimari Soruları") içinde bulunabilir.


## 3. Refactoring, Temizleme ve Bağımsız Değişiklikleri Ayırma

****NOT: Bu bir optimizasyon değil, kritik bir gerekliliktir.****

Pull Request'ler temizlik, refactoring ve temel değişiklikleri ayrı commit'lere koymalıdır. Bu şekilde, inceleyici bağımsız olarak temizlik ve refactoring'e bakabilir ve bu değişikliklerin davranışı değiştirmediğinden emin olabilir. Ardından, inceleyici temel değişikliklere izole olarak (diğer değişikliklerin gürültüsü olmadan) bakabilir ve bunun temiz ve sağlam bir değişiklik olduğundan emin olabilir.

Kesinlikle ayrı bir commit'e gitmesi gereken değişiklik örnekleri şunları içerir:

* Önceden var olan koddaki temizlik, stil ve uyarıları düzeltme
* Paketleri, sınıfları veya yöntemleri yeniden adlandırma
* Kodu taşıma (diğer paketlere veya sınıflara)
* Yapıyı refactoring veya tasarım desenlerini değiştirme
* İlgili testleri veya yardımcı programları birleştirme
* Mevcut testlerdeki varsayımları değiştirme (değiştirilen varsayımların neden mantıklı olduğunu açıklayan bir commit mesajı ekleyin).

Aynı PR'nin önceki commit'lerinde tanıtılan sorunları düzelten temizleme commit'leri olmamalıdır. Commit'ler kendi içinde temiz olmalıdır.

Ek olarak, herhangi bir daha büyük katkı, değişiklikleri bağımsız olarak incelenebilecek bir dizi bağımsız değişikliğe ayırmalıdır.

Sorunları ayrı commit'lere bölmenin iki harika örneği şunlardır:

* [https://github.com/apache/flink/pull/6692](https://github.com/apache/flink/pull/6692) (temizleme ve refactoring'i ana değişikliklerden ayırır)
* [https://github.com/apache/flink/pull/7264](https://github.com/apache/flink/pull/7264) (ayrıca ana değişiklikleri bağımsız olarak incelenebilir parçalara ayırır)

Bir pull request hala büyük commit'ler içeriyorsa (örneğin, 1000'den fazla değiştirilen satırı olan bir commit), yukarıdaki örnekte olduğu gibi commit'i birden çok alt probleme nasıl böleceğinizi düşünmek faydalı olabilir.


## 4. Commit İsimlendirme Kuralları

Commit mesajları, pull request'in tamamına benzer bir modeli takip etmelidir:
`[FLINK-XXXX][bileşen] Commit açıklaması`.

Bazı durumlarda, sorun burada bir alt görev olabilir ve bileşen Pull Request'in ana bileşeninden farklı olabilir. Örneğin, commit bir çalışma zamanı değişikliği için uçtan uca bir test getirdiğinde, PR `[runtime]` olarak etiketlenecektir, ancak bireysel commit `[e2e]` olarak etiketlenecektir.

Commit mesajları için örnekler:

* `[hotfix] Sürüm son eklerine izin vermek için update_branch_version.sh düzeltildi`
* `[hotfix] [table] Kullanılmayan geometri bağımlılığını kaldır`
* `[FLINK-11704][tests] AbstractCheckpointStateOutputStreamTestBase'i geliştir`
* `[FLINK-10569][runtime] ExecutionVertexCancelTest'te Instance kullanımını kaldır`
* `[FLINK-11702][table-planner-blink] Yeni bir tablo tip sistemi tanıt`


## 5. Sistemin Gözlemlenebilir Davranışındaki Değişiklikler

Katkıda bulunanlar, PR'lerinde Flink'in gözlemlenebilir davranışını herhangi bir şekilde bozan değişikliklerin farkında olmalıdır, çünkü birçok durumda bu tür değişiklikler mevcut kurulumları bozabilir. Kodlama sırasında veya incelemelerde bu sorunla ilgili olarak soru işaretleri uyandırması gereken kırmızı bayraklar, örneğin:

* Bozan değişiklikle testlerin tekrar geçmesini sağlamak için iddialar değiştirilmiştir.
* Mevcut testlerin geçmeye devam etmesi için yapılandırma ayarının aniden (varsayılan olmayan) değerlere ayarlanması gerekir. Bu, özellikle bozucu bir varsayılana sahip yeni ayarlar için olabilir.
* Mevcut komut dosyalarının veya yapılandırmaların ayarlanması gerekir.
