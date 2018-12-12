Received: from eggs.gnu.org ([2001:4830:134:3::10]:54191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gX0KK-0002J9-KR
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 03:57:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gX0KJ-0000lc-D6
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 03:57:08 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 12 Dec 2018 08:56:46 +0000
Message-ID: <2d4cf236-9457-a870-1686-2e5a9288398f@virtuozzo.com>
References: <20181102151152.288399-1-vsementsov@virtuozzo.com>
In-Reply-To: <20181102151152.288399-1-vsementsov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FF817550A6A3047B3C3D1EC7931CE0C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] ping Re: [PATCH 0/3] nbd-client: drop extra error noise
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>, "armbru@redhat.com" <armbru@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>

cGluZw0KDQowMi4xMS4yMDE4IDE4OjExLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdy
b3RlOg0KPiBIaSBhbGwuDQo+IA0KPiBJdCB3YXMgZGlzY3Vzc2VkLCB0aGF0IGVycm9yIG1lc3Nh
Z2VzLCBwcm9kdWNlZCBieSBlcnJvcl9yZXBydF9lcnIncywNCj4gYWRkZWQgaW4gZjE0MGUzMDAg
YXJlDQo+IDEuIG5vdCByZWFsbHkgbmVlZGVkDQo+IDIuIHN1YmplY3QgdG8gcmFjZSBjb25kaXRp
b25zDQo+IA0KPiBBbmQgaXQgd2FzIGRlY2lkZWQgdG8gZHJvcCB0aGVtIChzd2l0Y2ggdG8gdHJh
Y2UtcG9pbnRzKSwgbG9vayB0aHJlYWQNCj4gaHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUv
aHRtbC9xZW11LWRldmVsLzIwMTgtMDgvbXNnMDA4MzMuaHRtbA0KPiANCj4gU28sIEkndmUgYWxz
byBkcm9wcGVkIGVycm9yX3JlcG9ydF9lcnIsIGFkZGVkIGVhcmxpZXIgaW4gYmU0MWMxMDBjMGQN
Cj4gYW5kIGxhdGVyIGluIDc4YTMzYWI1ODc4Lg0KPiANCj4gSG1tLCBJJ3ZlIHRyaWVkIHRvIHJ1
biA4MyBpb3Rlc3QgaW4gYSBsb29wLCBhbmQgaXQgZGlkbid0IGZhaWwsIGV2ZW4NCj4gYmVmb3Jl
IHRoZXNlIHBhdGNoZXMuDQo+IA0KPiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5ICgzKToN
Cj4gICAgZXJyb3I6IGFkZCBlcnJvcl9nZXRfaGludA0KPiAgICBuYmQ6IHB1Ymxpc2ggX2xvb2t1
cCBmdW5jdGlvbnMNCj4gICAgYmxvY2svbmJkLWNsaWVudDogdXNlIHRyYWNlcyBpbnN0ZWFkIG9m
IG5vaXN5IGVycm9yX3JlcG9ydF9lcnINCj4gDQo+ICAgaW5jbHVkZS9ibG9jay9uYmQuaCAgICAg
ICAgfCAgNSArKysrKw0KPiAgIGluY2x1ZGUvcWFwaS9lcnJvci5oICAgICAgIHwgIDUgKysrKysN
Cj4gICBuYmQvbmJkLWludGVybmFsLmggICAgICAgICB8ICA1IC0tLS0tDQo+ICAgYmxvY2svbmJk
LWNsaWVudC5jICAgICAgICAgfCAyNyArKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4gICB1
dGlsL2Vycm9yLmMgICAgICAgICAgICAgICB8ICA1ICsrKysrDQo+ICAgYmxvY2svdHJhY2UtZXZl
bnRzICAgICAgICAgfCAgNCArKysrDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzA4My5vdXQgfCAy
OCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgNyBmaWxlcyBjaGFuZ2VkLCA0MiBp
bnNlcnRpb25zKCspLCAzNyBkZWxldGlvbnMoLSkNCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMs
DQpWbGFkaW1pcg0K
