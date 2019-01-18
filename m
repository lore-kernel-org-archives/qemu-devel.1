Received: from eggs.gnu.org ([209.51.188.92]:42836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gkQwJ-0003vW-SB
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 04:59:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gkQwJ-0005f9-50
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 04:59:51 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 18 Jan 2019 09:59:43 +0000
Message-ID: <7e988ac8-3902-4041-da6e-80f37ba08509@virtuozzo.com>
References: <20190117193658.16413-1-eblake@redhat.com>
	<20190117193658.16413-12-eblake@redhat.com>
In-Reply-To: <20190117193658.16413-12-eblake@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F7784D4801FBB45913FE2329169D05B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 11/21] nbd/client: Split out
 nbd_send_meta_query()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

MTcuMDEuMjAxOSAyMjozNiwgRXJpYyBCbGFrZSB3cm90ZToNCj4gUmVmYWN0b3IgbmJkX25lZ290
aWF0ZV9zaW1wbGVfbWV0YV9jb250ZXh0KCkgdG8gcHVsbCBvdXQgdGhlDQo+IGNvZGUgdGhhdCBj
YW4gYmUgcmV1c2VkIHRvIHNlbmQgYSBMSVNUIHJlcXVlc3QgZm9yIDAgb3IgMSBxdWVyeS4NCj4g
Tm8gc2VtYW50aWMgY2hhbmdlLiAgVGhlIG9sZCBjb21tZW50IGFib3V0ICdzaXplb2YodWludDMy
X3QpJw0KPiBiZWluZyBlcXVpdmFsZW50IHRvICcvKiBudW1iZXIgb2YgcXVlcmllcyAqLycgaXMg
bm8gbG9uZ2VyDQo+IG5lZWRlZCwgbm93IHRoYXQgd2UgYXJlIGNvbXB1dGluZyAnc2l6ZW9mKHF1
ZXJpZXMpJyBpbnN0ZWFkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRXJpYyBCbGFrZSA8ZWJsYWtl
QHJlZGhhdC5jb20+DQo+IE1lc3NhZ2UtSWQ6IDwyMDE4MTIxNTEzNTMyNC4xNTI2MjktMTQtZWJs
YWtlQHJlZGhhdC5jb20+DQo+IFJldmlld2VkLWJ5OiBSaWNoYXJkIFcuTS4gSm9uZXMgPHJqb25l
c0ByZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tp
eSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRp
bWlyDQo=
