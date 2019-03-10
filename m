Received: from eggs.gnu.org ([209.51.188.92]:37035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lukas.auer@aisec.fraunhofer.de>) id 1h32q0-0005Va-Sp
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 14:06:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lukas.auer@aisec.fraunhofer.de>) id 1h32nv-0007Yr-SO
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 14:04:08 -0400
From: "Auer, Lukas" <lukas.auer@aisec.fraunhofer.de>
Date: Sun, 10 Mar 2019 18:03:54 +0000
Message-ID: <e131b4b0eb9109547ce0ed0993665206d6bf983a.camel@aisec.fraunhofer.de>
References: <20190210201726.3567-1-lukas.auer@aisec.fraunhofer.de>
	<CAEUhbmUtSAeznt1DCwJ7tS=YFeqwnYBemS6278=QQ60qs_MthA@mail.gmail.com>
	<c9f69861058412a1f71418a9c892daf0821a9e33.camel@aisec.fraunhofer.de>
	<CAEUhbmXjCqRRtNDqq5E5y60sDz+4=WqMuxFhaLndot7TSJuUiQ@mail.gmail.com>
In-Reply-To: <CAEUhbmXjCqRRtNDqq5E5y60sDz+4=WqMuxFhaLndot7TSJuUiQ@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CA85682BF11414581107E976302382F@xch.fraunhofer.de>
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

