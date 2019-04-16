Received: from eggs.gnu.org ([209.51.188.92]:54557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hGJDk-0005RC-GC
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:13:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hGJDh-0002XQ-5P
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:13:36 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 16 Apr 2019 08:13:25 +0000
Message-ID: <c923c1c0-e866-9bbc-f351-1c5d861d830d@virtuozzo.com>
References: <20190413165343.9018-1-mreitz@redhat.com>
	<20190413165343.9018-8-mreitz@redhat.com>
In-Reply-To: <20190413165343.9018-8-mreitz@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D2143B25A15A14C8335426A255FE39A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 7/7] iotests: Test qemu-img convert -C
 --salvage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>

MTMuMDQuMjAxOSAxOTo1MywgTWF4IFJlaXR6IHdyb3RlOg0KPiBXZSBkbyBub3Qgc3VwcG9ydCB0
aGlzIGNvbWJpbmF0aW9uICh5ZXQpLCBzbyB0aGlzIHNob3VsZCB5aWVsZCBhbiBlcnJvcg0KPiBt
ZXNzYWdlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNv
bT4NCg0KVGVzdGVkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292
QHZpcnR1b3p6by5jb20+DQogICAgICAgICAgICBbb25seSAtcWNvdzIsIGFzIC1uZnMgLXFjb3cy
IGlzIGFscmVhZHkgYnJva2VuXQ0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2ll
dnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KSG1tLCBpbnRlcmVzdGluZywgdGhh
dCB0aGlzIHRlc3QgaXMgZGVmaW5lZCBhcw0KX3N1cHBvcnRlZF9mbXQgcWNvdzINCl9zdXBwb3J0
ZWRfcHJvdG8gZmlsZSBuZnMNCg0KQW5kIG9mIGNvdXJzZSwgaXQgZG9lc24ndCB3b3JrIGZvciAt
cWNvdzIgLW5mcyBjb21iaW5hdGlvbi4uDQoNCj4gLS0tDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3Rz
LzA4MiAgICAgfCAxICsNCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMDgyLm91dCB8IDMgKysrDQo+
ICAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS90
ZXN0cy9xZW11LWlvdGVzdHMvMDgyIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzA4Mg0KPiBpbmRleCBk
MGFmYTQ2ZTlhLi5jNThiMzcxMjdmIDEwMDc1NQ0KPiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMv
MDgyDQo+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8wODINCj4gQEAgLTE2Myw2ICsxNjMsNyBA
QCBlY2hvID09PSBjb252ZXJ0OiAtQyBhbmQgb3RoZXIgb3B0aW9ucyA9PT0NCj4gICBydW5fcWVt
dV9pbWcgY29udmVydCAtQyAtUyA0ayAtTyAkSU1HRk1UICIkVEVTVF9JTUciICIkVEVTVF9JTUci
LnRhcmdldA0KPiAgIHJ1bl9xZW11X2ltZyBjb252ZXJ0IC1DIC1TIDhrIC1PICRJTUdGTVQgIiRU
RVNUX0lNRyIgIiRURVNUX0lNRyIudGFyZ2V0DQo+ICAgcnVuX3FlbXVfaW1nIGNvbnZlcnQgLUMg
LWMgLU8gJElNR0ZNVCAiJFRFU1RfSU1HIiAiJFRFU1RfSU1HIi50YXJnZXQNCj4gK3J1bl9xZW11
X2ltZyBjb252ZXJ0IC1DIC0tc2FsdmFnZSAtTyAkSU1HRk1UICIkVEVTVF9JTUciICIkVEVTVF9J
TUciLnRhcmdldA0KPiAgIA0KPiAgIGVjaG8NCj4gICBlY2hvID09PSBhbWVuZDogT3B0aW9ucyBz
cGVjaWZpZWQgbW9yZSB0aGFuIG9uY2UgPT09DQo+IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlv
dGVzdHMvMDgyLm91dCBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8wODIub3V0DQo+IGluZGV4IGQzNjkz
OGRhOWIuLjlkNGY3NTc0YzkgMTAwNjQ0DQo+IC0tLSBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8wODIu
b3V0DQo+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8wODIub3V0DQo+IEBAIC01NTUsNiArNTU1
LDkgQEAgcWVtdS1pbWc6IENhbm5vdCBlbmFibGUgY29weSBvZmZsb2FkaW5nIHdoZW4gLVMgaXMg
dXNlZA0KPiAgIFRlc3Rpbmc6IGNvbnZlcnQgLUMgLWMgLU8gcWNvdzIgVEVTVF9ESVIvdC5xY293
MiBURVNUX0RJUi90LnFjb3cyLnRhcmdldA0KPiAgIHFlbXUtaW1nOiBDYW5ub3QgZW5hYmxlIGNv
cHkgb2ZmbG9hZGluZyB3aGVuIC1jIGlzIHVzZWQNCj4gICANCj4gK1Rlc3Rpbmc6IGNvbnZlcnQg
LUMgLS1zYWx2YWdlIC1PIHFjb3cyIFRFU1RfRElSL3QucWNvdzIgVEVTVF9ESVIvdC5xY293Mi50
YXJnZXQNCj4gK3FlbXUtaW1nOiBDYW5ub3QgdXNlIGNvcHkgb2ZmbG9hZGluZyBpbiBzYWx2YWdp
bmcgbW9kZQ0KPiArDQo+ICAgPT09IGFtZW5kOiBPcHRpb25zIHNwZWNpZmllZCBtb3JlIHRoYW4g
b25jZSA9PT0NCj4gICANCj4gICBUZXN0aW5nOiBhbWVuZCAtZiBmb28gLWYgcWNvdzIgLW8gbGF6
eV9yZWZjb3VudHM9b24gVEVTVF9ESVIvdC5xY293Mg0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJk
cywNClZsYWRpbWlyDQo=
