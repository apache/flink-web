---
title: Operasyonlar
bookCollapseSection: false
weight: 3
---

# Apache Flink Nedir? — Operasyonlar

Apache Flink, sınırsız ve sınırlı veri akışları üzerinde durumlu hesaplamalar için bir çerçevedir. Birçok akış uygulaması minimum kesinti ile sürekli çalışacak şekilde tasarlandığından, bir akış işlemcisi mükemmel bir arıza kurtarma sağlamalı ve ayrıca uygulamaları çalışırken izlemek ve bakımını yapmak için araçlar sunmalıdır.

Apache Flink, akış işlemenin operasyonel yönlerine güçlü bir şekilde odaklanır. Burada, Flink'in arıza kurtarma mekanizmasını açıklıyor ve çalışan uygulamaları yönetmek ve denetlemek için özelliklerini sunuyoruz.

## Uygulamalarınızı 7/24 Kesintisiz Çalıştırın

Makine ve süreç arızaları, dağıtık sistemlerde her yerde mevcuttur. Flink gibi dağıtık bir akış işlemcisi, akış uygulamalarını 7/24 çalıştırabilmek için arızalardan kurtulabilmelidir. Açıkçası, bu sadece bir arızadan sonra uygulamayı yeniden başlatmak değil, aynı zamanda iç durumunun tutarlı kalmasını sağlamak anlamına gelir, böylece uygulama arıza hiç olmamış gibi işlemeye devam edebilir.

Flink, uygulamaların çalışmaya devam etmesini ve tutarlı kalmasını sağlamak için çeşitli özellikler sunar:

