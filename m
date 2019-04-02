Received: from eggs.gnu.org ([209.51.188.92]:52986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hBF8W-000123-MP
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 04:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hBF8V-0006aM-9m
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 04:51:16 -0400
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Tue, 2 Apr 2019 08:51:06 +0000
Message-ID: <1c21c139-a98d-1510-a1ec-1f9131c219bc@virtuozzo.com>
References: <1553866154-257311-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1553866154-257311-4-git-send-email-andrey.shinkevich@virtuozzo.com>
	<w51sgv54qaz.fsf@maestria.local.igalia.com>
	<85b426d8-0d8a-1180-fe80-46450b83582b@virtuozzo.com>
	<w51y34t4to4.fsf@maestria.local.igalia.com>
In-Reply-To: <w51y34t4to4.fsf@maestria.local.igalia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <B890BE18B3B3594FB5DE0B86D66D93C7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 3/3] block/stream: introduce a bottom node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, Denis Lunev <den@virtuozzo.com>

DQoNCk9uIDAxLzA0LzIwMTkgMTg6NDQsIEFsYmVydG8gR2FyY2lhIHdyb3RlOg0KPiBPbiBGcmkg
MjkgTWFyIDIwMTkgMDU6MTU6NDMgUE0gQ0VULCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5
IHdyb3RlOg0KPj4+PiBAQCAtMzIzNyw3ICszMjM4LDE0IEBAIHZvaWQgcW1wX2Jsb2NrX3N0cmVh
bShib29sIGhhc19qb2JfaWQsIGNvbnN0IGNoYXIgKmpvYl9pZCwgY29uc3QgY2hhciAqZGV2aWNl
LA0KPj4+PiAgICAgICAgICAgIGpvYl9mbGFncyB8PSBKT0JfTUFOVUFMX0RJU01JU1M7DQo+Pj4+
ICAgICAgICB9DQo+Pj4+ICAgIA0KPj4+PiAtICAgIHN0cmVhbV9zdGFydChoYXNfam9iX2lkID8g
am9iX2lkIDogTlVMTCwgYnMsIGJhc2VfYnMsIGJhc2VfbmFtZSwNCj4+Pj4gKyAgICAvKiBGaW5k
IHRoZSBib3R0b20gbm9kZSB0aGF0IGhhcyB0aGUgYmFzZSBhcyBpdHMgYmFja2luZyBpbWFnZSAq
Lw0KPj4+PiArICAgIGJvdHRvbV9ub2RlID0gYnM7DQo+Pj4+ICsgICAgd2hpbGUgKChpdGVyID0g
YmFja2luZ19icyhib3R0b21fbm9kZSkpICE9IGJhc2VfYnMpIHsNCj4+Pj4gKyAgICAgICAgYm90
dG9tX25vZGUgPSBpdGVyOw0KPj4+PiArICAgIH0NCj4+Pj4gKyAgICBhc3NlcnQoYm90dG9tX25v
ZGUpOw0KPj4+PiArDQo+Pj4+ICsgICAgc3RyZWFtX3N0YXJ0KGhhc19qb2JfaWQgPyBqb2JfaWQg
OiBOVUxMLCBicywgYm90dG9tX25vZGUsIGJhc2VfbmFtZSwNCj4+Pj4gICAgICAgICAgICAgICAg
ICAgICBqb2JfZmxhZ3MsIGhhc19zcGVlZCA/IHNwZWVkIDogMCwgb25fZXJyb3IsICZsb2NhbF9l
cnIpOw0KPj4+DQo+Pj4gSXNuJ3QgaXQgc2ltcGxlciB0byBwYXNzICdiYXNlJyB0byBzdHJlYW1f
c3RhcnQoKSBhbmQgZmluZCB0aGUgYm90dG9tDQo+Pj4gbm9kZSB0aGVyZT8gKHdpdGggYmRydl9m
aW5kX292ZXJsYXkoKSkuDQo+Pj4NCj4+PiBJIHRoaW5rIGJvdHRvbSBzaG91bGQgYmUgYW4gaW50
ZXJuYWwgaW1wbGVtZW50YXRpb24gZGV0YWlsIG9mIHRoZQ0KPj4+IGJsb2NrLXN0cmVhbSBkcml2
ZXIsIGNhbGxlcnMgZG9uJ3QgbmVlZCB0byBrbm93IGFib3V0IGl0LCBvciBkbyB0aGV5Pw0KPj4+
DQo+PiBNeSBpZGVhIGlzIHRoYXQgd2Ugc2hvdWxkIGdldCByaWQgb2YgYmFzZSBiZWZvcmUgYW55
IHlpZWxkLCBhbmQgYmV0dGVyDQo+PiBkbyBpdCBhcyBzb29uIGFzIHBvc3NpYmxlLg0KPiANCj4g
QnV0IHlvdSBjYW4gZG8gaXQgYXQgdGhlIGJlZ2lubmluZyBvZiBzdHJlYW1fc3RhcnQoKSB3aXRo
b3V0IGV4cG9zaW5nDQo+ICdib3R0b20nIHRvIHRoZSBjYWxsZXJzIHdoaWNoLCBhZ2FpbiwgaXMg
YW4gaW1wbGVtZW50YXRpb24gZGV0YWlsLg0KPiANCj4gQmVydG8NCj4gDQoNCldlIGhhdmUgZ290
IGEgbGF0ZW50IHRyb3VibGUgd2l0aCB0aGUgYmFzZSBpbnZvbHZlZCBpbnRvIHRoZSBwcm9jZXNz
Lg0KRm9yIGluc3RhbmNlLCBpZiB3ZSBlbmNvdW50ZXIgYSBmaWx0ZXIgd2hpbGUgc2VhcmNoaW5n
IGZvciB0aGUgYmFzZSwNCndlIHdpbGwgd2FudCB0byBtYW5hZ2UgaXQgc29tZWhvdy4gSWYgdGhl
IGJhc2UgaXMgaWRlbnRpZmllZCBieSB0aGUNCm5vZGUgbmFtZSByYXRoZXIgdGhhbiBieSBmaWxl
IG5hbWUsIGl0IHdvdWxkIGJlIGVhc2llci4gU28sIHdlIHdvdWxkDQphc3NpZ24gdGhlIG5vZGUg
bmFtZSB0byB0aGUgYmFzZSBlYXJsaWVzdCBhcyBwb3NzaWJsZS4gQW5vdGhlciBhcHByb2FjaA0K
c3VnZ2VzdGVkIGJ5IFZsYWRpbWlyIHN1cHBvc2VkIHRvIGVsaW1pbmF0ZSB0aGUgYmFzZSBmcm9t
IHRoZSBpbnRlcmZhY2UuDQpJdCBpcyBhIHNlbnNpdGl2ZSBjaGFuZ2UgYW5kIHdlIGFsbCBuZWVk
IHRvIGNvbWUgdG8gYW4gYWdyZWVtZW50Lg0KLS0gDQpXaXRoIHRoZSBiZXN0IHJlZ2FyZHMsDQpB
bmRyZXkgU2hpbmtldmljaA0K
