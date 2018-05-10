Received: from eggs.gnu.org ([2001:4830:134:3::10]:33431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=66179fe3f=Paul.Durrant@citrix.com>)
	id 1fGgx6-0003da-Qw
	for qemu-devel@nongnu.org; Thu, 10 May 2018 04:29:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=66179fe3f=Paul.Durrant@citrix.com>)
	id 1fGgx3-0004pT-14
	for qemu-devel@nongnu.org; Thu, 10 May 2018 04:29:28 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:21792
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=66179fe3f=Paul.Durrant@citrix.com>)
	id 1fGgx2-0004mz-NJ
	for qemu-devel@nongnu.org; Thu, 10 May 2018 04:29:24 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Thu, 10 May 2018 08:29:22 +0000
Message-ID: <a789514577864e9b92d954f7944795bc@AMSPEX02CL03.citrite.net>
References: <20180509154604.25530-1-paul.durrant@citrix.com>
	<152588171396.2703.471985236583323449@71c20359a636>
	<82906d30c1854e13bd7986af99eb1d98@AMSPEX02CL03.citrite.net>
	<0c96c8b0-4736-d1fe-8145-bf14d2a24a97@redhat.com>
In-Reply-To: <0c96c8b0-4736-d1fe-8145-bf14d2a24a97@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/2] xen-hvm: use new resource mapping API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Eric Blake' <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "famz@redhat.com" <famz@redhat.com>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEJsYWtlIFttYWlsdG86
ZWJsYWtlQHJlZGhhdC5jb21dDQo+IFNlbnQ6IDA5IE1heSAyMDE4IDE4OjI2DQo+IFRvOiBQYXVs
IER1cnJhbnQgPFBhdWwuRHVycmFudEBjaXRyaXguY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3Jn
DQo+IENjOiB4ZW4tZGV2ZWxAbGlzdHMueGVucHJvamVjdC5vcmc7IGZhbXpAcmVkaGF0LmNvbQ0K
PiBTdWJqZWN0OiBSZTogW1FlbXUtZGV2ZWxdIFtQQVRDSCAwLzJdIHhlbi1odm06IHVzZSBuZXcg
cmVzb3VyY2UgbWFwcGluZw0KPiBBUEkNCj4gDQo+IE9uIDA1LzA5LzIwMTggMTE6MDUgQU0sIFBh
dWwgRHVycmFudCB3cm90ZToNCj4gDQo+ID4+IHhlbmZvcmVpZ25tZW1vcnlfbWFwX3Jlc291cmNl
KCkgdG8gbWFwIGlvcmVxIHBhZ2VzLi4uDQo+ID4+IEVSUk9SOiBzcGFjZXMgcmVxdWlyZWQgYXJv
dW5kIHRoYXQgJyonIChjdHg6V3hWKQ0KPiA+PiAjMTY0OiBGSUxFOiBpbmNsdWRlL2h3L3hlbi94
ZW5fY29tbW9uLmg6MTI4Og0KPiA+PiArICAgIHhlbmZvcmVpZ25tZW1vcnlfaGFuZGxlICpmbWVt
LCBkb21pZF90IGRvbWlkLCB1bnNpZ25lZCBpbnQNCj4gdHlwZSwNCj4gPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXg0KPiA+Pg0KPiA+PiB0b3RhbDogMSBlcnJvcnMsIDAgd2Fybmlu
Z3MsIDEzOCBsaW5lcyBjaGVja2VkDQo+ID4+DQo+ID4+IFlvdXIgcGF0Y2ggaGFzIHN0eWxlIHBy
b2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycw0KPiA+PiBhcmUg
ZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUNCj4gPj4g
Q0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4NCj4gPg0KPiA+IFRoaXMgc3R5bGUgd2FybmluZyBh
cHBlYXJzIHRvIGJlIHNwdXJpb3VzLg0KPiANCj4gWWVwLCBhbmQgaXQncyBiZWNhdXNlIHhlbmZv
cmVpZ25tZW1vcnlfaGFuZGxlIGRvZXNuJ3QgZm9sbG93IG91ciB1c3VhbA0KPiBjb252ZW50aW9u
cyBmb3IgYSB0eXBlIG5hbWUuICBTZWUgY29tbWl0IDVhYzA2N2EgaWYgeW91IHdhbnQgdG8gYWRk
IGl0DQo+IHRvIHRoZSBsaXN0IG9mIHdoaXRlbGlzdGVkIGV4Y2VwdGlvbiB0eXBlIG5hbWVzLCB0
byBzaWxlbmNlIG1lc3NhZ2VzDQo+IGxpa2UgdGhpcy4NCg0KVGhhbmtzIEVyaWMuIEknbGwgc2Vu
ZCBhIHYyIHNlcmllcyB3aXRoIGEgc3VpdGFibGUgYWRkaXRpb25hbCBwYXRjaC4NCg0KICBDaGVl
cnMsDQoNCiAgICBQYXVsDQoNCj4gDQo+IC0tDQo+IEVyaWMgQmxha2UsIFByaW5jaXBhbCBTb2Z0
d2FyZSBFbmdpbmVlcg0KPiBSZWQgSGF0LCBJbmMuICAgICAgICAgICArMS05MTktMzAxLTMyNjYN
Cj4gVmlydHVhbGl6YXRpb246ICBxZW11Lm9yZyB8IGxpYnZpcnQub3JnDQo=
