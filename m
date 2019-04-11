Received: from eggs.gnu.org ([209.51.188.92]:49206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEa4b-0006dY-3C
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 09:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEa4a-0000Td-8B
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 09:49:01 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 11 Apr 2019 13:48:53 +0000
Message-ID: <955ec895-5b90-7294-d5e2-41829f56e529@virtuozzo.com>
References: <20190410205715.2209-1-mreitz@redhat.com>
	<20190410205715.2209-2-mreitz@redhat.com>
In-Reply-To: <20190410205715.2209-2-mreitz@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <151E35536BC7B24C80A3FFAF4BFD4AE6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 1/6] qemu-img: Move quiet into
 ImgConvertState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, Denis Lunev <den@virtuozzo.com>

MTAuMDQuMjAxOSAyMzo1NywgTWF4IFJlaXR6IHdyb3RlOg0KPiBNb3ZlIGltZ19jb252ZXJ0KCkn
cyBxdWlldCBmbGFnIGludG8gdGhlIEltZ0NvbnZlcnRTdGF0ZSBzbyBpdCBpcw0KPiBhY2Nlc3Np
YmxlIGJ5IG5lc3RlZCBmdW5jdGlvbnMuICAtcSBkaWN0YXRlcyB0aGF0IGl0IHN1cHByZXNzZXMg
YW55dGhpbmcNCj4gYnV0IGVycm9ycywgc28gaWYgdGhvc2UgZnVuY3Rpb25zIHdhbnQgdG8gZW1p
dCB3YXJuaW5ncywgdGhleSBuZWVkIHRvDQo+IHF1ZXJ5IHRoaXMgZmxhZyBmaXJzdC4gIChUaGVy
ZSBjdXJyZW50bHkgYXJlIG5vIHN1Y2ggd2FybmluZ3MsIGJ1dCB0aGVyZQ0KPiB3aWxsIGJlIGFz
IG9mIHRoZSBuZXh0IHBhdGNoLikNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1heCBSZWl0eiA8bXJl
aXR6QHJlZGhhdC5jb20+DQo+IFJldmlld2VkLWJ5OiBFcmljIEJsYWtlIDxlYmxha2VAcmVkaGF0
LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1l
bnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=
