Received: from eggs.gnu.org ([2001:4830:134:3::10]:56910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gXPci-00015A-CK
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:57:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gXPch-0003iP-Fk
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:57:48 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Thu, 13 Dec 2018 11:57:36 +0000
Message-ID: <ef59f2ba-f59d-aed4-2c3b-af75d9e2df6b@virtuozzo.com>
References: <20181203101429.88735-1-anton.nefedov@virtuozzo.com>
	<20181203101429.88735-6-anton.nefedov@virtuozzo.com>
	<c8832c65-4b52-b56f-cd0b-499597a82b11@virtuozzo.com>
	<50f8f543-f242-649b-407c-fe7c73b91177@virtuozzo.com>
	<bd2c4805-86b4-469a-6e3f-01f787d4b3a9@virtuozzo.com>
In-Reply-To: <bd2c4805-86b4-469a-6e3f-01f787d4b3a9@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF04EE50DEA6654C8EC41E5FFCDAB64D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v10 5/9] block: treat BDRV_REQ_ALLOCATE as
 serialising
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, "berto@igalia.com" <berto@igalia.com>

DQoNCk9uIDEyLzEyLzIwMTggMzo0OCBQTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3
cm90ZToNCj4gMDUuMTIuMjAxOCAxNzowMSwgQW50b24gTmVmZWRvdiB3cm90ZToNCj4+IC0tLSBh
L2luY2x1ZGUvYmxvY2svYmxvY2suaA0KPj4gKysrIGIvaW5jbHVkZS9ibG9jay9ibG9jay5oDQo+
PiBAQCAtODcsNiArODcsOSBAQCB0eXBlZGVmIGVudW0gew0KPj4gICAgICAgICAgKiBlZmZpY2ll
bnRseSBhbGxvY2F0ZSB0aGUgc3BhY2Ugc28gaXQgcmVhZHMgYXMgemVyb2VzLCBvciByZXR1cm4N
Cj4+IGFuIGVycm9yLg0KPj4gICAgICAgICAgKiBJZiB0aGlzIGZsYWcgaXMgc2V0IHRoZW4gQkRS
Vl9SRVFfWkVST19XUklURSBtdXN0IGFsc28gYmUgc2V0Lg0KPj4gICAgICAgICAgKiBUaGlzIGZs
YWcgY2Fubm90IGJlIHNldCB0b2dldGhlciB3aXRoIEJEUlZfUkVRX01BWV9VTk1BUC4NCj4+ICsg
ICAgICogVGhpcyBmbGFnIGltcGxpY2l0bHkgYmVoYXZlcyBhcyBCRFJWX1JFUV9TRVJJQUxJU0lO
RyBpLmUuIGl0IGlzDQo+PiArICAgICAqIHByb3RlY3RlZCBmcm9tIGNvbmZsaWN0cyB3aXRoIG92
ZXJsYXBwaW5nIHJlcXVlc3RzLiBJZiBzdWNoDQo+PiBjb25mbGljdCBpcw0KPj4gKyAgICAgKiBk
ZXRlY3RlZCwgLUVBR0FJTiBpcyByZXR1cm5lZC4NCj4gDQo+ICJiZWhhdmVzIGFzIiBzb3VuZHMg
bGlrZSAiZG8gdGhlIHNhbWUiIGZvciBtZSwgc28gYmV0dGVyIGlzICJpbXBsaWNpdGx5IHNldHMi
IG9yIHNvbWV0aGluZyBsaWtlIHRoaXMuDQo+IA0KDQoiaW1wbGljaXRseSBzZXRzIiBpcyBnb29k
IGVub3VnaCBmb3IgbWUNCg==
