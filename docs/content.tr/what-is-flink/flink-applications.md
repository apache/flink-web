---
title: Uygulamalar
bookCollapseSection: false
weight: 2
---

# Apache Flink Nedir? — Uygulamalar

Apache Flink, sınırsız ve sınırlı veri akışları üzerinde durumlu hesaplamalar için bir çerçevedir. Flink, farklı soyutlama seviyelerinde çoklu API'ler sunar ve yaygın kullanım durumları için özel kütüphaneler sağlar.

Burada, Flink'in kullanımı kolay ve ifade gücü yüksek API'lerini ve kütüphanelerini sunuyoruz.

## Akış Uygulamaları için Yapı Taşları

Bir akış işleme çerçevesi ile oluşturulabilen ve yürütülebilen uygulamaların türleri, çerçevenin *akışları*, *durumu* ve *zamanı* ne kadar iyi kontrol ettiğiyle belirlenir. Aşağıda, akış işleme uygulamaları için bu yapı taşlarını açıklıyor ve Flink'in bunları ele alma yaklaşımlarını açıklıyoruz.

### Akışlar

Açıkçası, akışlar akış işlemenin temel bir yönüdür. Bununla birlikte, akışların bir akışın nasıl işlenebileceğini ve işlenmesi gerektiğini etkileyen farklı özellikleri olabilir. Flink, her türlü akışı işleyebilen çok yönlü bir işleme çerçevesidir.

* **Sınırlı** ve **sınırsız** akışlar: Akışlar sınırsız veya sınırlı, yani sabit boyutlu veri kümeleri olabilir. Flink'in sınırsız akışları işlemek için gelişmiş özellikleri vardır, ancak sınırlı akışları verimli bir şekilde işlemek için özel operatörleri de bulunmaktadır.
* **Gerçek zamanlı** ve **kaydedilmiş** akışlar: Tüm veriler akış olarak üretilir. Verileri işlemenin iki yolu vardır. Üretildikçe gerçek zamanlı olarak işlemek veya akışı bir depolama sistemine, örneğin bir dosya sistemine veya nesne deposuna kalıcı hale getirmek ve daha sonra işlemek. Flink uygulamaları, kaydedilmiş veya gerçek zamanlı akışları işleyebilir.

### Durum

Her önemsiz olmayan akış uygulaması durumsaldır, yani yalnızca tek tek olaylar üzerinde dönüşümler uygulayan uygulamalar durum gerektirmez. Temel iş mantığını çalıştıran herhangi bir uygulama, olayları veya ara sonuçları daha sonraki bir zamanda erişmek üzere hatırlamalıdır, örneğin bir sonraki olay alındığında veya belirli bir süre sonra.

<div>
  {{< img src="/img/function-state.png" width="350px" >}}
</div>

Uygulama durumu, Flink'te birinci sınıf bir vatandaştır. Bunu, Flink'in durum işleme bağlamında sağladığı tüm özelliklere bakarak görebilirsiniz.

