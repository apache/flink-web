---
title: Kod Stili ve Kalite Kılavuzu
bookCollapseSection: false
weight: 19
---

# Apache Flink Kod Stili ve Kalite Kılavuzu

#### [Önsöz]({{< relref "how-to-contribute/code-style-and-quality-preamble" >}})
#### [Pull Request'ler ve Değişiklikler]({{< relref "how-to-contribute/code-style-and-quality-pull-requests" >}})
#### [Genel Kodlama Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-common" >}})
#### [Java Dili Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-java" >}})
#### [Scala Dili Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-scala" >}})
#### [Bileşenler Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-components" >}})
#### [Biçimlendirme Kılavuzu]({{< relref "how-to-contribute/code-style-and-quality-formatting" >}})

<hr>

Bu, sürdürmek istediğimiz kod ve kalite standardını yakalama girişimidir.

Bir kod katkısı (veya herhangi bir kod parçası) çeşitli şekillerde değerlendirilebilir: Özellik kümelerinden biri, kodun doğru ve verimli olup olmadığıdır. Bu, _mantıksal veya algoritmik problemi_ doğru ve iyi bir şekilde çözmeyi gerektirir.

Diğer bir özellik kümesi ise, kodun sezgisel bir tasarım ve mimariyi takip edip etmediği, iyi yapılandırılmış ve doğru ilgi ayrımına sahip olup olmadığı ve kodun kolayca anlaşılabilir olup olmadığı ve varsayımlarını açık hale getirip getirmediğidir. Bu özellik kümesi, _yazılım mühendisliği problemini_ iyi çözmeyi gerektirir. İyi bir çözüm, kodun kolayca test edilebilir, orijinal yazarlarından başka kişiler tarafından da bakımının yapılabilir (çünkü yanlışlıkla bozmak daha zordur) ve geliştirmek için verimli olduğu anlamına gelir.

İlk özellik kümesinin oldukça nesnel onay kriterleri varken, ikinci özellik kümesini değerlendirmek çok daha zordur, ancak Apache Flink gibi bir açık kaynak projesi için büyük önem taşır. Kod tabanını birçok katkıda bulunana davet etmek, katkıları orijinal kodu yazmayan geliştiriciler için anlaşılması kolay hale getirmek ve kodu birçok katkı karşısında sağlam tutmak için, iyi tasarlanmış kod çok önemlidir.[^1] İyi tasarlanmış kod için, zaman içinde doğru ve hızlı kalmasını sağlamak daha kolaydır.

Bu elbette iyi tasarlanmış kod nasıl yazılır konusunda tam bir kılavuz değildir. Bunu yakalamaya çalışan büyük kitapların dünyası var. Bu kılavuz, Flink'i geliştirme bağlamında gözlemlediğimiz en iyi uygulamaların, desenlerin, anti-desenlerin ve yaygın hataların bir kontrol listesi olarak düşünülmüştür.

Yüksek kaliteli açık kaynak katkılarının büyük bir kısmı, inceleyicinin katkıyı anlamasına ve etkileri çift kontrol etmesine yardımcı olmakla ilgilidir, bu nedenle bu kılavuzun önemli bir kısmı, bir pull request'i inceleme için nasıl yapılandıracağınızla ilgilidir.

[^1]: Daha önceki günlerde, biz (Flink topluluğu) buna her zaman yeterince dikkat etmedik, bu da Flink'in bazı bileşenlerinin geliştirilmesini ve katkıda bulunulmasını zorlaştırdı.
