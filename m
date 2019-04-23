Received: from eggs.gnu.org ([209.51.188.92]:46273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIzsc-0007GM-4c
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:10:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIzsa-0008JG-JE
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:10:54 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 23 Apr 2019 18:10:44 +0000
Message-ID: <1397feac-3f80-5db6-4e03-566fd020c809@virtuozzo.com>
References: <20190422221714.7630-1-jsnow@redhat.com>
	<20190422221714.7630-2-jsnow@redhat.com>
	<eaa73eb3-a84f-a263-13b2-e25588f00fd7@virtuozzo.com>
	<91bbd108-4ac4-7e07-6d7f-03efb536ba14@redhat.com>
In-Reply-To: <91bbd108-4ac4-7e07-6d7f-03efb536ba14@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <446CE5FA89566341A82D84F3A04E6A1F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 1/2] Makefile: add nit-picky mode to
 sphinx-build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aliang@redhat.com" <aliang@redhat.com>, "kchamart@redhat.com" <kchamart@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Fam Zheng <fam@euphon.net>, "nsoffer@redhat.com" <nsoffer@redhat.com>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, "armbru@redhat.com" <armbru@redhat.com>

MjMuMDQuMjAxOSAyMTowNiwgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDQvMjMvMTkg
MjowMyBQTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDIzLjA0LjIw
MTkgMToxNywgSm9obiBTbm93IHdyb3RlOg0KPj4+IElmIHdlIGFkZCByZWZlcmVuY2VzIHRoYXQg
ZG9uJ3QgcmVzb2x2ZSAob3IgYWNjaWRlbnRhbGx5IHJlbW92ZSB0aGVtKSwNCj4+PiBpdCB3aWxs
IGJlIGhlbHBmdWwgdG8gaGF2ZSBhbiBlcnJvciBtZXNzYWdlIGFsZXJ0aW5nIHVzIHRvIHRoYXQu
DQo+Pg0KPj4gYWNjb3JkaW5nbHkgdG8gZG9jcyBJJ3ZlIGZvdW5kLCBub3QgZXJyb3IgYnV0IHdh
cm5pbmcuDQo+Pg0KPiBPaCwgdHJ1ZS4gSSBoYXZlIHRvIHJldmlzZSB0aGUgZG9jdW1lbnQgYW55
d2F5LCBzbyBJJ2xsIGNoYW5nZSBteQ0KPiBwaHJhc2luZyBoZXJlIC0tIGl0IHdvbid0IGNhdXNl
IHRoZSBidWlsZCB0byBmYWlsLCBidXQgeW91IHdpbGwgYmUgYWJsZQ0KPiB0byBzZWUgdGhlIGVy
cm9yIHdoZW4geW91IGJ1aWxkLiBJIHRoaW5rIGl0J3MgaGVscGZ1bCB0byBoYXZlIGFzIGENCj4g
bWVjaGFuaWNhbCBjaGVjayAtLSBlc3BlY2lhbGx5IGlmIHdlIHN1Y2NlZWQgaW4gYnVpbGRpbmcg
Z2VuZXJhdGVkIFJlU1QNCj4gZG9jdW1lbnRhdGlvbiAoZXZlbnR1YWxseT8uLi4pDQoNCkhtLCBp
ZiB3ZSBub3cgZG9uJ3QgaGF2ZSBvdGhlciB3YXJuaW5ncywgd2UgbWF5IGFsc28gZW5hYmxlIC1X
LCB0byBiZSBzdHJpY3QuDQoNCj4gDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBKb2huIFNub3cg
PGpzbm93QHJlZGhhdC5jb20+DQo+Pg0KPj4gUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNv
di1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+DQo+Pj4gLS0tDQo+Pj4g
ICAgTWFrZWZpbGUgfCAyICstDQo+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvTWFrZWZpbGUgYi9NYWtlZmls
ZQ0KPj4+IGluZGV4IDA0YTBkNDUwNTAuLmZmOWNlMmVkNGMgMTAwNjQ0DQo+Pj4gLS0tIGEvTWFr
ZWZpbGUNCj4+PiArKysgYi9NYWtlZmlsZQ0KPj4+IEBAIC04OTksNyArODk5LDcgQEAgZG9jcy92
ZXJzaW9uLnRleGk6ICQoU1JDX1BBVEgpL1ZFUlNJT04NCj4+PiAgICBzcGhpbnhkb2NzOiAkKE1B
TlVBTF9CVUlMRERJUikvZGV2ZWwvaW5kZXguaHRtbCAkKE1BTlVBTF9CVUlMRERJUikvaW50ZXJv
cC9pbmRleC5odG1sDQo+Pj4gICAgDQo+Pj4gICAgIyBDYW5uZWQgY29tbWFuZCB0byBidWlsZCBh
IHNpbmdsZSBtYW51YWwNCj4+PiAtYnVpbGQtbWFudWFsID0gJChjYWxsIHF1aWV0LWNvbW1hbmQs
c3BoaW54LWJ1aWxkICQoaWYgJChWKSwsLXEpIC1iIGh0bWwgLUQgdmVyc2lvbj0kKFZFUlNJT04p
IC1EIHJlbGVhc2U9IiQoRlVMTF9WRVJTSU9OKSIgLWQgLmRvY3RyZWVzLyQxICQoU1JDX1BBVEgp
L2RvY3MvJDEgJChNQU5VQUxfQlVJTERESVIpLyQxICwiU1BISU5YIiwiJChNQU5VQUxfQlVJTERE
SVIpLyQxIikNCj4+PiArYnVpbGQtbWFudWFsID0gJChjYWxsIHF1aWV0LWNvbW1hbmQsc3BoaW54
LWJ1aWxkICQoaWYgJChWKSwsLXEpIC1uIC1iIGh0bWwgLUQgdmVyc2lvbj0kKFZFUlNJT04pIC1E
IHJlbGVhc2U9IiQoRlVMTF9WRVJTSU9OKSIgLWQgLmRvY3RyZWVzLyQxICQoU1JDX1BBVEgpL2Rv
Y3MvJDEgJChNQU5VQUxfQlVJTERESVIpLyQxICwiU1BISU5YIiwiJChNQU5VQUxfQlVJTERESVIp
LyQxIikNCj4+PiAgICAjIFdlIGFzc3VtZSBhbGwgUlNUIGZpbGVzIGluIHRoZSBtYW51YWwncyBk
aXJlY3RvcnkgYXJlIHVzZWQgaW4gaXQNCj4+PiAgICBtYW51YWwtZGVwcyA9ICQod2lsZGNhcmQg
JChTUkNfUEFUSCkvZG9jcy8kMS8qLnJzdCkgJChTUkNfUEFUSCkvZG9jcy8kMS9jb25mLnB5ICQo
U1JDX1BBVEgpL2RvY3MvY29uZi5weQ0KPj4+ICAgIA0KPj4+DQo+Pg0KPj4NCj4gDQoNCg0KLS0g
DQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K