* **Çoklu Durum İlkelleri**: Flink, atomik değerler, listeler veya haritalar gibi farklı veri yapıları için durum ilkelleri sağlar. Geliştiriciler, fonksiyonun erişim modeline göre en verimli durum ilkelini seçebilirler.
* **Takılabilir Durum Arka Uçları**: Uygulama durumu, takılabilir bir durum arka ucu tarafından yönetilir ve kontrol noktası alınır. Flink, durumu bellekte veya [RocksDB](https://rocksdb.org/)'de (verimli bir gömülü disk üzerinde veri deposu) saklayan farklı durum arka uçları sunar. Özel durum arka uçları da takılabilir.
* **Tam olarak bir kez durum tutarlılığı**: Flink'in kontrol noktası alma ve kurtarma algoritmaları, bir arıza durumunda uygulama durumunun tutarlılığını garanti eder. Dolayısıyla, arızalar şeffaf bir şekilde ele alınır ve bir uygulamanın doğruluğunu etkilemez.
* **Çok Büyük Durum**: Flink, asenkron ve artımlı kontrol noktası algoritması sayesinde birkaç terabayt boyutundaki uygulama durumunu koruyabilir.
* **Ölçeklenebilir Uygulamalar**: Flink, durumu daha fazla veya daha az işçiye yeniden dağıtarak durumlu uygulamaların ölçeklendirilmesini destekler.

### Zaman

Zaman, akış uygulamalarının bir diğer önemli bileşenidir. Çoğu olay akışının doğal zaman semantiği vardır çünkü her olay belirli bir zaman noktasında üretilir. Ayrıca, pencere toplamları, oturumlaştırma, model algılama ve zamana dayalı birleştirmeler gibi birçok yaygın akış hesaplaması zamana dayanır. Akış işlemenin önemli bir yönü, bir uygulamanın zamanı nasıl ölçtüğüdür, yani olay zamanı ile işleme zamanı arasındaki fark.

Flink, zamanla ilgili zengin bir özellik seti sunar.

* **Olay Zamanı Modu**: Olay zamanı semantiğine sahip akışları işleyen uygulamalar, olayların zaman damgalarına dayalı sonuçlar hesaplar. Böylece, olay zamanı işleme, kaydedilmiş veya gerçek zamanlı olayların işlenip işlenmediğine bakılmaksızın doğru ve tutarlı sonuçlar sağlar.
* **Watermark Desteği**: Flink, olay zamanı uygulamalarında zaman hakkında akıl yürütmek için watermark'ları kullanır. Watermark'lar aynı zamanda sonuçların gecikme süresi ve tamlığı arasında ödünleşim yapmak için esnek bir mekanizmadır.
* **Geç Veri İşleme**: Watermark'larla olay zamanı modunda akışlar işlenirken, ilişkili tüm olaylar gelmeden önce bir hesaplamanın tamamlandığı düşünülebilir. Bu tür olaylara geç olaylar denir. Flink, geç olayları ele almak için yan çıkışlar üzerinden yeniden yönlendirme ve daha önce tamamlanan sonuçları güncelleme gibi çoklu seçenekler sunar.
* **İşleme Zamanı Modu**: Flink, olay zamanı moduna ek olarak, işleme makinesinin duvar saati zamanı tarafından tetiklenen hesaplamaları gerçekleştiren işleme zamanı semantiğini de destekler. İşleme zamanı modu, yaklaşık sonuçları tolere edebilen, sıkı düşük gecikme gereksinimleri olan belirli uygulamalar için uygun olabilir.

## Katmanlı API'ler

Flink üç katmanlı API sunar. Her API, özlülük ve ifade gücü arasında farklı bir ödünleşim sunar ve farklı kullanım durumlarını hedefler.

<div>
  {{< img src="/img/api-stack.png" width="500px" >}}
</div>

Her API'yi kısaca sunuyor, uygulamalarını tartışıyor ve bir kod örneği gösteriyoruz.

### ProcessFunctions

{{< docs_link file="flink-docs-stable/dev/stream/operators/process_function.html" name="ProcessFunctions">}}, Flink'in sunduğu en ifade edici fonksiyon arayüzleridir. Flink, bir veya iki giriş akışından veya bir pencerede gruplandırılmış olaylardan gelen bireysel olayları işlemek için ProcessFunctions sağlar. ProcessFunctions, zaman ve durum üzerinde ince taneli kontrol sağlar. Bir ProcessFunction durumunu keyfi olarak değiştirebilir ve gelecekte bir geri çağırma fonksiyonunu tetikleyecek zamanlayıcılar kaydedebilir. Bu nedenle, ProcessFunctions, birçok [durumlu olay odaklı uygulama]({{< relref "use-cases#eventDrivenApps" >}}) için gerekli olan karmaşık olay başına iş mantığını uygulayabilir.

Aşağıdaki örnek, bir `KeyedStream` üzerinde çalışan ve `START` ve `END` olaylarını eşleştiren bir `KeyedProcessFunction` göstermektedir. Bir `START` olayı alındığında, fonksiyon zaman damgasını durumda hatırlar ve dört saat içinde bir zamanlayıcı kaydeder. Zamanlayıcı ateşlenmeden önce bir `END` olayı alınırsa, fonksiyon `END` ve `START` olayları arasındaki süreyi hesaplar, durumu temizler ve değeri döndürür. Aksi takdirde, zamanlayıcı sadece ateşlenir ve durumu temizler.

```java
/**
* Anahtarlanmış START ve END olaylarını eşleştirir ve her iki 
* öğenin zaman damgaları arasındaki farkı hesaplar. İlk String alanı anahtar özelliğidir,
* ikinci String özelliği START ve END olaylarını işaretler.
*/
public static class StartEndDuration
  extends KeyedProcessFunction<String, Tuple2<String, String>, Tuple2<String, Long>> {

  private ValueState<Long> startTime;
  
  @Override
  public void open(Configuration conf) {
    // durum işaretçisini elde et
    startTime = getRuntimeContext()
      .getState(new ValueStateDescriptor<Long>("startTime", Long.class));
  }

  /** Her işlenen olay için çağrılır. */
  @Override
  public void processElement(
      Tuple2<String, String> in,
      Context ctx,
      Collector<Tuple2<String, Long>> out) throws Exception {
  
      switch (in.f1) {
        case "START":
          // bir başlangıç olayı alırsak başlangıç zamanını ayarla
          startTime.update(ctx.timestamp());
          // başlangıç olayından dört saat sonrası için bir zamanlayıcı kaydet
          ctx.timerService()
            .registerEventTimeTimer(ctx.timestamp() + 4 * 60 * 60 * 1000);
          break;
        case "END":
          // başlangıç ve bitiş olayı arasındaki süreyi yayınla
          Long sTime = startTime.value();
          if (sTime != null) {
            out.collect(Tuple2.of(in.f0, ctx.timestamp() - sTime));
            // durumu temizle
            startTime.clear();
          }
        default:
          // hiçbir şey yapma
      }
  }

  /** Bir zamanlayıcı ateşlendiğinde çağrılır. */
  @Override
  public void onTimer(
    long timestamp,
    OnTimerContext ctx,
    Collector<Tuple2<String, Long>> out) {

    // Zaman aşımı aralığı aşıldı. Durumu temizliyoruz.
    startTime.clear();
  }
}
```

Örnek, `KeyedProcessFunction`'ın ifade gücünü göstermekle birlikte, oldukça detaylı bir arayüz olduğunu da vurgulamaktadır.

### DataStream API

{{< docs_link file="flink-docs-stable/dev/datastream_api.html" name="DataStream API">}}, pencereleme, kayıt-zamanı dönüşümleri ve harici bir veri deposunu sorgulayarak olayları zenginleştirme gibi birçok yaygın akış işleme işlemi için ilkel işlevler sağlar. DataStream API, Java için kullanılabilir ve `map()`, `reduce()` ve `aggregate()` gibi fonksiyonlara dayanır. Fonksiyonlar, arayüzleri genişleterek veya Java lambda fonksiyonları olarak tanımlanabilir.

Aşağıdaki örnek, bir tıklama akışını nasıl oturumlandıracağını ve oturum başına tıklama sayısını nasıl sayacağını göstermektedir.

```java
// bir web sitesi tıklamaları akışı
DataStream<Click> clicks = ...

DataStream<Tuple2<String, Long>> result = clicks
  // tıklamaları userId'ye projeksiyon yap ve sayım için 1 ekle
  .map(
    // MapFunction arayüzünü uygulayarak fonksiyonu tanımla
    new MapFunction<Click, Tuple2<String, Long>>() {
      @Override
      public Tuple2<String, Long> map(Click click) {
        return Tuple2.of(click.userId, 1L);
      }
    })
  // userId'ye göre anahtar oluştur (alan 0)
  .keyBy(0)
  // 30 dakikalık boşlukla oturum penceresi tanımla
  .window(EventTimeSessionWindows.withGap(Time.minutes(30L)))
  // oturum başına tıklamaları say. Fonksiyonu lambda fonksiyonu olarak tanımla.
  .reduce((a, b) -> Tuple2.of(a.f0, a.f1 + b.f1));
```

### SQL ve Table API

Flink, iki ilişkisel API'ye sahiptir: {{< docs_link file="flink-docs-stable/dev/table/index.html" name="Table API ve SQL">}}. Her iki API de toplu ve akış işleme için birleşik API'lerdir, yani sorgular sınırsız, gerçek zamanlı akışlar veya sınırlı, kaydedilmiş akışlar üzerinde aynı semantik ile yürütülür ve aynı sonuçları üretir. Table API ve SQL, ayrıştırma, doğrulama ve sorgu optimizasyonu için [Apache Calcite](https://calcite.apache.org) kullanır. Bunlar, DataStream API ile sorunsuz bir şekilde entegre edilebilir ve kullanıcı tanımlı skaler, toplama ve tablo değerli fonksiyonları destekler.

Flink'in ilişkisel API'leri, [veri analitiği]({{< relref "use-cases#analytics" >}}), [veri hattı oluşturma ve ETL uygulamaları]({{< relref "use-cases#pipelines" >}}) tanımını kolaylaştırmak için tasarlanmıştır.

Aşağıdaki örnek, bir tıklama akışını oturumlandırmak ve oturum başına tıklama sayısını saymak için SQL sorgusunu göstermektedir. Bu, DataStream API örneğindeki ile aynı kullanım durumudur.

~~~sql
SELECT userId, COUNT(*)
FROM clicks
GROUP BY SESSION(clicktime, INTERVAL '30' MINUTE), userId
~~~

## Kütüphaneler

Flink, yaygın veri işleme kullanım durumları için çeşitli kütüphaneler sunar. Kütüphaneler genellikle bir API'ye gömülüdür ve tamamen bağımsız değildir. Bu nedenle, API'nin tüm özelliklerinden yararlanabilir ve diğer kütüphanelerle entegre edilebilir.

* **{{< docs_link file="flink-docs-stable/docs/libs/cep/" name="Karmaşık Olay İşleme (CEP)">}}**: Model algılama, olay akışı işleme için çok yaygın bir kullanım durumudur. Flink'in CEP kütüphanesi, olayların modellerini belirtmek için bir API sağlar (düzenli ifadeleri veya durum makinelerini düşünün). CEP kütüphanesi, Flink'in DataStream API'si ile entegredir, böylece modeller DataStream'ler üzerinde değerlendirilir. CEP kütüphanesi için uygulamalar, ağ saldırı tespiti, iş süreci izleme ve dolandırıcılık tespitini içerir.