SGkgQmluLA0KDQpPbiBTdW4sIDIwMTktMDMtMTAgYXQgMjI6NTcgKzA4MDAsIEJpbiBNZW5nIHdy
b3RlOg0KPiBIaSBMdWthcywNCj4gDQo+IE9uIFN1biwgTWFyIDEwLCAyMDE5IGF0IDk6NDQgUE0g
QXVlciwgTHVrYXMNCj4gPGx1a2FzLmF1ZXJAYWlzZWMuZnJhdW5ob2Zlci5kZT4gd3JvdGU6DQo+
ID4gSGkgQmluLA0KPiA+IA0KPiA+IE9uIFN1biwgMjAxOS0wMy0xMCBhdCAwOTowNyArMDgwMCwg
QmluIE1lbmcgd3JvdGU6DQo+ID4gPiBIaSBMdWthcywNCj4gPiA+IA0KPiA+ID4gT24gTW9uLCBG
ZWIgMTEsIDIwMTkgYXQgNjoxMyBBTSBMdWthcyBBdWVyDQo+ID4gPiA8bHVrYXMuYXVlckBhaXNl
Yy5mcmF1bmhvZmVyLmRlPiB3cm90ZToNCj4gPiA+ID4gUmUtYWRkIHRoZSBwcmV2aW91cyBjb21w
YXRpYmxlIHN0cmluZyAicmlzY3YtdmlydGlvLXNvYyIgdG8gdGhlDQo+ID4gPiA+IHNvYw0KPiA+
ID4gPiBkZXZpY2UgdHJlZSBub2RlIHRvIGFsbG93IFUtQm9vdCBhbmQgTGludXggdG8gYmluZCBt
YWNoaW5lLQ0KPiA+ID4gPiBzcGVjaWZpYw0KPiA+ID4gPiBkcml2ZXJzIHRvIGl0LiBUaGUgY3Vy
cmVudCBjb21wYXRpYmxlIHN0cmluZyAic2ltcGxlLWJ1cyIgaXMNCj4gPiA+ID4gcmV0YWluZWQu
DQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlzIGlzIHJlcXVpcmVkIGJ5IFUtQm9vdCB0byBiaW5kIGRl
dmljZXMgZWFybHksIGFzIHBhcnQgb2YNCj4gPiA+ID4gdGhlDQo+ID4gPiA+IHByZS1yZWxvY2F0
aW9uIGRyaXZlciBtb2RlbC4NCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IEkgc2VlIG5vIHByb2Js
ZW0gd2l0aCBVLUJvb3Qgd29ya2luZyB3aXRoIGN1cnJlbnQgY29tcGF0aWJsZQ0KPiA+ID4gc3Ry
aW5nDQo+ID4gPiAic2ltcGxlLWJ1cyIuIEluIGZhY3QgSSBoYWQgcGxhbm5lZCB0byByZW1vdmUg
dGhlIGNvbXBhdGlibGUNCj4gPiA+IHN0cmluZw0KPiA+ID4gInJpc2N2LXZpcnRpby1zb2MiIGlu
IFUtQm9vdCBidXQgZGlkIG5vdCBnZXQgdGltZSB0byB3b3JrIG9uIGl0Lg0KPiA+ID4gDQo+ID4g
DQo+ID4gSXQgaXMgb25seSByZXF1aXJlZCBpZiBVLUJvb3QgaXMgcnVubmluZyBpbiBtYWNoaW5l
LW1vZGUuIEZvcg0KPiA+IHJlbG9jYXRpb24gaXQgbmVlZHMgdG8gdXNlIHRoZSBDTElOVCBkcml2
ZXIgdG8gc2VuZCBhcHByb3ByaWF0ZQ0KPiA+IElQSXMgdG8NCj4gPiB0aGUgb3RoZXIgaGFydHMu
IFRvIGJlIGFibGUgdG8gcHJvYmUgdGhlIGRyaXZlciwgdGhlIGRldmljZSBhbmQgaXRzDQo+ID4g
cGFyZW50IGRldmljZSB0cmVlIG5vZGUgKHNvYykgbXVzdCB0aGVyZWZvcmUgYmUgYXZhaWxhYmxl
IGluIHRoZQ0KPiA+IHByZS0NCj4gPiByZWxvY2F0aW9uIGRldmljZSBtb2RlbC4NCj4gPiBUaGlz
IHBhdGNoIHdhcyB0aGUgZWFzaWVzdCB3YXkgSSBjb3VsZCB0aGluayBvZiBmb3IgYWNoaWV2aW5n
IHRoaXMuDQo+ID4gSXQNCj4gPiBjb3VsZCBiZSB0aGF0IHRoZXJlIGlzIGEgYmV0dGVyIHdheSBv
ZiBzb2x2aW5nIHRoaXMuDQo+ID4gDQo+IA0KPiBJIHRlc3RlZCB5b3VyIFNNUCBVLUJvb3Qgc2Vy
aWVzIGluIGJvdGggTS1tb2RlIGFuZCBTLW1vZGUsIHVzaW5nIGEgNA0KPiBjb3JlICd2aXJ0JyB0
YXJnZXQuIFdvcmtzIGZpbmUuIEkgYW0gdXNpbmcgUUVNVSAzLjEuMCBzbyBpdCBpcw0KPiAic2lt
cGxlLWJ1cyIuDQo+IA0KDQpUaGF0IGlzIGFjdHVhbGx5IG15IGZhdWx0LCBpdCBzaG91bGQgbm90
IHdvcmsuDQpXaGF0IGlzIGhhcHBlbmluZyBpcyB0aGF0IFUtQm9vdCBmYWlscyB0byByZWxvY2F0
ZSB0aGUgc2Vjb25kYXJ5IGhhcnRzLA0KYmVjYXVzZSB0aGUgQ0xJTlQgZHJpdmVyIGNhbm5vdCBn
ZXQgdGhlIG1lbW9yeSBhZGRyZXNzIG9mIHRoZSBDTElOVA0KZGV2aWNlLiBUaGlzIGVycm9yIGlz
IGN1cnJlbnRseSBzaWxlbnRseSBpZ25vcmVkLg0KVGhlIHNlY29uZGFyeSBoYXJ0cyBhcmUgc3Rp
bGwgd2FpdGluZyB0byByZWNlaXZlIElQSXMsIHNvIGJvb3RpbmcgTGludXgNCndvcmtzIGZpbmUs
IGJlY2F1c2UgVS1Cb290IGNhbiBub3cgc2VuZCBJUElzLiBUaGlzIHdpbGwgaG93ZXZlciBicmVh
aw0KaWYgVS1Cb290IG92ZXJ3cml0ZXMgdGhlIGNvZGUgdGhlIHNlY29uZGFyeSBoYXJ0cyBhcmUg
cnVubmluZywgd2hpY2gNCmNvdWxkIGhhcHBlbiB3aGVuIGxvYWRpbmcgYW4gaW1hZ2UuDQoNCkkg
d2lsbCB1cGRhdGUgbXkgU01QIFUtQm9vdCBzZXJpZXMgdG8gcHJpbnQgYSB3YXJuaW5nIGlmIHNl
bmRpbmcgYW4gSVBJDQpmYWlscy4NCg0KVGhhbmtzLA0KTHVrYXMNCg==
