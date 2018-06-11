Received: from eggs.gnu.org ([2001:4830:134:3::10]:46164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ricardo.perez_blanco@nokia.com>) id 1fSQ2o-0008RD-Mv
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:51:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ricardo.perez_blanco@nokia.com>) id 1fSQ2k-0006aj-7k
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:51:50 -0400
Received: from mail-db5eur01on0101.outbound.protection.outlook.com
	([104.47.2.101]:57712
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ricardo.perez_blanco@nokia.com>)
	id 1fSQ2j-0006ZP-Lv
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:51:46 -0400
From: "Perez Blanco, Ricardo (Nokia - BE/Antwerp)"
	<ricardo.perez_blanco@nokia.com>
Date: Mon, 11 Jun 2018 07:17:19 +0000
Message-ID: <AM3PR07MB273461E84479F860A11399BB3780@AM3PR07MB273.eurprd07.prod.outlook.com>
References: <20180601153922.11590-1-ricardo.perez_blanco@nokia.com>
	<a51fbf8b-9839-ebc1-cde5-5ae95656f918@suse.de>
	<20180608094101.GG2671@work-vm>
	<0cc71e01-7015-8f8b-6988-d3b411d3b28c@suse.de>
In-Reply-To: <0cc71e01-7015-8f8b-6988-d3b411d3b28c@suse.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] Show values and description when using
 "qom-list"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>, "Dr. David Alan
	Gilbert" <dgilbert@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmVhcyBGw6RyYmVy
