Received: from eggs.gnu.org ([2001:4830:134:3::10]:46247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ricardo.perez_blanco@nokia.com>) id 1fSQ33-00008z-08
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:52:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ricardo.perez_blanco@nokia.com>) id 1fSQ2y-0006lh-Pj
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:52:05 -0400
Received: from mail-db5eur01on0101.outbound.protection.outlook.com
	([104.47.2.101]:4327
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ricardo.perez_blanco@nokia.com>)
	id 1fSQ2y-0006kw-Fk
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:52:00 -0400
From: "Perez Blanco, Ricardo (Nokia - BE/Antwerp)"
	<ricardo.perez_blanco@nokia.com>
Date: Mon, 11 Jun 2018 07:18:46 +0000
Message-ID: <AM3PR07MB27376F1E4C9811908C494FFB3780@AM3PR07MB273.eurprd07.prod.outlook.com>
References: <20180601153922.11590-1-ricardo.perez_blanco@nokia.com>
	<e31963b7-b5c2-2cd4-92e6-7fc0ddbb881f@redhat.com>
In-Reply-To: <e31963b7-b5c2-2cd4-92e6-7fc0ddbb881f@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>, "open list:All patches CC here" <qemu-devel@nongnu.org>

VGhhbmtzIGZvciB0aGUgY29tbWVudHMhIFJlcGx5aW5nIGlubGluZS4NCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEJsYWtlIFttYWlsdG86ZWJsYWtlQHJlZGhh
dC5jb21dDQo+IFNlbnQ6IEZyaWRheSwgSnVuZSAxLCAyMDE4IDY6MDEgUE0NCj4gVG86IFBlcmV6
IEJsYW5jbywgUmljYXJkbyAoTm9raWEgLSBCRS9BbnR3ZXJwKQ0KPiA8cmljYXJkby5wZXJlel9i
bGFuY29Abm9raWEuY29tPg0KPiBDYzogRHIuIERhdmlkIEFsYW4gR2lsYmVydCA8ZGdpbGJlcnRA
cmVkaGF0LmNvbT47IE1hcmt1cyBBcm1icnVzdGVyDQo+IDxhcm1icnVAcmVkaGF0LmNvbT47IEFu
ZHJlYXMgRsOkcmJlciA8YWZhZXJiZXJAc3VzZS5kZT47IG9wZW4gbGlzdDpBbGwNCj4gcGF0Y2hl
cyBDQyBoZXJlIDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djJdIFNob3cgdmFsdWVzIGFuZCBkZXNjcmlwdGlvbiB3aGVuIHVzaW5nICJxb20tbGlzdCINCj4g
DQo+IE9uIDA2LzAxLzIwMTggMTA6MzkgQU0sIFJpY2FyZG8gUGVyZXogQmxhbmNvIHdyb3RlOg0K
PiA+IEZvciBkZWJ1Z2dpbmcgcHVycG9zZXMgaXQgaXMgdmVyeSB1c2VmdWwgdG86DQo+ID4gICAt
IFNlZSB0aGUgZGVzY3JpcHRpb24gb2YgdGhlIGZpZWxkLiBUaGlzIGluZm9ybWF0aW9uIGlzIGFs
cmVhZHkgZmlsbGVkDQo+ID4gICAgIGluIGJ1dCBub3Qgc2hvd24gaW4gInFvbS1saXN0IiBjb21t
YW5kLg0KPiA+ICAgLSBEaXNwbGF5IHZhbHVlIG9mIHRoZSBmaWVsZC4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFJpY2FyZG8gUGVyZXogQmxhbmNvIDxyaWNhcmRvLnBlcmV6X2JsYW5jb0Bub2tp
YS5jb20+DQo+ID4gLS0tDQo+IA0KPiA+ICsrKyBiL3FhcGkvbWlzYy5qc29uDQo+ID4gQEAgLTEz
MjgsMTAgKzEzMjgsMTIgQEANCj4gPiAgICMNCj4gPiAgICMgQGRlc2NyaXB0aW9uOiBpZiBzcGVj
aWZpZWQsIHRoZSBkZXNjcmlwdGlvbiBvZiB0aGUgcHJvcGVydHkuDQo+ID4gICAjDQo+ID4gLSMg
U2luY2U6IDEuMg0KPiA+ICsjIEB2YWx1ZTogaWYgc3BlY2lmaWVkLCB0aGUgdmFsdWUgb2YgdGhl
IHByb3BlcnR5Lg0KPiA+ICsjDQo+ID4gKyMgU2luY2U6IDIuMTMNCj4gDQo+IE5vdCBxdWl0ZS4g
VGhlIHN0cnVjdCB3YXMgZmlyc3QgaW50cm9kdWNlZCBpbiAxLjIsIGFuZCBvbmx5ICd2YWx1ZScg
d2FzIGFkZGVkDQo+IGluIDMuMCAoc2luY2Ugd2UndmUgcmVuYW1lZCAyLjEzIGludG8gMy4wKS4g
IEl0IHNob3VsZCBsb29rIGxpa2U6DQo+IA0KPiAjIEB2YWx1ZTogaWYgc3BlY2lmaWVkLCB0aGUg
dmFsdWUgb2YgdGhlIHByb3BlcnR5IChzaW5jZSAzLjApICMgIyBTaW5jZTogMS4yDQo+IA0KT2ss
IGl0IGNvbXBsZXRlbHkgbWFrZXMgc2Vuc2UuIEkgd2lsbCBmaXggaXQuDQo+IC0tDQo+IEVyaWMg
Qmxha2UsIFByaW5jaXBhbCBTb2Z0d2FyZSBFbmdpbmVlcg0KPiBSZWQgSGF0LCBJbmMuICAgICAg
ICAgICArMS05MTktMzAxLTMyNjYNCj4gVmlydHVhbGl6YXRpb246ICBxZW11Lm9yZyB8IGxpYnZp
cnQub3JnDQo=
