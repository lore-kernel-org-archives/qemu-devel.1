Received: from eggs.gnu.org ([2001:4830:134:3::10]:51546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1ewReX-0004s5-8f
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 08:06:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1ewReT-0003Cs-6r
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 08:06:37 -0400
Received: from smtp65.cstnet.cn ([159.226.251.65]:48094 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1ewReS-00038v-IB
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 08:06:33 -0400
Date: Thu, 15 Mar 2018 20:06:24 +0800 (GMT+08:00)
From: "Su Hang" <suhang16@mails.ucas.ac.cn>
In-Reply-To: <CAFEAcA8sKBc--=AkwXjnJxEB484Z=Gin-u2ga5nG9UR79HN-6w@mail.gmail.com>
References: <1521114316-19980-1-git-send-email-suhang16@mails.ucas.ac.cn>
	<CAFEAcA8sKBc--=AkwXjnJxEB484Z=Gin-u2ga5nG9UR79HN-6w@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4a161e24.12a99.162298dd716.Coremail.suhang16@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] [PATCH RFC] scripts/checkpatch.pl: Bug fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter maydell <peter.maydell@linaro.org>
Cc: eric blake <eblake@redhat.com>, vladimir sementsov-ogievskiy <vsementsov@virtuozzo.com>, qemu developers <qemu-devel@nongnu.org>

U29ycnkgYWJvdXQgaW5hcHByb3ByaWF0ZSBleGFtcGxlLCB3aGF0IEkgd2FudCB0byBleHByZXNz
IGlzLAp3aGVuIGNoZWNrcGF0Y2gucGwgZmluZCBwYXR0ZXJuIGxpa2UgdGhpczoKIiIiCmZvciAo
aSA9IDA7IGkgPCAwOyArK2kpCnsKICAgIDsKfQoiIiIKSXQgc2hvdWxkIHJhaXNlCiIiIgpFUlJP
UjogdGhhdCBvcGVuIGJyYWNlIHsgc2hvdWxkIGJlIG9uIHRoZSBwcmV2aW91cyBsaW5lCiM0OiBG
SUxFOiB0ZXN0LmM6NDoKKyAgICBmb3IgKGkgPSAwOyBpIDwgMDsgKytpKQorICAgIHsKIiIiCgpJ
bnN0ZWFkIG9mOgoiIiIgCkVSUk9SOiBicmFjZXMge30gYXJlIG5lY2Vzc2FyeSBldmVuIGZvciBz
aW5nbGUgc3RhdGVtZW50IGJsb2NrcwojNDogRklMRTogdGVzdC5jOjQ6CisgICAgZm9yIChpID0g
MDsgaSA8IDA7ICsraSkKKyAgICB7CisgICAgICAgIDsKKyAgICB9CiIiIgoKPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiUGV0ZXIgTWF5ZGVsbCIgPHBldGVyLm1heWRlbGxA
bGluYXJvLm9yZz4KPiBTZW50IFRpbWU6IDIwMTgtMDMtMTUgMTk6NTA6NTUgKFRodXJzZGF5KQo+
IFRvOiAiU3UgSGFuZyIgPHN1aGFuZzE2QG1haWxzLnVjYXMuYWMuY24+Cj4gQ2M6ICJFcmljIEJs
YWtlIiA8ZWJsYWtlQHJlZGhhdC5jb20+LCAiVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSIg
PHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4sICJRRU1VIERldmVsb3BlcnMiIDxxZW11LWRldmVs
QG5vbmdudS5vcmc+Cj4gU3ViamVjdDogUmU6IFtRZW11LWRldmVsXSBbUEFUQ0ggUkZDXSBzY3Jp
cHRzL2NoZWNrcGF0Y2gucGw6IEJ1ZyBmaXgKPiAKPiBPbiAxNSBNYXJjaCAyMDE4IGF0IDExOjQ1
LCBTdSBIYW5nIDxzdWhhbmcxNkBtYWlscy51Y2FzLmFjLmNuPiB3cm90ZToKPiA+IEJ1ZyBmaXg6
IGNoZWNrcGF0Y2gucGwgc3RvcHMgY29tcGxhaW5pbmcgYWJvdXQgZm9sbG93aW5nIHBhdHRlcm46
Cj4gPiAiIiIKPiA+IGRvIHsKPiA+ICAgICAvL2RvIHNvbWV0aGluczsKPiA+IH0gd2hpbGUgKGNv
bmRpdGlvbnMpOwo+ID4gIiIiCj4gPgo+ID4gVHdvIHRoaW5ncyBuZWVkIHRvIGJlIG1lbnRpb25l
ZDoKPiA+IDEpIEJlZm9yZSBJIGNhc3VlIHRoaXMgYnVnLCBjaGVja3BhdGNoLnBsIHdpbGwgcmFp
c2UgYSB3cm9uZwo+ID4gY29tcGxhaW46Cj4gPiAiIiIKPiA+IEVSUk9SOiBicmFjZXMge30gYXJl
IG5lY2Vzc2FyeSBldmVuIGZvciBzaW5nbGUgc3RhdGVtZW50IGJsb2Nrcwo+ID4gKyAgICBmb3Ig
KGkgPT0gMDsgaSA8IDA7ICsraSkKPiA+ICsgICAgewo+ID4gKyAgICAgICAgOwo+ID4gKyAgICB9
IGVsc2UKPiA+ICIiIgo+IAo+IFRoaXMgaXMgYSBiaXQgb2YgYW4gb2RkIGV4YW1wbGUgLS0gZm9y
KCkgbG9vcHMgZG9uJ3QKPiB0YWtlICJlbHNlIiBjbGF1c2VzLCBzbyB3aGF0IGlzIHRoZSAnZWxz
ZScgZG9pbmcgaGVyZT8KPiAKPiAoQWxzbywgZm9yIFFFTVUgc3R5bGUgdGhlICJ7IiBzaG91bGQg
YmUgb24gdGhlIHNhbWUgbGluZSBhcyB0aGUgZm9yKCksCj4gbm90IG9uIGEgbGluZSBvZiBpdHMg
b3duLikKPiAKPiB0aGFua3MKPiAtLSBQTU0K
