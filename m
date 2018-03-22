Received: from eggs.gnu.org ([2001:4830:134:3::10]:50555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1eyxXn-0000Lj-KV
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 06:34:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1eyxXi-0002tE-Og
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 06:34:03 -0400
Received: from smtp64.cstnet.cn ([159.226.251.64]:33658 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1eyxXh-0002rh-V1
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 06:33:58 -0400
Date: Thu, 22 Mar 2018 18:33:52 +0800 (GMT+08:00)
From: "Su Hang" <suhang16@mails.ucas.ac.cn>
In-Reply-To: <e75a8366-3a44-6e2d-fc95-f5c795991013@redhat.com>
References: <dca9a53.33fd5.1624c84a277.Coremail.suhang16@mails.ucas.ac.cn>
	<e75a8366-3a44-6e2d-fc95-f5c795991013@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <1a0d34be.34d74.1624d45a4c7.Coremail.suhang16@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] Should we check arguments for function `from_bcd`
 and `to_bcd`?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

VGhhbmtzIGZvciB5b3VyIHJlcGx5LiA6LSkKClN1IEhhbmcKCiJQYW9sbyBCb256aW5pIiA8cGJv
bnppbmlAcmVkaGF0LmNvbT53cm90ZToKPiBPbiAyMi8wMy8yMDE4IDA4OjAzLCBTdSBIYW5nIHdy
b3RlOg0KPiA+IFdoZW4gSSB3YXMgcmVhZGluZyAncWVtdS9ody90aW1lci9tNDh0NTkuYycoTGlu
ZTozMjgpIGFuZCBydW4gd2l0aA0KPiA+IGBtYWtlIGNoZWNrLXF0ZXN0LXBwY2AsDQo+ID4gSSBm
b3VuZCB3aGVuIHdyaXRlIGFuIGludmFsaWQgdmFsdWUgMHhjIHRvIGFkZHJlc3MgMHgxRkZGLA0K
PiA+IGBmcm9tX2JjZGAgcmV0dXJuIDEyIGluc3RlYWQgb2YgcmFpc2luZyBhbiBleGNlcHRpb24o
b3IgZXJyb3IpLg0KPiANCj4gRWFjaCBkZXZpY2UgcHJvYmFibHkgaGFzIGEgZGlmZmVyZW50IGJl
aGF2aW9yIHdoZW4gYSB3cm9uZyB2YWx1ZSBpcw0KPiB3cml0dGVuIHRvIGEgcmVnaXN0ZXIgdGhh
dCBleHBlY3RzIHZhbGlkIEJDRC4gIFRoZXJlZm9yZSwgaWYgeW91IHdhbnQgdG8NCj4gbW9kZWwg
dGhhdCwgeW91IGhhdmUgdG8gZml4IGl0IGluIGh3L3RpbWVyL200OHQ1OS5jLCBub3QgaW4gZnJv
bV9iY2QgYW5kDQo+IHRvX2JjZC4NCj4gDQo+IEhvd2V2ZXIsIG5vdGUgdGhhdCBhbnl0aGluZyB0
aGF0IHRoZSBndWVzdCBkb2VzIHNob3VsZCBuZXZlciBjYXVzZSBhbg0KPiBhc3NlcnRpb24uDQo+
IA0KPiBUaGFua3MsDQo+IA0KPiBQYW9sbw0KPiANCj4gPiAiIiIocWVtdS9ody90aW1lci9tNDh0
NTkuYykNCj4gPiAgICAgY2FzZSAweDFGRkY6DQo+ID4gICAgIGNhc2UgMHgwN0ZGOg0KPiA+ICAg
ICAgICAgLyogeWVhciAqLw0KPiA+ICAgICB0bXAgPSBmcm9tX2JjZCh2YWwpOw0KPiA+ICAgICBp
ZiAodG1wID49IDAgJiYgdG1wIDw9IDk5KSB7DQo+ID4gIiIiDQo+ID4gDQo+ID4gDQo+ID4gIiIi
KHFlbXUvaW5jbHVkZS9xZW11L2JjZC5oKQ0KPiA+IC8qIENvbnZlcnQgYSBieXRlIGJldHdlZW4g
YmluYXJ5IGFuZCBCQ0QuICAqLw0KPiA+IHN0YXRpYyBpbmxpbmUgdWludDhfdCB0b19iY2QodWlu
dDhfdCB2YWwpDQo+ID4gew0KPiA+ICAgICByZXR1cm4gKCh2YWwgLyAxMCkgPDwgNCkgfCAodmFs
ICUgMTApOw0KPiA+IH0NCj4gPiANCj4gPiBzdGF0aWMgaW5saW5lIHVpbnQ4X3QgZnJvbV9iY2Qo
dWludDhfdCB2YWwpDQo+ID4gew0KPiA+ICAgICByZXR1cm4gKCh2YWwgPj4gNCkgKiAxMCkgKyAo
dmFsICYgMHgwZik7DQo+ID4gfQ0KPiA+ICIiIg0KPiA+IA0KPiA+IFN1IEhhbmcNCj4gPiANCj4g
DQo=
