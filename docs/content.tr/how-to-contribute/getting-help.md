---
title: Yardım Alma
bookCollapseSection: false
weight: 25
aliases:
- /getting-help.html
- /getting-help/index.html

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

# Yardım Alma

## Bir Sorunuz mu Var?

Apache Flink topluluğu her gün birçok kullanıcı sorusunu yanıtlar. Arşivlerde yanıt ve tavsiye arayabilir veya yardım ve rehberlik için toplulukla iletişime geçebilirsiniz.

### Kullanıcı E-posta Listesi

Birçok Flink kullanıcısı, katkıda bulunan ve committer, Flink'in kullanıcı e-posta listesine abonedir. Kullanıcı e-posta listesi, yardım istemek için çok iyi bir yerdir.

E-posta listesine göndermeden önce, aşağıdaki web sitelerinde sizin sorunlarınızla ilgili konuları tartışan e-posta dizilerini aramak için e-posta listesi arşivlerini arayabilirsiniz.

- [Apache E-posta Listesi Arşivi](https://lists.apache.org/list.html?user@flink.apache.org)

E-posta listesine göndermek istiyorsanız, şunları yapmanız gerekir:

1. `user-subscribe@flink.apache.org` adresine bir e-posta göndererek e-posta listesine abone olun,
2. Onay e-postasını yanıtlayarak aboneliği onaylayın ve
3. E-postanızı `user@flink.apache.org` adresine gönderin.

Abone değilseniz e-postanıza yanıt alamayacağınızı lütfen unutmayın.

### Slack

[Slack'teki Apache Flink topluluğuna katılabilirsiniz.]({{< param FlinkSlackInviteUrl >}})
Slack'te bir hesap oluşturduktan sonra, #introductions kanalında kendinizi tanıtmayı unutmayın.
Slack'in sınırlamaları nedeniyle davet bağlantısı 100 davetten sonra süresi dolar. Süresi dolmuşsa, lütfen [Dev e-posta listesi]({{< relref "community" >}}#mailing-lists) ile iletişime geçin.
Herhangi bir mevcut Slack üyesi de başka herhangi birini katılmaya davet edebilir.

Birkaç topluluk kuralı vardır:

* **Saygılı olun** - Bu en önemli kuraldır!
* Tüm önemli kararlar ve sonuçlar **e-posta listelerine yansıtılmalıdır.**
  "Eğer bir e-posta listesinde olmadıysa, olmamıştır." - [Apache Motto'ları](http://theapacheway.com/on-list/)
* Paralel konuşmaların bir kanalı bunaltmasını önlemek için **Slack dizilerini** kullanın.
* Ya [#pyflink](https://apache-flink.slack.com/archives/C03G7LJTS2G) (tüm Python Flink soruları için) ya da [#troubleshooting](https://apache-flink.slack.com/archives/C03G7LJTS2G) (diğer tüm Flink soruları için) kullanın.
* Sorun giderme, Jira atama ve PR incelemesi için lütfen insanlara **doğrudan mesaj göndermeyin**. Bunu yapmak Slack'ten çıkarılmanıza neden olabilir.

### Stack Overflow

Flink topluluğunun birçok üyesi [Stack Overflow](https://stackoverflow.com)'da aktiftir. [\[apache-flink\]](https://stackoverflow.com/questions/tagged/apache-flink) etiketini kullanarak sorular ve cevaplar arayabilir veya sorularınızı gönderebilirsiniz.

## Bir Hata mı Buldunuz?

Bir hata nedeniyle oluşabilecek beklenmeyen bir davranış gözlemlerseniz, bildirilmiş hataları arayabilir veya [Flink'in JIRA'sında]({{< relref "community#issue-tracker" >}}) bir hata raporu oluşturabilirsiniz.

Beklenmeyen davranışın bir hata nedeniyle mi oluştuğundan emin değilseniz, lütfen [kullanıcı e-posta listesine]({{< relref "community" >}}#user-mailing-list) bir soru gönderin.

## Bir Hata Mesajı mı Aldınız?

Bir hata mesajının nedenini belirlemek zor olabilir. Aşağıda, en yaygın hata mesajlarını listeliyor ve bunları nasıl ele alacağınızı açıklıyoruz.

### NotSerializableException hatası alıyorum.

Flink, uygulama mantığının kopyalarını (uyguladığınız fonksiyonlar ve işlemler, program yapılandırması vb.) paralel çalışan işlemlere dağıtmak için Java serileştirmesini kullanır. Bu nedenle, API'ye aktardığınız tüm fonksiyonlar, [java.io.Serializable](http://docs.oracle.com/javase/8/docs/api/java/io/Serializable.html) tarafından tanımlandığı gibi serileştirilebilir olmalıdır.

Fonksiyonunuz anonim bir iç sınıfsa, şunları düşünün:

- Fonksiyonu bağımsız bir sınıf veya statik bir iç sınıf haline getirin.
- Java 8 lambda fonksiyonu kullanın.

Fonksiyonunuz zaten statik bir sınıfsa, sınıfın bir örneğini oluşturduğunuzda atadığınız alanları kontrol edin. Alanlardan biri büyük olasılıkla serileştirilemeyen bir türü tutuyor.

- Java'da, bir `RichFunction` kullanın ve sorunlu alanları `open()` metodunda başlatın.
- Scala'da, genellikle başlatmayı dağıtılmış yürütme gerçekleşene kadar ertelemek için "lazy val" kullanabilirsiniz. Bu, küçük bir performans maliyetine neden olabilir. Doğal olarak Scala'da da bir `RichFunction` kullanabilirsiniz.

### Scala API'sini kullanırken, implicit değerler ve evidence parametreleri hakkında bir hata alıyorum.

Bu hata, tür bilgisi için implicit değerin sağlanamadığı anlamına gelir. Kodunuzda bir `import org.apache.flink.streaming.api.scala._` (DataStream API) veya bir `import org.apache.flink.api.scala._` (DataSet API) ifadesinin olduğundan emin olun.

Genel parametreler alan fonksiyonlar veya sınıflar içinde Flink işlemleri kullanıyorsanız, o parametre için bir TypeInformation mevcut olmalıdır. Bu, bir bağlam sınırı kullanılarak elde edilebilir:

~~~scala
def myFunction[T: TypeInformation](input: DataSet[T]): DataSet[Seq[T]] = {
  input.reduceGroup( i => i.toSeq )
}
~~~

Flink'in türleri nasıl ele aldığına dair derinlemesine bir tartışma için [Tür Çıkarma ve Serileştirme]({{< param DocsBaseUrl >}}/dev/types_serialization.html) bölümüne bakın.

### ClassCastException görüyorum: X, X'e dönüştürülemiyor.

`com.foo.X`, `com.foo.X`'e dönüştürülemiyor (veya `com.foo.X`'e atanamıyor) tarzında bir istisna gördüğünüzde, bu `com.foo.X` sınıfının birden fazla versiyonunun farklı sınıf yükleyiciler tarafından yüklendiği ve bu sınıfın türlerinin birbirine atanmaya çalışıldığı anlamına gelir.

Bunun nedeni şunlar olabilir:

- `child-first` sınıf yükleme yoluyla sınıf çoğaltma. Bu, kullanıcıların Flink'in kullandığı aynı bağımlılıkların farklı sürümlerini kullanmasına izin vermek için tasarlanmış bir mekanizmadır. Ancak, bu sınıfların farklı kopyaları Flink'in çekirdeği ve kullanıcı uygulama kodu arasında hareket ederse, böyle bir istisna oluşabilir. Bunun nedenini doğrulamak için, yapılandırmada `classloader.resolve-order: parent-first` ayarını yapmayı deneyin. Eğer bu hata kaybolursa, bir hata olup olmadığını kontrol etmek için lütfen e-posta listesine yazın.

- Guava'nın Interners'ı veya Avro'nun Schema önbelleği gibi yardımcı programlar tarafından farklı yürütme girişimlerinden sınıfların önbelleğe alınması. Interners kullanmamaya çalışın veya yeni bir görev yürütmesi başlatıldığında yeni bir önbelleğin oluşturulduğundan emin olmak için interners/önbelleğin kapsamını azaltın.

### AbstractMethodError veya NoSuchFieldError hatası alıyorum.

Bu tür hatalar genellikle bazı bağımlılık sürümlerinde bir karışıklığı gösterir. Bu, yürütme sırasında yüklenen bir bağımlılığın (bir kütüphanenin) sürümünün, kodun derlendiği sürümden farklı olduğu anlamına gelir.

Flink 1.4.0'dan itibaren, uygulama JAR dosyanızdaki bağımlılıklar, Flink'in çekirdeği tarafından kullanılan bağımlılıklara veya sınıf yolundaki diğer bağımlılıklara (örneğin Hadoop'tan) göre farklı sürümlere sahip olabilir. Bu, varsayılan olan `child-first` sınıf yüklemenin etkinleştirilmesini gerektirir.

Bu sorunları Flink 1.4+ sürümünde görüyorsanız, aşağıdakilerden biri doğru olabilir:

- Uygulama kodunuzda bir bağımlılık sürüm çakışması var. Tüm bağımlılık sürümlerinizin tutarlı olduğundan emin olun.
- Flink'in `child-first` sınıf yükleme yoluyla destekleyemediği bir kütüphane ile çakışıyorsunuz. Şu anda bunlar, Scala standart kütüphane sınıfları, Flink'in kendi sınıfları, loglama API'leri ve herhangi bir Hadoop çekirdek sınıfıdır.


### DataStream uygulamam, olaylar içeri girmesine rağmen çıktı üretmiyor.

DataStream uygulamanız *Event Time* kullanıyorsa, watermark'larınızın güncellendiğinden emin olun. Watermark üretilmezse, event time pencereleri hiçbir zaman tetiklenmeyebilir ve uygulama sonuç üretmeyebilir.

Flink'in web arayüzünde (watermark bölümü) watermark'ların ilerleme kaydedip kaydetmediğini kontrol edebilirsiniz.

### "Insufficient number of network buffers" bildiren bir istisna görüyorum.

Flink'i çok yüksek bir paralellikle çalıştırırsanız, ağ tamponlarının sayısını artırmanız gerekebilir.

Varsayılan olarak Flink, minimum 64MB ve maksimum 1GB ile JVM yığın boyutunun %10'unu ağ tamponları için alır. Tüm bu değerleri `taskmanager.network.memory.fraction`, `taskmanager.network.memory.min` ve `taskmanager.network.memory.max` aracılığıyla ayarlayabilirsiniz.

Ayrıntılar için lütfen [Yapılandırma Referansı](https://nightlies.apache.org/flink/flink-docs-stable/docs/deployment/)'na bakın.

### İşim HDFS/Hadoop kodundan çeşitli istisnalarla başarısız oluyor. Ne yapabilirim?

Bunun en yaygın nedeni, Flink'in sınıf yolundaki Hadoop sürümünün, bağlanmak istediğiniz kümenin Hadoop sürümünden farklı olmasıdır (HDFS / YARN).

Bunu düzeltmenin en kolay yolu, Hadoop içermeyen bir Flink sürümü seçmek ve Hadoop yolunu ve sınıf yolunu kümeden basitçe dışa aktarmaktır.
