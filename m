Received: from eggs.gnu.org ([209.51.188.92]:33569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lukas.auer@aisec.fraunhofer.de>) id 1h2yki-0002z1-BM
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 09:44:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lukas.auer@aisec.fraunhofer.de>) id 1h2ykh-0002Fi-IQ
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 09:44:32 -0400
From: "Auer, Lukas" <lukas.auer@aisec.fraunhofer.de>
Date: Sun, 10 Mar 2019 13:44:14 +0000
Message-ID: <c9f69861058412a1f71418a9c892daf0821a9e33.camel@aisec.fraunhofer.de>
References: <20190210201726.3567-1-lukas.auer@aisec.fraunhofer.de>
	<CAEUhbmUtSAeznt1DCwJ7tS=YFeqwnYBemS6278=QQ60qs_MthA@mail.gmail.com>
In-Reply-To: <CAEUhbmUtSAeznt1DCwJ7tS=YFeqwnYBemS6278=QQ60qs_MthA@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD7B6325D19A284898681D2BD4DF516C@xch.fraunhofer.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] hw/riscv/virt: re-add machine-specific
 compatible string to /soc/ node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>
Cc: "palmer@sifive.com" <palmer@sifive.com>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kbastian@mail.uni-paderborn.de" <kbastian@mail.uni-paderborn.de>, "mjc@sifive.com" <mjc@sifive.com>, "sagark@eecs.berkeley.edu" <sagark@eecs.berkeley.edu>, "Alistair.Francis@wdc.com" <Alistair.Francis@wdc.com>

SGkgQmluLA0KDQpPbiBTdW4sIDIwMTktMDMtMTAgYXQgMDk6MDcgKzA4MDAsIEJpbiBNZW5nIHdy
b3RlOg0KPiBIaSBMdWthcywNCj4gDQo+IE9uIE1vbiwgRmViIDExLCAyMDE5IGF0IDY6MTMgQU0g
THVrYXMgQXVlcg0KPiA8bHVrYXMuYXVlckBhaXNlYy5mcmF1bmhvZmVyLmRlPiB3cm90ZToNCj4g
PiBSZS1hZGQgdGhlIHByZXZpb3VzIGNvbXBhdGlibGUgc3RyaW5nICJyaXNjdi12aXJ0aW8tc29j
IiB0byB0aGUgc29jDQo+ID4gZGV2aWNlIHRyZWUgbm9kZSB0byBhbGxvdyBVLUJvb3QgYW5kIExp
bnV4IHRvIGJpbmQgbWFjaGluZS1zcGVjaWZpYw0KPiA+IGRyaXZlcnMgdG8gaXQuIFRoZSBjdXJy
ZW50IGNvbXBhdGlibGUgc3RyaW5nICJzaW1wbGUtYnVzIiBpcw0KPiA+IHJldGFpbmVkLg0KPiA+
IA0KPiA+IFRoaXMgaXMgcmVxdWlyZWQgYnkgVS1Cb290IHRvIGJpbmQgZGV2aWNlcyBlYXJseSwg
YXMgcGFydCBvZiB0aGUNCj4gPiBwcmUtcmVsb2NhdGlvbiBkcml2ZXIgbW9kZWwuDQo+ID4gDQo+
IA0KPiBJIHNlZSBubyBwcm9ibGVtIHdpdGggVS1Cb290IHdvcmtpbmcgd2l0aCBjdXJyZW50IGNv
bXBhdGlibGUgc3RyaW5nDQo+ICJzaW1wbGUtYnVzIi4gSW4gZmFjdCBJIGhhZCBwbGFubmVkIHRv
IHJlbW92ZSB0aGUgY29tcGF0aWJsZSBzdHJpbmcNCj4gInJpc2N2LXZpcnRpby1zb2MiIGluIFUt
Qm9vdCBidXQgZGlkIG5vdCBnZXQgdGltZSB0byB3b3JrIG9uIGl0Lg0KPiANCg0KSXQgaXMgb25s
eSByZXF1aXJlZCBpZiBVLUJvb3QgaXMgcnVubmluZyBpbiBtYWNoaW5lLW1vZGUuIEZvcg0KcmVs
b2NhdGlvbiBpdCBuZWVkcyB0byB1c2UgdGhlIENMSU5UIGRyaXZlciB0byBzZW5kIGFwcHJvcHJp
YXRlIElQSXMgdG8NCnRoZSBvdGhlciBoYXJ0cy4gVG8gYmUgYWJsZSB0byBwcm9iZSB0aGUgZHJp
dmVyLCB0aGUgZGV2aWNlIGFuZCBpdHMNCnBhcmVudCBkZXZpY2UgdHJlZSBub2RlIChzb2MpIG11
c3QgdGhlcmVmb3JlIGJlIGF2YWlsYWJsZSBpbiB0aGUgcHJlLQ0KcmVsb2NhdGlvbiBkZXZpY2Ug
bW9kZWwuDQpUaGlzIHBhdGNoIHdhcyB0aGUgZWFzaWVzdCB3YXkgSSBjb3VsZCB0aGluayBvZiBm
b3IgYWNoaWV2aW5nIHRoaXMuIEl0DQpjb3VsZCBiZSB0aGF0IHRoZXJlIGlzIGEgYmV0dGVyIHdh
eSBvZiBzb2x2aW5nIHRoaXMuDQoNClRoYW5rcywNCkx1a2FzDQoNCj4gPiBGaXhlczogNTNmNTQ1
MDhkYWU2KCJody9yaXNjdi92aXJ0aW86IFNldCB0aGUgc29jIGRldmljZSB0cmVlIG5vZGUNCj4g
PiBhcyBhDQo+ID4gc2ltcGxlLWJ1cyIpDQo+ID4gU2lnbmVkLW9mZi1ieTogTHVrYXMgQXVlciA8
bHVrYXMuYXVlckBhaXNlYy5mcmF1bmhvZmVyLmRlPg0KPiA+IC0tLQ0KPiA+IA0KPiA+ICBody9y
aXNjdi92aXJ0LmMgfCAzICsrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+IA0KPiBSZWdhcmRzLA0KPiBCaW4NCg==
