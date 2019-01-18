Received: from eggs.gnu.org ([209.51.188.92]:45261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gkSjf-0007V2-OX
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:54:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gkSje-0000uc-Nb
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:54:55 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 18 Jan 2019 11:54:35 +0000
Message-ID: <a7b70b04-f13c-9c5e-10ae-0d96bc042b38@virtuozzo.com>
References: <20190117193658.16413-1-eblake@redhat.com>
	<20190117193658.16413-17-eblake@redhat.com>
In-Reply-To: <20190117193658.16413-17-eblake@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <A77C6FE7E34E584AAEDC817CA5D03FF5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 16/21] nbd/client: Refactor nbd_opt_go()
 to support NBD_OPT_INFO
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

MTcuMDEuMjAxOSAyMjozNiwgRXJpYyBCbGFrZSB3cm90ZToNCj4gUmVuYW1lIHRoZSBmdW5jdGlv
biB0byBuYmRfb3B0X2luZm9fb3JfZ28oKSB3aXRoIGFuIGFkZGVkIHBhcmFtZXRlcg0KPiBhbmQg
c2xpZ2h0IGNoYW5nZXMgdG8gY29tbWVudHMgYW5kIHRyYWNlIG1lc3NhZ2VzLCBpbiBvcmRlciB0
bw0KPiByZXVzZSB0aGUgZnVuY3Rpb24gZm9yIE5CRF9PUFRfSU5GTy4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1ieTogVmxh
ZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQot
LSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=
