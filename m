Received: from eggs.gnu.org ([2001:4830:134:3::10]:49595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gTovp-0005yL-AK
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:10:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gTovk-0006xv-Uu
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:10:41 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Mon, 3 Dec 2018 14:04:49 +0000
Message-ID: <a297e0d6-9d23-0053-c8e3-41732af4d62a@virtuozzo.com>
References: <20181203101429.88735-1-anton.nefedov@virtuozzo.com>
	<20181203101429.88735-9-anton.nefedov@virtuozzo.com>
	<w51y3963e4m.fsf@maestria.local.igalia.com>
In-Reply-To: <w51y3963e4m.fsf@maestria.local.igalia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC66A43F9C44EB4D8922705106E6C167@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v10 8/9] qcow2: skip writing zero buffers
 to empty COW areas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

DQoNCk9uIDMvMTIvMjAxOCA0OjU5IFBNLCBBbGJlcnRvIEdhcmNpYSB3cm90ZToNCj4gT24gTW9u
IDAzIERlYyAyMDE4IDExOjE0OjU5IEFNIENFVCwgQW50b24gTmVmZWRvdiB3cm90ZToNCj4+IC0t
LSBhL3FhcGkvYmxvY2stY29yZS5qc29uDQo+PiArKysgYi9xYXBpL2Jsb2NrLWNvcmUuanNvbg0K
Pj4gQEAgLTMwMDQsNiArMzAwNCw4IEBADQo+PiAgICMNCj4+ICAgIyBAY29yX3dyaXRlOiBhIHdy
aXRlIGR1ZSB0byBjb3B5LW9uLXJlYWQgKHNpbmNlIDIuMTEpDQo+PiAgICMNCj4+ICsjIEBjbHVz
dGVyX2FsbG9jX3NwYWNlOiBhbiBhbGxvY2F0aW9uIG9mIGZpbGUgc3BhY2UgZm9yIGEgY2x1c3Rl
ciAoc2luY2UgNC4wKQ0KPiANCj4gU2luY2UgNC4wID8/DQo+IA0KPiBCZXJ0bw0KPiANCg0KSSBo
ZWFyZCB0aGF0IDMuMSB3aWxsIGJlIGZvbGxvd2VkIGJ5IDQuMA0KDQovQW50b24NCg==
