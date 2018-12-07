Received: from eggs.gnu.org ([2001:4830:134:3::10]:44440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gVHOj-0003f0-Bh
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 09:46:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gVHOh-0003k5-8a
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 09:46:33 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Fri, 7 Dec 2018 14:46:13 +0000
Message-ID: <92eb1acf-62f0-9a0b-eb55-f347fa80c2ac@virtuozzo.com>
References: <20181203101429.88735-1-anton.nefedov@virtuozzo.com>
	<20181203101429.88735-4-anton.nefedov@virtuozzo.com>
	<w51pnudv221.fsf@maestria.local.igalia.com>
In-Reply-To: <w51pnudv221.fsf@maestria.local.igalia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <F111A5B503390740BC9C26F91FA8E34A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v10 3/9] quorum: set supported write flags
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

T24gNy8xMi8yMDE4IDU6MzMgUE0sIEFsYmVydG8gR2FyY2lhIHdyb3RlOg0KPiBPbiBNb24gMDMg
RGVjIDIwMTggMTE6MTQ6NTUgQU0gQ0VULCBBbnRvbiBOZWZlZG92IHdyb3RlOg0KPj4gU2lnbmVk
LW9mZi1ieTogQW50b24gTmVmZWRvdiA8YW50b24ubmVmZWRvdkB2aXJ0dW96em8uY29tPg0KPj4g
LS0tDQo+PiAgIGJsb2NrL3F1b3J1bS5jIHwgMTkgKysrKysrKysrKysrKysrKysrLQ0KPj4gICAx
IGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRp
ZmYgLS1naXQgYS9ibG9jay9xdW9ydW0uYyBiL2Jsb2NrL3F1b3J1bS5jDQo+PiBpbmRleCAxNmIz
YzgwNjdjLi5kMjFhNmEzYjhlIDEwMDY0NA0KPj4gLS0tIGEvYmxvY2svcXVvcnVtLmMNCj4+ICsr
KyBiL2Jsb2NrL3F1b3J1bS5jDQo+PiBAQCAtODU3LDYgKzg1NywxOSBAQCBzdGF0aWMgUWVtdU9w
dHNMaXN0IHF1b3J1bV9ydW50aW1lX29wdHMgPSB7DQo+PiAgICAgICB9LA0KPj4gICB9Ow0KPj4g
ICANCj4+ICtzdGF0aWMgdm9pZCBxdW9ydW1fc2V0X3N1cHBvcnRlZF9mbGFncyhCbG9ja0RyaXZl
clN0YXRlICpicykNCj4+ICt7DQo+PiArICAgIEJEUlZRdW9ydW1TdGF0ZSAqcyA9IGJzLT5vcGFx
dWU7DQo+PiArICAgIGludCBpOw0KPj4gKw0KPj4gKyAgICBicy0+c3VwcG9ydGVkX3dyaXRlX2Zs
YWdzID0gQkRSVl9SRVFfRlVBOw0KPj4gKyAgICBmb3IgKGkgPSAwOyBpIDwgcy0+bnVtX2NoaWxk
cmVuOyBpKyspIHsNCj4+ICsgICAgICAgIGJzLT5zdXBwb3J0ZWRfd3JpdGVfZmxhZ3MgJj0gcy0+
Y2hpbGRyZW5baV0tPmJzLT5zdXBwb3J0ZWRfd3JpdGVfZmxhZ3M7DQo+PiArICAgIH0NCj4+ICsN
Cj4+ICsgICAgYnMtPnN1cHBvcnRlZF93cml0ZV9mbGFncyB8PSBCRFJWX1JFUV9XUklURV9VTkNI
QU5HRUQ7DQo+PiArfQ0KPiANCj4gWW91IGRvbid0IHNldCBzdXBwb3J0ZWRfemVyb19mbGFncyBo
ZXJlIGFueW1vcmUgPw0KPiANCj4gQmVydG8NCj4gDQoNClllcywgSSBub3RpY2VkICh0aGF0IGxh
dGUpIHRoYXQgcXVvcnVtIGRvZXNuJ3QgYWN0dWFsbHkgaW1wbGVtZW50DQp3cml0ZV96ZXJvZXMo
KS4gYmRydl9jb19kb19wd3JpdGVfemVyb2VzKCkgc3BlY2lmaWNhbGx5IGNoZWNrcyB0aGF0DQp0
aGVyZSBtdXN0IGJlIG5vIHN1cHBvcnRlZCBmbGFncyBzZXQgaW4gc3VjaCBjYXNlLg0K
