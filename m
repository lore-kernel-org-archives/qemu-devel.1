Received: from eggs.gnu.org ([2001:4830:134:3::10]:56451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gTp9D-0002GG-TQ
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:24:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gTp9D-0004hU-4W
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:24:31 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 3 Dec 2018 14:24:18 +0000
Message-ID: <7f0517ce-327e-01be-16fd-8fa625627290@virtuozzo.com>
References: <20181130144705.77454-1-anton.nefedov@virtuozzo.com>
	<20181130144705.77454-10-anton.nefedov@virtuozzo.com>
In-Reply-To: <20181130144705.77454-10-anton.nefedov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <84A3F88AC59A8C4489B261C898D45374@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6 9/9] qapi: query-blockstat: add driver
 specific file-posix stats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, "berto@igalia.com" <berto@igalia.com>

MzAuMTEuMjAxOCAxNzo0NywgQW50b24gTmVmZWRvdiB3cm90ZToNCj4gQSBibG9jayBkcml2ZXIg
Y2FuIHByb3ZpZGUgYSBjYWxsYmFjayB0byByZXBvcnQgZHJpdmVyLXNwZWNpZmljDQo+IHN0YXRp
c3RpY3MuDQo+IA0KPiBmaWxlLXBvc2l4IGRyaXZlciBub3cgcmVwb3J0cyBkaXNjYXJkIHN0YXRp
c3RpY3MNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFudG9uIE5lZmVkb3YgPGFudG9uLm5lZmVkb3ZA
dmlydHVvenpvLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZs
YWRpbWlyDQo=
