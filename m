Received: from eggs.gnu.org ([209.51.188.92]:42574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h1ZSZ-0005nj-Ke
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:32:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h1ZSX-0003Kn-BW
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:31:59 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 6 Mar 2019 16:31:37 +0000
Message-ID: <82c6b3a3-e216-539c-ed86-500d6a6fbc05@virtuozzo.com>
References: <20190211125601.86533-1-vsementsov@virtuozzo.com>
	<d582055f-6ee7-ad62-e178-023a283f89dd@redhat.com>
In-Reply-To: <d582055f-6ee7-ad62-e178-023a283f89dd@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <62D35D1B24A2D34B9B8AF2000D1A7854@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/4] nbd: non-blocking negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "berrange@redhat.com" <berrange@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>

MDYuMDMuMjAxOSAxOToxMSwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gMi8xMS8xOSA2OjU1IEFN
LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gSGkgYWxsIQ0KPj4NCj4+
IEhlcmUgaXMgYSB0cnkgb2YgbW92aW5nIHRvIG5vbi1ibG9ja2luZyBuZWdvdGlhdGlvbiBpbiBu
YmQNCj4+IGNvZGUsIHByb3Bvc2VkIGJ5IERlbmllbCBpbg0KPj4gaHR0cHM6Ly9saXN0cy5nbnUu
b3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMTktMDEvbXNnMDM4MTcuaHRtbA0KPj4NCj4+
IGluIHRocmVhZCAiW1BBVENIIHY0IDAwLzEwXSBOQkQgcmVjb25uZWN0Ig0KPj4gaHR0cHM6Ly9s
aXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMTgtMDcvbXNnMDU5NzMuaHRt
bA0KPj4NCj4+IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgKDQpOg0KPj4gICAgaW8vY2hh
bm5lbDogYWRkIHFpb19jaGFubmVsX2dldF9hdHRhY2hlZF9haW9fY29udGV4dCgpDQo+PiAgICBu
YmQvY2xpZW50OiBkbyBuZWdvdGlhdGlvbiBpbiBjb3JvdXRpbmUNCj4+ICAgIG5iZDogZG8gcWVt
dV9jb3JvdXRpbmVfeWllbGQgZHVyaW5nIHRscyBoYW5kc2hha2UNCj4+ICAgIGJsb2NrL25iZC1j
bGllbnQ6IHVzZSBub24tYmxvY2tpbmcgaW8gY2hhbm5lbCBmb3IgbmJkIG5lZ290aWF0aW9uDQo+
IA0KPiBXaWxsIHRoZXJlIGJlIGEgdjIgb2YgdGhpcyBzZXJpZXM/ICBTb2Z0IGZyZWV6ZSBmb3Ig
NC4wIGlzIGNvbWluZyB1cA0KPiB2ZXJ5IHJhcGlkbHksIHNvIEknbSB0cnlpbmcgdG8gZ2F1Z2Ug
aWYgdGhpcyBpcyBzdGlsbCA0LjAgbWF0ZXJpYWwgKGFuZA0KPiBJIHNob3VsZCBob2xkIG9mZiBt
eSBOQkQgcXVldWUgZm9yIGEgY2hhbmNlIHRvIGluY2x1ZGUgaXQpIG9yIGlmIGl0IGlzDQo+IG1v
cmUgbGlrZWx5IHRvIHNsaXAgaW50byA0LjEgKGFuZCBJIHNob3VsZCBwb3N0IG15IE5CRCBwdWxs
IHJlcXVlc3QNCj4gc29vbmVyIHRvIGF2b2lkIGJ1cmRlbmluZyBQZXRlciB3aXRoIGEgbGFzdC1t
aW51dGUgcnVzaCBuZXh0IHdlZWspLg0KPiANCg0KSSBkZWNpZGVkIHRvIGdvIGFub3RoZXIgd2F5
IGFzIEkgcmVhbGx5IHVuc3VyZSBhYm91dCB1c2luZyBhbGwgdGhpcyBzdGFmZg0KaW4gYSBjb250
ZXh0IG9mIHRoZSB0aHJlYWQgaW4gbmJkIHNlcnZlci4gQW5kIGl0J2xsIGJlIDEtMiBwYXRjaGVz
Lg0KUG9zc2libHksIHRoZXknbGwgYmUgcmVhZHkgb24gTWFyY2ggOS4NCg0KT24gdGhlIG90aGVy
IGhhbmQsIHRoZSBtb3N0IGludGVyZXN0IHBhcnQgaXMgbmJkLXJlY29ubmVjdCBzZXJpZXMgYW5k
IGl0DQpkb2Vzbid0IHNlZW0gZmVhc2libGUgdG8gZmluaXNoIGl0IGZvciA0LjAuIChpdCdzIHBv
c3NpYmxlIHRoYXQgTWFyY2ggOQ0Kd291bGQgYmUgdGhlIG9ubHkgbXkgd29ya2luZyBkYXkgZnJv
bSA3LTExKQ0KDQpTbywgSSB0aGluaywgbGV0J3MgbW92ZSB0aGlzIGFsbCB0byA0LjEuDQoNCg0K
LS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K
