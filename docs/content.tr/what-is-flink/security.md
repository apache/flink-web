---
title: Güvenlik
bookCollapseSection: false
weight: 8
aliases:
- /security.html
- /security/index.html
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

# Güvenlik

## Güvenlik Güncellemeleri

Bu bölüm, Flink'teki düzeltilmiş güvenlik açıklarını listeler.

<table class="table">
	<thead>
		<tr>
			<th style="width: 20%">CVE ID</th>
			<th style="width: 30%">Etkilenen Flink sürümleri</th>
			<th style="width: 50%">Notlar</th>
		</tr>
	</thead>
	<tr>
		<td>
			<a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1960">CVE-2020-1960</a>
		</td>
		<td>
			1.1.0 - 1.1.5, 1.2.0 - 1.2.1, 1.3.0 - 1.3.3, 1.4.0 - 1.4.2, 1.5.0 - 1.5.6, 1.6.0 - 1.6.4, 1.7.0 - 1.7.2, 1.8.0 - 1.8.3, 1.9.0 - 1.9.2, 1.10.0
		</td>
		<td>
			Kullanıcıların Flink 1.9.3 veya 1.10.1 ya da daha sonraki sürümlere yükseltmeleri veya port parametresini reporter yapılandırmasından kaldırmaları önerilir (ayrıntılar için duyuruya bakın).
		</td>
	</tr>
	<tr>
		<td>
			<a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-17518">CVE-2020-17518</a>
		</td>
		<td>
			1.5.1 - 1.11.2
		</td>
		<td>
			<a href="https://github.com/apache/flink/commit/a5264a6f41524afe8ceadf1d8ddc8c80f323ebc4">a5264a6f41524afe8ceadf1d8ddc8c80f323ebc4 commit'inde düzeltildi</a> <br>
			Kullanıcıların Flink 1.11.3 veya 1.12.0 ya da daha sonraki sürümlere yükseltmeleri önerilir.
		</td>
	</tr>
	<tr>
		<td>
			<a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-17519">CVE-2020-17519</a>
		</td>
		<td>
			1.11.0, 1.11.1, 1.11.2
		</td>
		<td>
			<a href="https://github.com/apache/flink/commit/b561010b0ee741543c3953306037f00d7a9f0801">b561010b0ee741543c3953306037f00d7a9f0801 commit'inde düzeltildi</a> <br>
			Kullanıcıların Flink 1.11.3 veya 1.12.0 ya da daha sonraki sürümlere yükseltmeleri önerilir.
		</td>
	</tr>
	<tr>
		<td>
			<a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-41834">CVE-2023-41834</a>
		</td>
		<td>
			Flink Stateful Functions 3.1.0, 3.1.1, 3.2.0
		</td>
		<td>
			<a href="https://github.com/apache/flink-statefun/commit/b06c0a23a5a622d48efc8395699b2e4502bd92be">b06c0a23a5a622d48efc8395699b2e4502bd92be commit'inde düzeltildi</a> <br>
			Kullanıcıların Flink Stateful Functions 3.3.0 veya daha sonraki sürümlere yükseltmeleri önerilir.
		</td>
	</tr>
</table>


## Sık Sorulan Sorular

### Flink'in güvenlik analizi sırasında, Flink'in uzaktan kod yürütmeye izin verdiğini fark ettim, bu bir sorun mu?

Apache Flink, kullanıcı tarafından sağlanan kodu kümelerde çalıştırmak için bir çerçevedir. Kullanıcılar, hangi kodun çalışabileceğini sınırlamaya yönelik herhangi bir girişim olmaksızın, koşulsuz olarak yürütülecek kodu Flink süreçlerine gönderebilirler. Diğer süreçleri başlatmak, ağ bağlantıları kurmak veya yerel dosyalara erişmek ve bunları değiştirmek mümkündür.

Tarihsel olarak, tasarım gereği reddetmek zorunda kaldığımız çok sayıda uzaktan kod yürütme güvenlik açığı bildirimi aldık.

**Kullanıcılara Flink süreçlerini genel internete açmamalarını şiddetle tavsiye ediyoruz**. Şirket ağları veya "bulut" hesapları içinde, uygun yollarla Flink kümesine erişimi kısıtlamanızı öneririz.


### Flink'te bir güvenlik açığı buldum, nasıl bildiririm?

Apache Flink'in güvenliğini incelediğiniz için çok teşekkürler! Flink'in güvenliğini artıran raporları takdir ediyoruz. Güvenlik açığı raporlarını [Apache Güvenlik Ekibi](https://www.apache.org/security/) aracılığıyla, özel e-posta adresleri [security@apache.org](mailto:security@apache.org) üzerinden kabul ediyoruz.

Potansiyel bir güvenlik sorununu Flink PMC ile özel olarak tartışmak isterseniz, bize [private@flink.apache.org](mailto:private@flink.apache.org) adresinden de ulaşabilirsiniz.
