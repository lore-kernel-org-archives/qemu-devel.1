Received: from eggs.gnu.org ([2001:4830:134:3::10]:45389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1fTLyo-0005wP-Qe
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 02:43:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1fTLyk-0003mi-FK
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 02:43:34 -0400
Received: from smtp65.cstnet.cn ([159.226.251.65]:33109 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1fTLyj-0003mA-Pp
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 02:43:30 -0400
Date: Thu, 14 Jun 2018 14:43:11 +0800 (GMT+08:00)
From: "Su Hang" <suhang16@mails.ucas.ac.cn>
In-Reply-To: <20180611135507.GF17756@stefanha-x1.localdomain>
References: <20180609163252.27506-1-stefanha@redhat.com>
	<6d70ea23.116b3.163e77016fb.Coremail.suhang16@mails.ucas.ac.cn>
	<20180611135507.GF17756@stefanha-x1.localdomain>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4fd442ad.5c78.163fd08a244.Coremail.suhang16@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] [PATCH] loader: implement START_SEG_ADDR_RECORD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefan hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, jusual@mail.ru, jim@groklearning.com, joel@jms.id.au, qemu.ml@steffen-goertz.de

ClNvcnJ5LCBKdWxpYSBhbmQgU3RlZmFuLiBNeSBzY2hvb2wgbWVudG9yIGFzc2lnbiBhbiBlbWVy
Z2VuY3kgdGFzayB0byBtZSwgaGUgYXNrCm1lIHRvIGZpbmlzaCBpdCB3aXRoaW4gdHdvIHdlZWtz
LiBJJ20gYWZyYWlkIEkgbWF5IG5vdCBhYmxlIHRvIGltcGxlbWVudCB0aGUKZnVuY3Rpb24gbWVu
dGlvbmVkIGluIGxhc3QgY29tbWVudHMgaW4gdGhpcyB0d28gd2Vla3MuIElmIHRoZSBuZXcgZnVu
Y3Rpb24gaXMKaW4gdXJnZW50IG5lZWQsIHBsZWFzZSBmZWVsIGZyZWUgdG8gdGFrZSBvdmVyIHRo
ZSBwYXRjaGVzOyBpZiBub3QsIEkgd2lsbAppbXBsZW1lbnQgaXQgYWZ0ZXIgbXkgdGFzayBnZXQg
ZmluaXNoZWQuCgpTaW5jZXJlbHkgc29ycnkgZm9yIHRoZSB0cm91YmxlIEkgbWlnaHQgbWFkZS4K
ClNVIEhhbmcKCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlcy0tLS0tCj4gRnJvbTogIlN0ZWZhbiBI
YWpub2N6aSIgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Cj4gU2VudCBUaW1lOiAyMDE4LTA2LTExIDIx
OjU1OjA3IChNb25kYXkpCj4gVG86ICJTdSBIYW5nIiA8c3VoYW5nMTZAbWFpbHMudWNhcy5hYy5j
bj4KPiBDYzogcWVtdS1kZXZlbEBub25nbnUub3JnLCBqdXN1YWxAbWFpbC5ydSwgamltQGdyb2ts
ZWFybmluZy5jb20sIGpvZWxAam1zLmlkLmF1LCBxZW11Lm1sQHN0ZWZmZW4tZ29lcnR6LmRlCj4g
U3ViamVjdDogUmU6IFtQQVRDSF0gbG9hZGVyOiBpbXBsZW1lbnQgU1RBUlRfU0VHX0FERFJfUkVD
T1JECj4gCj4gT24gU3VuLCBKdW4gMTAsIDIwMTggYXQgMTA6MDQ6MzJBTSArMDgwMCwgU3UgSGFu
ZyB3cm90ZToKPiA+IFN1cmUsIFRoYW5rcyBmb3IgcmVtaW5kIG1lIG9mIHRoaXMuCj4gPiBPbmUg
dGhpbmcgSSBtdXN0IHBvaW50IG91dCwgaW4gY3VycmVudCBjb2RlIGxvZ2ljLCBpZiAiU1RBUlRf
U0VHX0FERFJfUkVDT1JEIgo+ID4gb2NjdXJlZCBtdWx0aXBsZSB0aW1lcywgb25seSB0aGUgbGFz
dCBvbmUgd29ya3MuIEkgZG9uJ3Qga25vdyB3aGV0aGVyIEdOVQo+ID4gYmludXRpbHMgd291bGQg
ZW1pdCAnVGhlIFJlY29yZCcgbWFueSB0aW1lcy4KPiAKPiBJdCBkb2VzIG5vdC4gIFRoZSBiZWhh
dmlvciB5b3UgZGVzY3JpYmVkIHNlZW1zIGZpbmUuCj4gCj4gRG8geW91IGhhdmUgdGltZSB0byBz
ZW5kIGEgbmV3IHJldmlzaW9uIG9mIHlvdXIgcGF0Y2ggc2VyaWVzIGFkZHJlc3NpbmcKPiB0aGUg
Y29tbWVudHMgZnJvbSBsYXN0IHRpbWU/Cj4gCj4gVGhhbmtzLAo+IFN0ZWZhbgo=
