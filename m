Received: from eggs.gnu.org ([2001:4830:134:3::10]:43484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gZBY2-0004Ff-Vl
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 04:20:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gZBY0-0001YU-AI
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 04:20:18 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 18 Dec 2018 09:20:12 +0000
Message-ID: <a2aba45f-0ca9-b6e2-8a23-7f70b8e3374d@virtuozzo.com>
References: <20181214231512.5295-1-jsnow@redhat.com>
	<20181214231512.5295-8-jsnow@redhat.com>
In-Reply-To: <20181214231512.5295-8-jsnow@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <B00F35112590AE499836A10B2BCDD2D5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 7/7] iotests: add iotest 236 for testing
 bitmap merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

MTUuMTIuMjAxOCAyOjE1LCBKb2huIFNub3cgd3JvdGU6DQo+IE5ldyBpbnRlcmZhY2UsIG5ldyBz
bW9rZSB0ZXN0Lg0KDQpkb24ndCBmb3JnZXQgdG8gYWRkIHMtby1iIGhlcmUgYW5kIGluIHByZXZp
b3VzIHBhdGNoIDopDQoNCg0KRmVlbCwgdGhhdCBJIGRvIHRvbyBtdWNoIG5pdHBpY2tpbmcuDQpB
Y3R1YWxseSB0ZXN0IGlzIGdvb2QgYW5kIHdvcmtzIGZvciBtZSwNCnNvLCB3aXRoIGF0IGxlYXN0
DQpxZW11X2ltZ19waXBlIC0+IHFlbXVfaW1nIG9yIHFlbXVfaW1nX2NyZWF0ZQ0KYW5kIGFkZGVk
IG5ld2xpbmUgYXQgdGhlIGVuZCBvZiBncm91cCBmaWxlLCBhcyBnaXQgcmVjb21tZW5kczoNCg0K
UmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmly
dHVvenpvLmNvbT4NCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=