IFttYWlsdG86YWZhZXJiZXJAc3VzZS5kZV0NCj4gU2VudDogRnJpZGF5LCBKdW5lIDgsIDIwMTgg
NjoyMCBQTQ0KPiBUbzogRHIuIERhdmlkIEFsYW4gR2lsYmVydCA8ZGdpbGJlcnRAcmVkaGF0LmNv
bT4NCj4gQ2M6IFBlcmV6IEJsYW5jbywgUmljYXJkbyAoTm9raWEgLSBCRS9BbnR3ZXJwKQ0KPiA8
cmljYXJkby5wZXJlel9ibGFuY29Abm9raWEuY29tPjsgRXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhh
dC5jb20+Ow0KPiBNYXJrdXMgQXJtYnJ1c3RlciA8YXJtYnJ1QHJlZGhhdC5jb20+OyBxZW11LWRl
dmVsIDxxZW11LQ0KPiBkZXZlbEBub25nbnUub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYy
XSBTaG93IHZhbHVlcyBhbmQgZGVzY3JpcHRpb24gd2hlbiB1c2luZyAicW9tLWxpc3QiDQo+IA0K
PiBBbSAwOC4wNi4yMDE4IHVtIDExOjQxIHNjaHJpZWIgRHIuIERhdmlkIEFsYW4gR2lsYmVydDoN
Cj4gPiAqIEFuZHJlYXMgRsOkcmJlciAoYWZhZXJiZXJAc3VzZS5kZSkgd3JvdGU6DQo+ID4+IEFt
IDAxLjA2LjIwMTggdW0gMTc6Mzkgc2NocmllYiBSaWNhcmRvIFBlcmV6IEJsYW5jbzoNCj4gPj4+
IEZvciBkZWJ1Z2dpbmcgcHVycG9zZXMgaXQgaXMgdmVyeSB1c2VmdWwgdG86DQo+ID4+PiAgLSBT
ZWUgdGhlIGRlc2NyaXB0aW9uIG9mIHRoZSBmaWVsZC4gVGhpcyBpbmZvcm1hdGlvbiBpcyBhbHJl
YWR5IGZpbGxlZA0KPiA+Pj4gICAgaW4gYnV0IG5vdCBzaG93biBpbiAicW9tLWxpc3QiIGNvbW1h
bmQuDQo+ID4+DQo+ID4+IE5vIG9iamVjdGlvbiBvbiB0aGlzIHBhcnQuDQo+ID4+DQo+ID4+PiAg
LSBEaXNwbGF5IHZhbHVlIG9mIHRoZSBmaWVsZC4NCj4gPj4NCj4gPj4gVGhhdCBpcyBieSBkZWZp
bml0aW9uIHRoZSBxb20tZ2V0IG9wZXJhdGlvbiwgbm90IHFvbS1saXN0LiBKdXN0IGxpa2UNCj4g
Pj4gdGhlIGxzIGNvbW1hbmQgZG9lcyBub3Qgc2hvdyBmaWxlIGNvbnRlbnRzLCB0aGVyZSdzIGNh
dCBldGMuIGZvcg0KPiA+PiB0aGF0LiBGb3IgZGVidWdnaW5nIHB1cnBvc2VzIHdlIGhhZCBhIHFv
bS10cmVlICg/KSBjb21tYW5kIHRoYXQNCj4gd291bGQNCj4gPj4gY29tYmluZSBib3RoLg0KPiA+
DQo+ID4gSSdtIG5vdCB0b28gYm90aGVyZWQgYWJvdXQgZGlzdGluZ3Vpc2hpbmcgYmV0d2VlbiB0
aGUgdHdvIGNvbW1hbmRzOw0KPiA+IGJ1dCBpdCB3b3VsZCBiZSBuaWNlIC0gb25lIHJlYXNvbiBJ
J20gbm90IHRvbyBib3RoZXJlZCBpcyBiZWNhdXNlDQo+ID4gd2UndmUgZmFpbGVkIHRvIGdldCBh
IHFvbS1nZXQgaW4gbXVsdGlwbGUgeWVhcnMgb2YgdHJ5aW5nLg0KPiA+DQpJdCB3YXMgbXkgZmly
c3QgYXR0ZW1wdC4gQnV0LCB0aGVuIEkgcmVhbGl6ZWQgaXQgd2FzIG11Y2ggZWFzaWVyIGFuZCBz
dHJhaWdodCBmb3J3YXJkIHRvIGRvIGl0IGluIHFvbS1saXN0Lg0KPiA+DQo+ID4+ICAgICAgIFRo
ZXJlIG1pZ2h0IGJlIHVubWVyZ2VkIHBhdGNoZXMgb24gcWVtdS1kZXZlbCByZWxhdGVkIHRvDQo+
ID4+IGRpc3BsYXkgb2YgY2VydGFpbiBkYXRhIHR5cGVzLg0KPiA+DQo+ID4gV2hpY2ggb25lcz8N
Cj4gDQo+IE15IG9yaWdpbmFsIHFvbS1pbmZvIHNlcmllcyBuZWVkZWQgU3RyaW5nT3V0cHV0Vmlz
aXRvciBjaGFuZ2VzIGZvciBlbnVtcw0KPiAodGVzdCBjYXNlOiBydGMpIHRoYXQgZGlkIG5vdCBn
ZXQgYWNjZXB0ZWQgaW1tZWRpYXRlbHkgYW5kIHRodXMgc29tZSBwYXJ0IG9mDQo+IEhNUCBxb20t
aW5mby9xb20tZ2V0IGdvdCBzdHVjayBkdWUgdG8gcmlza2luZyBhc3NlcnRpb25zIGZvciBxb20t
aW5mbyAvDQo+IG90aGVyd2lzZTsgUU1QIHdhcyBub3QgYWZmZWN0ZWQgSUlSQy4NCj4gDQpUaGUg
b3JpZ2luYWwgcGF0Y2ggaXMgYWxyZWFkeSBxdWl0ZSBvbGQuIEkgY2FuIG1lcmdlIGFnYWluIHdp
dGggbWFpbnN0cmVhbS4gSSBpbWFnaW5lIHRoYXQgdGhpcyB3aWxsIGZpeCBpdC4gQW0gSSByaWdo
dD8NCj4gUmVnYXJkcywNCj4gQW5kcmVhcw0KPiANCj4gLS0NCj4gU1VTRSBMaW51eCBHbWJILCBN
YXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcsIEdlcm1hbnkNCj4gR0Y6IEZlbGl4IEltZW5k
w7ZyZmZlciwgSmFuZSBTbWl0aGFyZCwgR3JhaGFtIE5vcnRvbiBIUkIgMjEyODQgKEFHDQo+IE7D
vHJuYmVyZykNCg==
