Received: from eggs.gnu.org ([2001:4830:134:3::10]:57260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7hnH-0007C2-GC
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:06:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7hnD-0000Hu-Bs
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:06:27 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 3 Oct 2018 14:06:18 +0000
Message-ID: <5fce74b0-a693-83b3-d71d-2d301cdf346a@virtuozzo.com>
References: <20181002230218.13949-1-jsnow@redhat.com>
	<20181002230218.13949-7-jsnow@redhat.com>
In-Reply-To: <20181002230218.13949-7-jsnow@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <F94B97CB9066164E89774BA836A0302F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 6/6] nbd: forbid use of frozen bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

UmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmly
dHVvenpvLmNvbT4NCg0KMDMuMTAuMjAxOCAwMjowMiwgSm9obiBTbm93IHdyb3RlOg0KPiBXaGV0
aGVyIGl0J3MgImxvY2tlZCIgb3IgImZyb3plbiIsIGl0J3MgaW4gdXNlIGFuZCBzaG91bGQNCj4g
bm90IGJlIGFsbG93ZWQgZm9yIHRoZSBwdXJwb3NlcyBvZiB0aGlzIG9wZXJhdGlvbi4NCj4NCj4g
U2lnbmVkLW9mZi1ieTogSm9obiBTbm93IDxqc25vd0ByZWRoYXQuY29tPg0KPiAtLS0NCj4gICBu
YmQvc2VydmVyLmMgfCA0ICsrLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvbmJkL3NlcnZlci5jIGIvbmJkL3Nl
cnZlci5jDQo+IGluZGV4IGMzZGQ0MDJiNDUuLjk0MGI3YWEwY2QgMTAwNjQ0DQo+IC0tLSBhL25i
ZC9zZXJ2ZXIuYw0KPiArKysgYi9uYmQvc2VydmVyLmMNCj4gQEAgLTI0NzgsOCArMjQ3OCw4IEBA
IHZvaWQgbmJkX2V4cG9ydF9iaXRtYXAoTkJERXhwb3J0ICpleHAsIGNvbnN0IGNoYXIgKmJpdG1h
cCwNCj4gICAgICAgICAgIHJldHVybjsNCj4gICAgICAgfQ0KPiAgIA0KPiAtICAgIGlmIChiZHJ2
X2RpcnR5X2JpdG1hcF9xbXBfbG9ja2VkKGJtKSkgew0KPiAtICAgICAgICBlcnJvcl9zZXRnKGVy
cnAsICJCaXRtYXAgJyVzJyBpcyBsb2NrZWQiLCBiaXRtYXApOw0KPiArICAgIGlmIChiZHJ2X2Rp
cnR5X2JpdG1hcF91c2VyX2xvY2tlZChibSkpIHsNCj4gKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJw
LCAiQml0bWFwICclcycgaXMgaW4gdXNlIiwgYml0bWFwKTsNCj4gICAgICAgICAgIHJldHVybjsN
Cj4gICAgICAgfQ0KPiAgIA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg0K
