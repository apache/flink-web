---
title: Dokümantasyona Katkıda Bulunma
bookCollapseSection: false
weight: 20
---

# Dokümantasyona Katkıda Bulunma

İyi bir dokümantasyon, her türlü yazılım için çok önemlidir. Bu, özellikle Apache Flink gibi dağıtık veri işleme motorları olan karmaşık yazılım sistemleri için geçerlidir. Apache Flink topluluğu, özlü, kesin ve eksiksiz dokümantasyon sağlamayı amaçlar ve Apache Flink'in dokümantasyonunu iyileştirmeye yönelik her türlü katkıyı memnuniyetle karşılar.

## Dokümantasyon kaynaklarını edinme

Apache Flink'in dokümantasyonu, kod tabanı ile aynı [git](http://git-scm.com/) deposunda tutulur. Bu, kod ve dokümantasyonun kolayca senkronize tutulabilmesini sağlamak için yapılır.

Dokümantasyona katkıda bulunmanın en kolay yolu, [GitHub'daki Flink'in yansıtılmış deposunu](https://github.com/apache/flink) sağ üst köşedeki fork düğmesine tıklayarak kendi GitHub hesabınıza fork etmektir. GitHub hesabınız yoksa, ücretsiz olarak bir tane oluşturabilirsiniz.

Ardından, fork'unuzu yerel makinenize klonlayın.

```
git clone https://github.com/<kullanıcı-adınız>/flink.git
```

Dokümantasyon, Flink kod tabanının `docs/` alt dizininde bulunur.

## Dokümantasyon üzerinde çalışmaya başlamadan önce...

...lütfen katkınıza karşılık gelen bir [Jira](https://issues.apache.org/jira/browse/FLINK) sorunu olduğundan emin olun. Yazım hataları gibi önemsiz düzeltmeler dışında, tüm dokümantasyon değişikliklerinin bir Jira sorununa atıfta bulunmasını gerektiriyoruz.

Ayrıca, erişilebilir, tutarlı ve kapsayıcı dokümantasyon yazma konusunda bazı rehberlik için [Dokümantasyon Stil Kılavuzu]({{< relref "how-to-contribute/documentation-style-guide" >}}) sayfasına göz atın.

## Dokümantasyonu güncelleme veya genişletme

Flink dokümantasyonu [Markdown](http://daringfireball.net/projects/markdown/) ile yazılmıştır. Markdown, HTML'ye çevrilebilen hafif bir işaretleme dilidir.

Dokümantasyonu güncellemek veya genişletmek için Markdown (`.md`) dosyalarını değiştirmeniz gerekir. Lütfen değişikliklerinizi, yapım komut dosyasını önizleme modunda başlatarak doğrulayın.

```
./build_docs.sh -p
```

Bu komut dosyası, Markdown dosyalarını statik HTML sayfalarına derler ve yerel bir web sunucusu başlatır. Derlenen dokümantasyonu değişikliklerinizle birlikte görüntülemek için tarayıcınızı `http://localhost:1313/` adresinde açın. Markdown dosyalarını değiştirip kaydettiğinizde ve tarayıcınızı yenilediğinizde, sunulan dokümantasyon otomatik olarak yeniden derlenir ve güncellenir.

Lütfen geliştirici e-posta listesinde her türlü sorunuzu sormaktan çekinmeyin.

## Çince dokümantasyon çevirisi

Flink topluluğu hem İngilizce hem de Çince dokümantasyonu sürdürmektedir. Dokümantasyonu güncellemek veya genişletmek istiyorsanız, hem İngilizce hem de Çince dokümantasyon güncellenmelidir. Çince diline aşina değilseniz, lütfen mevcut JIRA sorunuyla bağlantılı olarak Çince dokümantasyon çevirisi için `chinese-translation` bileşeni ile etiketlenmiş bir JIRA açın. Çince diline aşina iseniz, her iki tarafı da bir pull request'te güncellemeniz teşvik edilir.

*NOT: Flink topluluğu hala Çince dokümantasyonları çevirme sürecindedir, bazı belgeler henüz çevrilmemiş olabilir. Güncellediğiniz belge henüz çevrilmemişse, İngilizce değişiklikleri Çince belgeye kopyalayabilirsiniz.*

Çince belgeler `content.zh/docs` klasöründe bulunmaktadır. İngilizce belge değişikliklerine göre `content.zh/docs` klasöründeki Çince dosyayı güncelleyebilir veya genişletebilirsiniz.

## Katkınızı gönderme

Flink projesi, dokümantasyon katkılarını [GitHub Mirror](https://github.com/apache/flink) üzerinden [Pull Request'ler](https://help.github.com/articles/using-pull-requests) olarak kabul eder. Pull request'ler, değişiklikleri içeren bir kod dalına işaret ederek yama sunmanın basit bir yoludur.

Bir pull request hazırlamak ve göndermek için şu adımları izleyin.

1. Değişikliklerinizi yerel git deponuza commit edin. Commit mesajı, ilgili Jira sorununa `[FLINK-XXXX]` ile başlayarak işaret etmelidir.

2. Commit edilen katkınızı GitHub'daki Flink depo fork'unuza push edin.

   ```
   git push origin myBranch
   ```

3. Depo fork'unuzun web sitesine gidin (`https://github.com/<kullanıcı-adınız>/flink`) ve pull request oluşturmaya başlamak için "Create Pull Request" düğmesini kullanın. Temel fork'un `apache/flink master` olduğundan ve head fork'un değişikliklerinizi içeren dalı seçtiğinden emin olun. Pull request'e anlamlı bir açıklama verin ve gönderin.

Bir yamayı bir [Jira]({{< param FlinkIssuesUrl >}}) sorununa eklemek de mümkündür.
