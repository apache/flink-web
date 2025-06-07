---
title: Web Sitesine Katkıda Bulunma
bookCollapseSection: false
weight: 22
---

# Web Sitesini İyileştirme

[Apache Flink web sitesi](http://flink.apache.org), Apache Flink'i ve topluluğunu tanıtır. Web sitesi aşağıdakiler dahil olmak üzere çeşitli amaçlara hizmet eder:

- Ziyaretçileri Apache Flink ve özellikleri hakkında bilgilendirmek.
- Ziyaretçileri Flink'i indirmeye ve kullanmaya teşvik etmek.
- Ziyaretçileri toplulukla etkileşime geçmeye teşvik etmek.

Web sitemizi iyileştirmek için yapılacak her türlü katkıyı memnuniyetle karşılıyoruz. Bu belge, Flink'in web sitesini iyileştirmek için gerekli tüm bilgileri içerir.

## Web sitesi kaynaklarını edinme

Apache Flink'in web sitesi, GitHub'da [https://github.com/apache/flink-web](https://github.com/apache/flink-web) adresinde yansıtılan özel bir [git](http://git-scm.com/) deposunda barındırılmaktadır.

Web sitesi güncellemelerine katkıda bulunmanın en kolay yolu, [GitHub'daki yansıtılmış web sitesi deposunu](https://github.com/apache/flink-web) sağ üst köşedeki fork düğmesine tıklayarak kendi GitHub hesabınıza fork etmektir. GitHub hesabınız yoksa, ücretsiz olarak bir tane oluşturabilirsiniz.

Ardından, fork'unuzu yerel makinenize klonlayın.

```
git clone https://github.com/<kullanıcı-adınız>/flink-web.git
```

`flink-web` dizini, klonlanmış depoyu içerir. Web sitesi, deponun `asf-site` dalında bulunur. Dizine girmek ve `asf-site` dalına geçmek için aşağıdaki komutları çalıştırın.

```
cd flink-web
git checkout asf-site
```

## Dizin yapısı ve dosyalar

Flink'in web sitesi [Markdown](http://daringfireball.net/projects/markdown/) ile yazılmıştır. Markdown, HTML'ye çevrilebilen hafif bir işaretleme dilidir. Markdown'dan statik HTML dosyaları oluşturmak için [Hugo](https://gohugo.io/) kullanıyoruz.

Web sitesi git deposundaki dosya ve dizinler aşağıdaki rollere sahiptir:

- `.md` ile biten tüm dosyalar Markdown dosyalarıdır. Bu dosyalar statik HTML dosyalarına dönüştürülür.
- `docs` dizini, web sitesini oluşturmak ve/veya oluşturmak için gereken tüm dokümantasyonu, temaları ve diğer içeriği içerir.
- `docs/content/docs` klasörü tüm İngilizce içeriği içerir. `docs/content.zh/docs` tüm Çince içeriği içerir.
- `docs/content/posts` tüm blog yazılarını içerir.
- `content/` dizini Hugo'dan oluşturulan HTML dosyalarını içerir. Flink web sitesini barındıran Apache Altyapısı HTML içeriğini bu dizinden çektiği için dosyaları bu dizine yerleştirmek önemlidir. (Committer'lar için: Web sitesi git'ine değişiklikleri gönderirken, `content/` dizinindeki güncellemeleri de gönderin!)

## Dokümantasyonu güncelleme veya genişletme

Web sitesini Markdown dosyalarını veya CSS dosyaları gibi diğer kaynakları değiştirerek veya ekleyerek güncelleyebilir ve genişletebilirsiniz. Değişikliklerinizi doğrulamak için oluşturma komut dosyasını önizleme modunda başlatın.

```
./build.sh
```

Komut dosyası, Markdown dosyalarını HTML'ye derler ve yerel bir web sunucusu başlatır. Değişikliklerinizi içeren web sitesini görüntülemek için tarayıcınızı `http://localhost:1313` adresinde açın. Çince çeviri `http://localhost:1313/zh/` adresinde bulunur. Sunulan web sitesi, herhangi bir dosyayı değiştirip kaydettiğinizde ve tarayıcınızı yenilediğinizde otomatik olarak yeniden derlenir ve güncellenir.

Dokümantasyonlarınızda veya blog yazılarınızda Flink'in resmi dokümantasyonuna harici bir bağlantı eklemek için, lütfen aşağıdaki sözdizimini kullanın:

```markdown
{{</* docs_link file="relative_path/" name="Title"*/>}}
```

Örneğin:

```markdown
{{</* docs_link file="flink-docs-stable/docs/dev/datastream/side_output/" name="Side Output"*/>}}
```

Lütfen geliştirici e-posta listesinde her türlü sorunuzu sormaktan çekinmeyin.

## Katkınızı gönderme

Flink projesi, web sitesi katkılarını [GitHub Mirror](https://github.com/apache/flink-web) üzerinden [Pull Request'ler](https://help.github.com/articles/using-pull-requests) olarak kabul eder. Pull request'ler, değişiklikleri içeren bir kod dalına işaret ederek yama sunmanın basit bir yoludur.

Bir pull request hazırlamak ve göndermek için şu adımları izleyin.

1. Değişikliklerinizi yerel git deponuza commit edin. Katkınız web sitesinin büyük bir yeniden düzenlemesi olmadığı sürece, lütfen bunu tek bir commit olarak sıkıştırın.

2. Commit'i, Flink deposunun GitHub'daki fork'unuzun özel bir dalına push edin.

   ```
   git push origin myBranch
   ```

3. Depo fork'unuzun web sitesine gidin (`https://github.com/<kullanıcı-adınız>/flink-web`) ve bir pull request oluşturmaya başlamak için "Create Pull Request" düğmesini kullanın. Temel fork'un `apache/flink-web asf-site` olduğundan ve head fork'un değişikliklerinizi içeren dalı seçtiğinden emin olun. Pull request'e anlamlı bir açıklama verin ve gönderin.

## Committer bölümü

**Bu bölüm yalnızca committer'lar için geçerlidir.**

### ASF web sitesi git depoları

**ASF yazılabilir**: https://gitbox.apache.org/repos/asf/flink-web.git

ASF git deposu için kimlik bilgilerinin nasıl ayarlanacağına ilişkin ayrıntılar [burada bağlantılıdır](https://gitbox.apache.org/).

### Bir pull request'i birleştirme

Katkıların yalnızca kaynak dosyalar üzerinde yapılması beklenir (`content/` dizinindeki derlenmiş dosyalarda değişiklik yapılmaz). Bir web sitesi değişikliğini push etmeden önce, lütfen oluşturma komut dosyasını çalıştırın

```
./build.sh
```

değişiklikleri `content/` dizinine ek bir commit olarak ekleyin ve değişiklikleri ASF temel deposuna push edin.
