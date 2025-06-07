---
title: Mimari
bookCollapseSection: false
weight: 1
---

# Apache Flink Nedir? — Mimari

Apache Flink, *sınırsız ve sınırlı* veri akışları üzerinde durumlu hesaplamalar gerçekleştirmek için geliştirilmiş bir framework ve dağıtık işlem motorudur. Flink, *tüm yaygın cluster ortamlarında* çalışacak şekilde, *bellek içi hızda* ve *her ölçekte* işlem yapmak üzere tasarlanmıştır.

Bu bölümde Flink'in mimarisiyle ilgili önemli kavramları açıklıyoruz.

## Sınırsız ve Sınırlı Veriyi İşleyin

Her türlü veri bir olay akışı (stream of events) olarak üretilir. Kredi kartı işlemleri, sensör ölçümleri, makine günlükleri ya da bir web sitesi veya mobil uygulamadaki kullanıcı etkileşimleri — tüm bu veriler bir akış olarak oluşur.

Veriler *sınırsız* veya *sınırlı* akışlar şeklinde işlenebilir.

1. **Sınırsız akışlar**, bir başlangıca sahiptir ancak belirli bir sona sahip değildir. Sürekli olarak veri üretir ve sona ermezler. Bu tür akışlar sürekli olarak işlenmelidir; yani olaylar alındıktan hemen sonra ele alınmalıdır. Tüm verinin gelmesini beklemek mümkün değildir çünkü veri girişi sonsuzdur ve hiçbir zaman tam olmayacaktır. Bu yüzden sınırsız veri işlerken olayların oluş sırasına göre alınması gerekebilir, böylece sonuçların doğruluğu sağlanabilir.

2. **Sınırlı akışlar**, belirli bir başlangıç ve bitişe sahiptir. Bu tür veriler, tüm veri alındıktan sonra işlenebilir. Sıralı alım gerekli değildir çünkü sınırlı veri her zaman sıralanabilir. Bu tür işlem, toplu işleme (batch processing) olarak da bilinir.

{{< img src="/img/bounded-unbounded.png" width="600px" >}}

**Apache Flink, sınırsız ve sınırlı veri kümelerini işlemekte son derece başarılıdır.** Zaman ve durum üzerinde hassas kontrol sayesinde Flink’in çalışma zamanı, sınırsız akışlar üzerinde her türlü uygulamayı çalıştırabilir. Sınırlı veri kümeleri ise sabit boyutlu veri setleri için optimize edilmiş algoritmalar ve veri yapılarıyla işlenir ve bu da yüksek performans sağlar.

[Flink üzerine inşa edilmiş kullanım senaryolarını]({{< relref "use-cases" >}}) keşfederek kendiniz görün.

## Uygulamaları Her Yerde Dağıtın

Apache Flink, dağıtık bir sistemdir ve uygulamaları çalıştırmak için hesaplama kaynaklarına ihtiyaç duyar. Flink, [Hadoop YARN](https://hadoop.apache.org/docs/stable/hadoop-yarn/hadoop-yarn-site/YARN.html) ve [Kubernetes](https://kubernetes.io/) gibi tüm yaygın küme yöneticileriyle entegre olabilir, aynı zamanda bağımsız (stand-alone) bir küme olarak da çalıştırılabilir.

Flink, yukarıda belirtilen kaynak yöneticileriyle verimli çalışacak şekilde tasarlanmıştır. Bu, her yöneticinin doğasına uygun konuşma biçimleriyle çalışan özel dağıtım modları sayesinde mümkün olur.

Bir Flink uygulaması dağıtıldığında, Flink uygulamanın yapılandırılmış paralellik derecesine göre ihtiyaç duyulan kaynakları otomatik olarak belirler ve kaynak yöneticisinden bu kaynakları ister. Bir hata durumunda, Flink başarısız olan konteyneri yeni kaynak talep ederek yeniden başlatır. Uygulama gönderme veya kontrol işlemleri REST çağrıları üzerinden yapılır. Bu, Flink'in birçok ortama entegre edilmesini kolaylaştırır.

<!-- Bu bölüm, kütüphane dağıtım modu desteklendiğinde eklenmelidir. -->

## Uygulamaları Her Ölçekte Çalıştırın

Flink, durumlu (stateful) akış uygulamalarını her ölçekte çalıştırmak üzere tasarlanmıştır. Uygulamalar, binlerce göreve paralel şekilde bölünür ve bir küme içinde dağıtılarak eşzamanlı olarak yürütülür. Böylece uygulama neredeyse sınırsız miktarda CPU, bellek, disk ve ağ girişi/çıkışından faydalanabilir. Ayrıca Flink, çok büyük durum bilgilerini kolaylıkla yönetebilir. Asenkron ve artımlı kontrol noktası alma (checkpointing) algoritması, işlem gecikmelerine minimum etkiyle tam doğrulukta (exactly-once) tutarlılık sağlar.

[Flink kullananların gerçek üretim ortamlarında]( {{< relref "powered-by" >}} ) bildirdiği etkileyici ölçeklenebilirlik örnekleri:

- **Günde trilyonlarca olayı** işleyen uygulamalar
- **Terabaytlarca durum** bilgisi tutan uygulamalar
- **Binlerce çekirdekte** çalışan uygulamalar

## Bellek İçi Performanstan Yararlanın

Durumlu Flink uygulamaları, yerel durum erişimi için optimize edilmiştir. Görev durumları her zaman bellekte tutulur veya belleği aşan durumlar için erişim verimliliği yüksek disk tabanlı veri yapıları kullanılır. Bu sayede görevler hesaplamaları, çoğunlukla bellek içi olan yerel durum üzerinden gerçekleştirerek çok düşük gecikmeli işlem yapar. Flink, periyodik ve asenkron şekilde yerel durumu dayanıklı bir depolamaya yedekleyerek, hata durumlarında bile tam tutarlılığı garanti eder.

<div>
  {{< img src="/img/local-state.png" width="600px" >}}
</div>