* **Tutarlı Kontrol Noktaları**: Flink'in kurtarma mekanizması, bir uygulamanın durumunun tutarlı kontrol noktalarına dayanır. Bir arıza durumunda, uygulama yeniden başlatılır ve durumu en son kontrol noktasından yüklenir. Sıfırlanabilir akış kaynaklarıyla birlikte, bu özellik *tam olarak bir kez durum tutarlılığını* garanti edebilir.
* **Verimli Kontrol Noktaları**: Bir uygulamanın durumunu kontrol noktası almak, uygulama terabaytlarca durum tutuyorsa oldukça pahalı olabilir. Flink, kontrol noktalarının uygulamanın gecikme SLA'ları üzerindeki etkisini çok küçük tutmak için asenkron ve artımlı kontrol noktaları gerçekleştirebilir.
* **Uçtan Uca Tam Olarak Bir Kez**: Flink, belirli depolama sistemleri için, arıza durumlarında bile verilerin yalnızca tam olarak bir kez yazılmasını garanti eden işlemsel havuzlar sunar.
* **Küme Yöneticileri ile Entegrasyon**: Flink, [Hadoop YARN](https://hadoop.apache.org) veya [Kubernetes](https://kubernetes.io) gibi küme yöneticileriyle sıkı bir şekilde entegre edilmiştir. Bir süreç başarısız olduğunda, işini devralmak için otomatik olarak yeni bir süreç başlatılır.
* **Yüksek Kullanılabilirlik Kurulumu**: Flink, tüm tek arıza noktalarını ortadan kaldıran bir yüksek kullanılabilirlik modu sunar. YK modu, güvenilir dağıtık koordinasyon için savaşta kanıtlanmış bir hizmet olan [Apache ZooKeeper](https://zookeeper.apache.org)'a dayanmaktadır.

## Uygulamalarınızı Güncelleyin, Taşıyın, Askıya Alın ve Devam Ettirin

İş açısından kritik hizmetlere güç veren akış uygulamalarının bakımının yapılması gerekir. Hataların düzeltilmesi ve iyileştirmelerin veya yeni özelliklerin uygulanması gerekir. Ancak, durumlu bir akış uygulamasını güncellemek basit değildir. Çoğu zaman, uygulamanın durumunu kaybetmeyi göze alamadığınız için uygulamaları durdurup düzeltilmiş veya geliştirilmiş bir sürümü yeniden başlatamazsınız.

Flink'in *Kaydetme Noktaları*, durumlu uygulamaları güncelleme sorununu ve bununla ilgili diğer birçok zorluğu çözen benzersiz ve güçlü bir özelliktir. Bir kaydetme noktası, bir uygulamanın durumunun tutarlı bir anlık görüntüsüdür ve bu nedenle bir kontrol noktasına çok benzer. Ancak kontrol noktalarının aksine, kaydetme noktaları manuel olarak tetiklenmeli ve bir uygulama durdurulduğunda otomatik olarak kaldırılmaz. Bir kaydetme noktası, durum uyumlu bir uygulamayı başlatmak ve durumunu başlatmak için kullanılabilir. Kaydetme noktaları aşağıdaki özellikleri sağlar:

* **Uygulama Evrimi**: Kaydetme noktaları, uygulamaları geliştirmek için kullanılabilir. Düzeltilmiş veya geliştirilmiş bir uygulama sürümü, uygulamanın önceki bir sürümünden alınan bir kaydetme noktasından yeniden başlatılabilir. Ayrıca, hatalı sürüm tarafından üretilen yanlış sonuçları onarmak için uygulamayı daha önceki bir zamandan (böyle bir kaydetme noktası varsa) başlatmak da mümkündür.
* **Küme Taşıma**: Kaydetme noktaları kullanılarak, uygulamalar farklı kümelere taşınabilir (veya klonlanabilir).
* **Flink Sürüm Güncellemeleri**: Bir uygulama, bir kaydetme noktası kullanılarak yeni bir Flink sürümünde çalışacak şekilde taşınabilir.
* **Uygulama Ölçeklendirme**: Kaydetme noktaları, bir uygulamanın paralelliğini artırmak veya azaltmak için kullanılabilir.
* **A/B Testleri ve Eğer-Ne-Olursa Senaryoları**: Bir uygulamanın iki (veya daha fazla) farklı sürümünün performansı veya kalitesi, tüm sürümleri aynı kaydetme noktasından başlatarak karşılaştırılabilir.
* **Duraklatma ve Devam Ettirme**: Bir uygulama, bir kaydetme noktası alınarak ve durdurularak duraklatılabilir. Daha sonraki herhangi bir zamanda, uygulama kaydetme noktasından devam ettirilebilir.
* **Arşivleme**: Bir uygulamanın durumunu daha önceki bir zamana sıfırlayabilmek için kaydetme noktaları arşivlenebilir.

## Uygulamalarınızı İzleyin ve Kontrol Edin

Diğer hizmetler gibi, sürekli çalışan akış uygulamalarının da denetlenmesi ve bir kuruluşun operasyon altyapısına, yani izleme ve günlükleme hizmetlerine entegre edilmesi gerekir. İzleme, sorunları öngörmeye ve zamanında tepki vermeye yardımcı olur. Günlükleme, arızaları araştırmak için kök neden analizi yapılmasını sağlar. Son olarak, çalışan uygulamaları kontrol etmek için kolay erişilebilir arayüzler önemli bir özelliktir.

Flink, birçok yaygın günlükleme ve izleme hizmetiyle güzel bir şekilde entegre olur ve uygulamaları kontrol etmek ve bilgi sorgulamak için bir REST API sağlar.

* **Web Arayüzü**: Flink, çalışan uygulamaları incelemek, izlemek ve hata ayıklamak için bir web arayüzü sunar. Ayrıca yürütülmek üzere yürütme göndermek veya bunları iptal etmek için de kullanılabilir.
* **Günlükleme**: Flink, popüler slf4j günlükleme arayüzünü uygular ve [log4j](https://logging.apache.org/log4j/2.x/) veya [logback](https://logback.qos.ch/) günlükleme çerçeveleriyle entegre olur.
* **Metrikler**: Flink, sistem ve kullanıcı tanımlı metrikleri toplamak ve raporlamak için gelişmiş bir metrik sistemi sunar. Metrikler, [JMX](https://en.wikipedia.org/wiki/Java_Management_Extensions), Ganglia, [Graphite](https://graphiteapp.org/), [Prometheus](https://prometheus.io/), [StatsD](https://github.com/etsy/statsd), [Datadog](https://www.datadoghq.com/) ve [Slf4j](https://www.slf4j.org/) dahil olmak üzere çeşitli raportörlere aktarılabilir.
* **REST API**: Flink, yeni bir uygulama göndermek, çalışan bir uygulamanın kaydetme noktasını almak veya bir uygulamayı iptal etmek için bir REST API sunar. REST API ayrıca çalışan veya tamamlanan uygulamaların meta verilerini ve toplanan metriklerini de sunar.
