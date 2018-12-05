Received: from eggs.gnu.org ([2001:4830:134:3::10]:41554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gUVqt-0006G9-R4
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:00:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gUVqr-0002vW-Ri
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:00:27 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 5 Dec 2018 12:00:01 +0000
Message-ID: <f91cf64b-db93-f2e5-bceb-93013592ad03@virtuozzo.com>
References: <20181203165810.14509-1-kwolf@redhat.com>
	<20181203165810.14509-3-kwolf@redhat.com>
	<dc86835f-65d9-cada-dc9b-1f2c708521f9@de.ibm.com>
	<75f7e3cc-bd46-c743-84ab-cd68bcb1dcfb@de.ibm.com>
	<d0966d94-87d4-0f25-f2e0-846a1d338be7@de.ibm.com>
	<20181205084614.GA4018@dhcp-200-186.str.redhat.com>
	<30858ce0-5b4b-c3c4-b846-6a214670f8d2@de.ibm.com>
In-Reply-To: <30858ce0-5b4b-c3c4-b846-6a214670f8d2@de.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <50000ED47365704197449D8FC925555C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [qemu-s390x] [PULL 2/2] iotests: simple mirror
 test with kvm on 1G image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Kevin Wolf <kwolf@redhat.com>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>

MDUuMTIuMjAxOCAxMjowMSwgQ2hyaXN0aWFuIEJvcm50cmFlZ2VyIHdyb3RlOg0KPiANCj4gDQo+
IE9uIDA1LjEyLjIwMTggMDk6NDYsIEtldmluIFdvbGYgd3JvdGU6DQo+PiBBbSAwNS4xMi4yMDE4
IHVtIDA5OjIzIGhhdCBDaHJpc3RpYW4gQm9ybnRyYWVnZXIgZ2VzY2hyaWViZW46DQo+Pj4+Pj4g
KyMgcHJlcGFyZSBzb3VyY2UgaW1hZ2UNCj4+Pj4+PiArcWVtdV9pbWdfY3JlYXRlKCctZicsIGlv
dGVzdHMuaW1nZm10LCAnLW8nLCAncHJlYWxsb2NhdGlvbj1tZXRhZGF0YScsIGRpc2ssDQo+Pj4+
Pj4gKyAgICAgICAgICAgICAgICBzdHIoc2l6ZSkpDQo+Pj4+Pj4gKw0KPj4+Pj4+ICt2bSA9IFFF
TVVNYWNoaW5lKGlvdGVzdHMucWVtdV9wcm9nKQ0KPj4+Pj4+ICt2bS5hZGRfYXJncygnLW1hY2hp
bmUnLCAncGMsYWNjZWw9a3ZtJykNCj4+Pg0KPj4+IFRoaXMgKHBjKSBjbGVhcmx5IGRvZXMgbm90
IHdvcmsgb24gb3RoZXIgYXJjaGl0ZWN0dXJlcy4NCj4+PiBJbiBhZGRpdGlvbiB0byB0aGF0LCBJ
IGFsc28gbmVlZCB0byBhZGQgLW5vLXNodXRkb3duIG9uIHMzOTAgKHNlZSAwNjggZm9yIGEgc2lt
aWxhciBjYXNlKQ0KPj4NCj4+IExlYXZpbmcgb3V0IHBjIGRlZmluaXRlbHkgbWFrZXMgc2Vuc2Us
IGFuZCB0aGUgYnVnIHN0aWxsIHJlcHJvZHVjZXMgZm9yDQo+PiBtZSB3aXRob3V0IGl0Lg0KPj4N
Cj4+IEkgZG9uJ3QgdW5kZXJzdGFuZCB0aGUgLW5vLXNodXRkb3duLCB0aG91Z2guIEFscmVhZHkg
Zm9yIDA2OCwgbmVpdGhlcg0KPj4gdGhlIGNvZGUgbm9yIHRoZSBjb21taXQgbWVzc2FnZSB3aGVu
IGl0IHdhcyBhZGRlZCBleHBsYWluIHdoeSB0aGlzIGlzDQo+PiBuZWVkZWQuDQo+Pg0KPj4gQ2Fu
IHlvdSB0dXJuIHRoaXMgaW50byBhIHByb3BlciBwYXRjaCBhbmQgYWRkIGEgY29tbWVudCB3aHkg
LW5vLXNodXRkb3duDQo+PiBpcyBuZWVkZWQ/DQo+IA0KPiBJIGFscmVhZHkgc2VudCB0aGlzIHBh
dGNoLiBUaGUgcmVhc29uIGlzIHRoYXQgdGhlcmUgaXMgbm8gQklPUyBpbiBhIGNsYXNzaWNhbCBz
ZW5zZQ0KPiBvbiBzMzkweC4gSWYgbm8gYm9vdGFibGUgaW1hZ2UgKGV4dGVybmFsIGtlcm5lbCBv
ciBmcm9tIGRpc2spIGlzIGZvdW5kLCB0aGUgc21hbGwgYm9vdA0KPiBiaW9zIGxvYWRzIGEgZGlz
YWJsZWQgd2FpdCBQU1cuIFRoZSBkZWZhdWx0IGFjdGlvbiBmb3IgdGhhdCBpcyB0aGVuIHNodXRk
b3duLg0KPiANCg0KSXMgaXQgYW4gb3B0aW9uIGZvciB5b3UganVzdCBkcm9wIHRoZSB3aG9sZSBs
aW5lICJ2bS5hZGRfYXJncygnLW1hY2hpbmUnLCAncGMsYWNjZWw9a3ZtJykiPw0KVGhlIHByb2Js
ZW0gd2l0aG91dCBpdCBmb3IgbWUgd2FzIHRoYXQgZ2RiIGZhaWxlZCB0byBwcm9kdWNlIGZ1bGwg
YW5kIG5pY2UgYmFja3RyYWNlLCBidXQNCnRlc3Qgd29ya2VkIGFueXdheQ0KDQotLSANCkJlc3Qg
cmVnYXJkcywNClZsYWRpbWlyDQo=
