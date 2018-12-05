Received: from eggs.gnu.org ([2001:4830:134:3::10]:50269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gUXPT-00014I-1W
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:40:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gUXPP-0000Le-KK
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:40:14 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 5 Dec 2018 13:39:58 +0000
Message-ID: <7d5d502b-9bba-47ed-648e-65495765c4ca@virtuozzo.com>
References: <20181203165810.14509-1-kwolf@redhat.com>
	<20181203165810.14509-3-kwolf@redhat.com>
	<dc86835f-65d9-cada-dc9b-1f2c708521f9@de.ibm.com>
	<75f7e3cc-bd46-c743-84ab-cd68bcb1dcfb@de.ibm.com>
	<d0966d94-87d4-0f25-f2e0-846a1d338be7@de.ibm.com>
	<20181205084614.GA4018@dhcp-200-186.str.redhat.com>
	<30858ce0-5b4b-c3c4-b846-6a214670f8d2@de.ibm.com>
	<f91cf64b-db93-f2e5-bceb-93013592ad03@virtuozzo.com>
	<34e1b572-41b0-ae72-6d12-283516c9218c@de.ibm.com>
In-Reply-To: <34e1b572-41b0-ae72-6d12-283516c9218c@de.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8742BC04B9D4E4B80174AEA850F1387@eurprd08.prod.outlook.com>
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

MDUuMTIuMjAxOCAxNTozNSwgQ2hyaXN0aWFuIEJvcm50cmFlZ2VyIHdyb3RlOg0KPiANCj4gDQo+
IE9uIDA1LjEyLjIwMTggMTM6MDAsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6
DQo+PiAwNS4xMi4yMDE4IDEyOjAxLCBDaHJpc3RpYW4gQm9ybnRyYWVnZXIgd3JvdGU6DQo+Pj4N
Cj4+Pg0KPj4+IE9uIDA1LjEyLjIwMTggMDk6NDYsIEtldmluIFdvbGYgd3JvdGU6DQo+Pj4+IEFt
IDA1LjEyLjIwMTggdW0gMDk6MjMgaGF0IENocmlzdGlhbiBCb3JudHJhZWdlciBnZXNjaHJpZWJl
bjoNCj4+Pj4+Pj4+ICsjIHByZXBhcmUgc291cmNlIGltYWdlDQo+Pj4+Pj4+PiArcWVtdV9pbWdf
Y3JlYXRlKCctZicsIGlvdGVzdHMuaW1nZm10LCAnLW8nLCAncHJlYWxsb2NhdGlvbj1tZXRhZGF0
YScsIGRpc2ssDQo+Pj4+Pj4+PiArICAgICAgICAgICAgICAgIHN0cihzaXplKSkNCj4+Pj4+Pj4+
ICsNCj4+Pj4+Pj4+ICt2bSA9IFFFTVVNYWNoaW5lKGlvdGVzdHMucWVtdV9wcm9nKQ0KPj4+Pj4+
Pj4gK3ZtLmFkZF9hcmdzKCctbWFjaGluZScsICdwYyxhY2NlbD1rdm0nKQ0KPj4+Pj4NCj4+Pj4+
IFRoaXMgKHBjKSBjbGVhcmx5IGRvZXMgbm90IHdvcmsgb24gb3RoZXIgYXJjaGl0ZWN0dXJlcy4N
Cj4+Pj4+IEluIGFkZGl0aW9uIHRvIHRoYXQsIEkgYWxzbyBuZWVkIHRvIGFkZCAtbm8tc2h1dGRv
d24gb24gczM5MCAoc2VlIDA2OCBmb3IgYSBzaW1pbGFyIGNhc2UpDQo+Pj4+DQo+Pj4+IExlYXZp
bmcgb3V0IHBjIGRlZmluaXRlbHkgbWFrZXMgc2Vuc2UsIGFuZCB0aGUgYnVnIHN0aWxsIHJlcHJv
ZHVjZXMgZm9yDQo+Pj4+IG1lIHdpdGhvdXQgaXQuDQo+Pj4+DQo+Pj4+IEkgZG9uJ3QgdW5kZXJz
dGFuZCB0aGUgLW5vLXNodXRkb3duLCB0aG91Z2guIEFscmVhZHkgZm9yIDA2OCwgbmVpdGhlcg0K
Pj4+PiB0aGUgY29kZSBub3IgdGhlIGNvbW1pdCBtZXNzYWdlIHdoZW4gaXQgd2FzIGFkZGVkIGV4
cGxhaW4gd2h5IHRoaXMgaXMNCj4+Pj4gbmVlZGVkLg0KPj4+Pg0KPj4+PiBDYW4geW91IHR1cm4g
dGhpcyBpbnRvIGEgcHJvcGVyIHBhdGNoIGFuZCBhZGQgYSBjb21tZW50IHdoeSAtbm8tc2h1dGRv
d24NCj4+Pj4gaXMgbmVlZGVkPw0KPj4+DQo+Pj4gSSBhbHJlYWR5IHNlbnQgdGhpcyBwYXRjaC4g
VGhlIHJlYXNvbiBpcyB0aGF0IHRoZXJlIGlzIG5vIEJJT1MgaW4gYSBjbGFzc2ljYWwgc2Vuc2UN
Cj4+PiBvbiBzMzkweC4gSWYgbm8gYm9vdGFibGUgaW1hZ2UgKGV4dGVybmFsIGtlcm5lbCBvciBm
cm9tIGRpc2spIGlzIGZvdW5kLCB0aGUgc21hbGwgYm9vdA0KPj4+IGJpb3MgbG9hZHMgYSBkaXNh
YmxlZCB3YWl0IFBTVy4gVGhlIGRlZmF1bHQgYWN0aW9uIGZvciB0aGF0IGlzIHRoZW4gc2h1dGRv
d24uDQo+Pj4NCj4+DQo+PiBJcyBpdCBhbiBvcHRpb24gZm9yIHlvdSBqdXN0IGRyb3AgdGhlIHdo
b2xlIGxpbmUgInZtLmFkZF9hcmdzKCctbWFjaGluZScsICdwYyxhY2NlbD1rdm0nKSI/DQo+PiBU
aGUgcHJvYmxlbSB3aXRob3V0IGl0IGZvciBtZSB3YXMgdGhhdCBnZGIgZmFpbGVkIHRvIHByb2R1
Y2UgZnVsbCBhbmQgbmljZSBiYWNrdHJhY2UsIGJ1dA0KPj4gdGVzdCB3b3JrZWQgYW55d2F5DQo+
IA0KPiBJbiB0aGUgY29tbWlkIG1lc3NhZ2UgVmxhZGltaXIgc2FpZCB0aGF0IGt2bSBpcyBuZWNl
c3NhcnkgdG8gdHJpZ2dlciB0aGUgcHJvYmxlbS4NCj4gDQoNCk5vLCBJIGRpZG4ndCkNCg0KYW5k
IGl0J3MgaW4gdGhlIGNvbW1lbnQ6DQojIDMuIGRyb3Aga3ZtIGFuZCB1c2UgaW90ZXN0cy5WTSgp
IChtYXliZSwgYmVjYXVzZSBvZiBxdGVzdCkgKGhvd2V2ZXIsIGl0IHN0aWxsDQojICAgIHJlcHJv
ZHVjZXMsIGlmIGp1c3QgZHJvcCBrdm0sIGJ1dCBnZGIgZmFpbGVkIHRvIHByb2R1Y2UgZnVsbCBi
YWNrdHJhY2VzDQojICAgIGZvciBtZSkNCg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGlt
aXINCg==
