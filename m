Received: from eggs.gnu.org ([209.51.188.92]:37474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gj26c-0002L8-08
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:16:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gj26b-0002zh-74
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:16:41 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Mon, 14 Jan 2019 13:16:31 +0000
Message-ID: <f557be19-e398-7f5d-2851-67928f33584f@virtuozzo.com>
References: <20181130144705.77454-1-anton.nefedov@virtuozzo.com>
In-Reply-To: <20181130144705.77454-1-anton.nefedov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <28512A529343B24FB43FCF79F0888DCA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6 0/9] discard blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, "berto@igalia.com" <berto@igalia.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

T24gMzAvMTEvMjAxOCA1OjQ3IFBNLCBBbnRvbiBOZWZlZG92IHdyb3RlOg0KPiBxbXAgcXVlcnkt
YmxvY2tzdGF0cyBwcm92aWRlcyBzdGF0cyBpbmZvIGZvciB3cml0ZS9yZWFkL2ZsdXNoIG9wcy4N
Cj4gDQo+IFBhdGNoZXMgMS03IGltcGxlbWVudCB0aGUgc2ltaWxhciBmb3IgZGlzY2FyZCAodW5t
YXApIGNvbW1hbmQgZm9yIHNjc2kNCj4gYW5kIGlkZSBkaXNrcy4NCj4gRGlzY2FyZCBzdGF0ICJ1
bm1hcF9vcHMgLyB1bm1hcF9ieXRlcyIgaXMgc3VwcG9zZWQgdG8gYWNjb3VudCB0aGUgb3BzIHRo
YXQNCj4gaGF2ZSBjb21wbGV0ZWQgd2l0aG91dCBhbiBlcnJvci4NCj4gDQo+IEhvd2V2ZXIsIGRp
c2NhcmQgb3BlcmF0aW9uIGlzIGFkdmlzb3J5LiBTcGVjaWZpY2FsbHksDQo+ICAgLSBjb21tb24g
YmxvY2sgbGF5ZXIgaWdub3JlcyBFTk9UU1VQIGVycm9yIGNvZGUuDQo+ICAgICBUaGF0IG1pZ2h0
IGJlIHJldHVybmVkIGlmIHRoZSBibG9jayBkcml2ZXIgZG9lcyBub3Qgc3VwcG9ydCBkaXNjYXJk
LA0KPiAgICAgb3IgZGlzY2FyZCBoYXMgYmVlbiBjb25maWd1cmVkIHRvIGJlIGlnbm9yZWQuDQo+
ICAgLSBmb3JtYXQgZHJpdmVycyBzdWNoIGFzIHFjb3cyIG1heSBpZ25vcmUgZGlzY2FyZCBpZiB0
aGV5IHdlcmUgY29uZmlndXJlZA0KPiAgICAgdG8gaWdub3JlIHRoYXQsIG9yIGlmIHRoZSBjb3Jy
ZXNwb25kaW5nIGFyZWEgaXMgYWxyZWFkeSBtYXJrZWQgdW51c2VkDQo+ICAgICAodW5hbGxvY2F0
ZWQgLyB6ZXJvIGNsdXN0ZXJzKS4NCj4gDQo+IEFuZCB3aGF0IGlzIGFjdHVhbGx5IHVzZWZ1bCBp
cyB0aGUgbnVtYmVyIG9mIGJ5dGVzIGFjdHVhbGx5IGRpc2NhcmRlZA0KPiBkb3duIG9uIHRoZSBo
b3N0IGZpbGVzeXN0ZW0uDQo+IFRvIGFjaGlldmUgdGhhdCwgZHJpdmVyLXNwZWNpZmljIHN0YXRp
c3RpY3MgaGFzIGJlZW4gYWRkZWQgdG8gYmxvY2tzdGF0cw0KPiAocGF0Y2ggOSkuDQo+IFdpdGgg
cGF0Y2ggOCwgZmlsZS1wb3NpeCBkcml2ZXIgYWNjb3VudHMgZGlzY2FyZCBvcGVyYXRpb25zIG9u
IGl0cyBsZXZlbCB0b28uDQo+IA0KDQpwaW5nDQo=
