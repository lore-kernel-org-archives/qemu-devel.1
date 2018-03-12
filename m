Received: from eggs.gnu.org ([2001:4830:134:3::10]:57543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1evM47-0004kR-Hk
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:56:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1evM42-0006YT-J9
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:56:31 -0400
Received: from smtp61.cstnet.cn ([159.226.251.61]:44705 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1evM41-0006Pf-U8
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:56:26 -0400
Date: Mon, 12 Mar 2018 19:56:19 +0800 (GMT+08:00)
From: "Su Hang" <suhang16@mails.ucas.ac.cn>
In-Reply-To: <CAFEAcA-U4_gKK744dwY1+8yRX8APSpa+7EUgNB0SW9Omfc_SGw@mail.gmail.com>
References: <359ea922.4a3d5.16219f40e21.Coremail.suhang16@mails.ucas.ac.cn>
	<CAFEAcA-U4_gKK744dwY1+8yRX8APSpa+7EUgNB0SW9Omfc_SGw@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4c423cb5.4a519.1621a1189cd.Coremail.suhang16@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] BiteSizedTasks: API conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter maydell <peter.maydell@linaro.org>
Cc: thomas huth <thuth@redhat.com>, qemu developers <qemu-devel@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiUGV0ZXIgTWF5ZGVsbCIgPHBl
dGVyLm1heWRlbGxAbGluYXJvLm9yZz4KPiBTZW50IFRpbWU6IDIwMTgtMDMtMTIgMTk6NDA6MjIg
KE1vbmRheSkKPiBUbzogIlN1IEhhbmciIDxzdWhhbmcxNkBtYWlscy51Y2FzLmFjLmNuPgo+IENj
OiAidGhvbWFzIGh1dGgiIDx0aHV0aEByZWRoYXQuY29tPiwgIlFFTVUgRGV2ZWxvcGVycyIgPHFl
bXUtZGV2ZWxAbm9uZ251Lm9yZz4KPiBTdWJqZWN0OiBSZTogW1FlbXUtZGV2ZWxdIEJpdGVTaXpl
ZFRhc2tzOiBBUEkgY29udmVyc2lvbgo+IAo+IE9uIDEyIE1hcmNoIDIwMTggYXQgMTE6MjQsIFN1
IEhhbmcgPHN1aGFuZzE2QG1haWxzLnVjYXMuYWMuY24+IHdyb3RlOgoKPiBsaXN0LiBBbnkgaW5k
aXZpZHVhbCBjb252ZXJzaW9uIG9mIGEgY2FsbHNpdGUgaXMgcHJvYmFibHkgc21hbGwKPiBlbm91
Z2ggdG8gYmUgYml0ZS1zaXplZCwgYnV0IHlvdSBzaG91bGRuJ3QgY29uc2lkZXIgImNoYW5nZQo+
IGV2ZXJ5d2hlcmUiIHRvIGJlIGEgc2luZ2xlIHNtYWxsIHRhc2suKQoKPiBhbmQgSSB0aGluayB0
aGF0IHdvdWxkIGJlIHRoZSBiZXN0IHRoaW5nOgo+ICAoMSkgaGF2ZSBhZGRyZXNzX3NwYWNlX3dy
aXRlX3JvbSgpIHdoaWNoIHRha2VzIHRoZSBleHRyYQo+ICBNZW1UeEF0dHJzIGFyZ3VtZW50IGFu
ZCByZXR1cm5zIHRoZSBNZW1UeFJlc3VsdCwgYW5kCj4gIG1ha2UgY3B1X3BoeXNpY2FsX21lbW9y
eV93cml0ZV9yb20oKSBqdXN0IGJlIGEgdHJpdmlhbAo+ICB3cmFwcGVyIGFyb3VuZCBpdAo+ICAo
MikgdGhlbiBjaGFuZ2UgdGhlIGNhbGxlcnMgdG8gdXNlIGFkZHJlc3Nfc3BhY2Vfd3JpdGVfcm9t
KCkKPiAgKDMpIHJlbW92ZSB0aGUgY3B1X3BoeXNpY2FsX21lbW9yeV93cml0ZV9yb20oKSB3cmFw
cGVyCj4gCj4gU3RlcCAyIGlzIHRoZSBoYXJkZXIgcGFydCwgYmVjYXVzZSByZWFsbHkgaXQgcmVx
dWlyZXMgbG9va2luZyBhdAo+IHRoZSBjYWxsIHNpdGVzIHRvIHNlZSB3aGF0IHRoZXkgc2hvdWxk
IGRvIGlmIHRoZSBtZW1vcnkgYWNjZXNzCj4gZmFpbHMuCj4gCj4gdGhhbmtzCj4gLS0gUE1NCgpU
aGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbiwgSSB3aWxsIHdvcmsgb24gaXQsIHN0ZXAgYnkgc3Rl
cC4KClN1IEhhbmcK
