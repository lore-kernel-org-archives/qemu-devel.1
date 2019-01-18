Received: from eggs.gnu.org ([209.51.188.92]:43892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gkR19-0006zK-8x
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:04:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gkR17-0001A1-7N
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:04:51 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 18 Jan 2019 10:04:18 +0000
Message-ID: <58c238ba-7094-169a-f778-8f9cd3855640@virtuozzo.com>
References: <20190117193658.16413-1-eblake@redhat.com>
	<20190117193658.16413-16-eblake@redhat.com>
In-Reply-To: <20190117193658.16413-16-eblake@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE31C86D59844247BE8C2848777237A9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 15/21] nbd/client: Pull out oldstyle
 size determination
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

MTcuMDEuMjAxOSAyMjozNiwgRXJpYyBCbGFrZSB3cm90ZToNCj4gQW5vdGhlciByZWZhY3Rvcmlu
ZyBjcmVhdGluZyBuYmRfbmVnb3RpYXRlX2ZpbmlzaF9vbGRzdHlsZSgpDQo+IGZvciBmdXJ0aGVy
IHJldXNlIGR1cmluZyAncWVtdS1uYmQgLS1saXN0Jy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEVy
aWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPg0KPiBSZXZpZXdlZC1ieTogUmljaGFyZCBXLk0u
IEpvbmVzIDxyam9uZXNAcmVkaGF0LmNvbT4NCg0KeW91IGZvcmdldCBteSByLWI6DQpSZXZpZXdl
ZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8u
Y29tPg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=
