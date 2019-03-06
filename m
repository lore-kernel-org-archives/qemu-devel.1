Received: from eggs.gnu.org ([209.51.188.92]:39533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h1WvA-0006w9-HR
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:49:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h1Wv6-0000nx-CF
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:49:19 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 6 Mar 2019 13:49:00 +0000
Message-ID: <3484bb20-8769-5219-b583-8255c828b7f9@virtuozzo.com>
References: <20190301191545.8728-1-jsnow@redhat.com>
	<20190301191545.8728-6-jsnow@redhat.com>
In-Reply-To: <20190301191545.8728-6-jsnow@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <E92C732956EAE547BE19D741607901A8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 5/7] block/dirty-bitmaps: prohibit
 removing readonly bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>

MDEuMDMuMjAxOSAyMjoxNSwgSm9obiBTbm93IHdyb3RlOg0KPiBSZW1vdmUgaXMgYW4gaW5oZXJl
bnRseSBSVyBvcGVyYXRpb24sIHNvIHRoaXMgd2lsbCBmYWlsIGFueXdheSwgYnV0DQo+IHdlIGNh
biBmYWlsIGl0IHZlcnkgcXVpY2tseSBpbnN0ZWFkIG9mIHRyeWluZyBhbmQgZmFpbGluZywgc28g
ZG8gc28uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKb2huIFNub3cgPGpzbm93QHJlZGhhdC5jb20+
DQoNCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRz
b3ZAdmlydHVvenpvLmNvbT4NCg0KDQo+IC0tLQ0KPiAgIGJsb2NrZGV2LmMgfCAzICsrLQ0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9ibG9ja2Rldi5jIGIvYmxvY2tkZXYuYw0KPiBpbmRleCBjODI1NWRkYTBiLi5h
OWEwNTljNTcwIDEwMDY0NA0KPiAtLS0gYS9ibG9ja2Rldi5jDQo+ICsrKyBiL2Jsb2NrZGV2LmMN
Cj4gQEAgLTI4ODEsNyArMjg4MSw4IEBAIHZvaWQgcW1wX2Jsb2NrX2RpcnR5X2JpdG1hcF9yZW1v
dmUoY29uc3QgY2hhciAqbm9kZSwgY29uc3QgY2hhciAqbmFtZSwNCj4gICAgICAgICAgIHJldHVy
bjsNCj4gICAgICAgfQ0KPiAgIA0KPiAtICAgIGlmIChiZHJ2X2RpcnR5X2JpdG1hcF9jaGVjayhi
aXRtYXAsIEJEUlZfQklUTUFQX0JVU1ksIGVycnApKSB7DQo+ICsgICAgaWYgKGJkcnZfZGlydHlf
Yml0bWFwX2NoZWNrKGJpdG1hcCwgQkRSVl9CSVRNQVBfQlVTWSB8IEJEUlZfQklUTUFQX1JPLA0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlcnJwKSkgew0KPiAgICAgICAgICAg
cmV0dXJuOw0KPiAgICAgICB9DQo+ICAgDQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxh
ZGltaXINCg==
