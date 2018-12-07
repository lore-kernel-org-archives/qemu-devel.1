Received: from eggs.gnu.org ([2001:4830:134:3::10]:50815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gVD2t-00027C-Hp
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:07:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gVD2s-00050p-SG
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:07:43 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 7 Dec 2018 10:07:36 +0000
Message-ID: <7ff99e4c-575c-4d74-f434-c0c2a6d00ee7@virtuozzo.com>
References: <20181130220344.3350618-1-eblake@redhat.com>
	<20181130220344.3350618-12-eblake@redhat.com>
In-Reply-To: <20181130220344.3350618-12-eblake@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <06DBD6F6E717524FB400730625FD3A6C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 11/14] nbd/client: Add
 nbd_receive_export_list()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>, "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

MDEuMTIuMjAxOCAxOjAzLCBFcmljIEJsYWtlIHdyb3RlOg0KPiArLyogQ2xlYW4gdXAgcmVzdWx0
IG9mIG5iZF9yZWNlaXZlX2V4cG9ydF9saXN0ICovDQo+ICt2b2lkIG5iZF9mcmVlX2V4cG9ydF9s
aXN0KE5CREV4cG9ydEluZm8gKmluZm8sIGludCBjb3VudCkNCj4gK3sNCj4gKyAgICBpbnQgaSwg
ajsNCg0KcGVyc29uYWxseSwgSSdkIHByZWZlciBleHBsaWNpdA0KDQppZiAoIWluZm8pIHsNCiAg
ICAgcmV0dXJuOw0KfQ0KDQpoZXJlLCBpdCdzIG1vcmUgb2J2aW91cywgYW5kIGluZm8gaXMgdW5j
aGFuZ2luZywgc3RyYW5nZSB0byBjaGVjayBpdCBpbg0KYSBsb29wLg0KDQo+ICsNCj4gKyAgICBm
b3IgKGkgPSAwOyBpbmZvICYmIGkgPCBjb3VudDsgaSsrKSB7DQo+ICsgICAgICAgIGZyZWUoaW5m
b1tpXS5uYW1lKTsNCj4gKyAgICAgICAgZnJlZShpbmZvW2ldLmRlc2NyaXB0aW9uKTsNCj4gKyAg
ICAgICAgZm9yIChqID0gMDsgaiA8IGluZm9baV0ubl9jb250ZXh0czsgaisrKSB7DQo+ICsgICAg
ICAgICAgICBmcmVlKGluZm9baV0uY29udGV4dHNbal0pOw0KPiArICAgICAgICB9DQo+ICsgICAg
ICAgIGZyZWUoaW5mb1tpXS5jb250ZXh0cyk7DQo+ICsgICAgfQ0KPiArICAgIGZyZWUoaW5mbyk7
DQo+ICt9DQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K
