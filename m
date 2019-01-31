Received: from eggs.gnu.org ([209.51.188.92]:35408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gp8vt-0002KZ-Nr
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 04:46:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gp8vs-0005Ds-Rx
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 04:46:53 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 31 Jan 2019 09:46:33 +0000
Message-ID: <c31c9188-639e-d9c2-161e-c52af3969fcf@virtuozzo.com>
References: <1548870690-647481-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1548870690-647481-3-git-send-email-andrey.shinkevich@virtuozzo.com>
	<0a2aa062-6b7c-91cc-650a-74a4d47b4bc3@redhat.com>
	<d7762c4c-b31d-2243-7b00-d6652dc7349f@virtuozzo.com>
In-Reply-To: <d7762c4c-b31d-2243-7b00-d6652dc7349f@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <50446594785D20478B49621CD00FBC53@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v10 2/3] qemu-img info lists bitmap
 directory entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>, "armbru@redhat.com" <armbru@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>

MzAuMDEuMjAxOSAyMjoyNiwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IA0KPiANCj4gT24g
MzAvMDEvMjAxOSAyMToyNCwgRXJpYyBCbGFrZSB3cm90ZToNCj4+IE9uIDEvMzAvMTkgMTE6NTEg
QU0sIEFuZHJleSBTaGlua2V2aWNoIHdyb3RlOg0KPj4+IEluIHRoZSAnRm9ybWF0IHNwZWNpZmlj
IGluZm9ybWF0aW9uJyBzZWN0aW9uIG9mIHRoZSAncWVtdS1pbWcgaW5mbycNCj4+PiBjb21tYW5k
IG91dHB1dCwgdGhlIHN1cHBsZW1lbnRhbCBpbmZvcm1hdGlvbiBhYm91dCBleGlzdGluZyBRQ09X
Mg0KDQpbLi4uXQ0KDQo+Pj4gKyMjDQo+Pj4gKyMgQFFjb3cyQml0bWFwSW5mbzoNCj4+PiArIw0K
Pj4+ICsjIFFjb3cyIGJpdG1hcCBpbmZvcm1hdGlvbi4NCj4+PiArIw0KPj4+ICsjIEBuYW1lOiB0
aGUgbmFtZSBvZiB0aGUgYml0bWFwDQo+Pj4gKyMNCj4+PiArIyBAZ3JhbnVsYXJpdHk6IGdyYW51
bGFyaXR5IG9mIHRoZSBiaXRtYXAgaW4gYnl0ZXMNCj4+PiArIw0KPj4+ICsjIEBmbGFnczogcmVj
b2duaXplZCBmbGFncyBvZiB0aGUgYml0bWFwDQo+Pj4gKyMNCj4+PiArIyBAdW5rbm93bi1mbGFn
czogYW55IHJlbWFpbmluZyBmbGFncyBub3QgcmVjb2duaXplZCBieSB0aGUgY3VycmVudCBxZW11
IHZlcnNpb24NCj4+PiArIw0KPj4+ICsjIFNpbmNlOiA0LjANCj4+PiArIyMNCj4+PiAreyAnc3Ry
dWN0JzogJ1Fjb3cyQml0bWFwSW5mbycsDQo+Pj4gKyAgJ2RhdGEnOiB7J25hbWUnOiAnc3RyJywg
J2dyYW51bGFyaXR5JzogJ3VpbnQzMicsDQo+Pj4gKyAgICAgICAgICAgJ2ZsYWdzJzogWydRY293
MkJpdG1hcEluZm9GbGFncyddLA0KPj4+ICsgICAgICAgICAgICcqdW5rbm93bi1mbGFncyc6ICd1
aW50MzInIH0gfQ0KPj4NCj4+IE5vdCBmb3IgdGhpcyBwYXRjaCwgYnV0IGhvdyBoYXJkIHdvdWxk
IGl0IGJlIHRvIGFkZCBhIGZpZWxkIHNob3dpbmcgdGhlDQo+PiBudW1iZXIgb2Ygc2V0IGJpdHMg
aW4gdGhlIGJpdG1hcD8NCj4gDQo+IEkgYmVsaWV2ZSB0aGF0IGlzIG5vdCB0b28gaGFyZCBhbmQg
d291bGQgYmUgaGFwcHkgdG8gaW1wbGVtZW50IHRoYXQgd2l0aA0KPiBhbm90aGVyIHNlcmllcywg
cGxlYXNlLg0KPiANCg0KSW4gY29tbW9uIGNhc2UsIHdlIHNob3VsZCBsb2FkIGFsbCBiaXRtYXBz
IGZvciBpdCwgd2hpY2ggaXMgYmFkIGlkZWEgZm9yIHFtcCBxdWVyeQ0Kd2hlbiB2bSBpcyBydW5u
aW5nLg0KDQpPbiB0aGUgb3RoZXIgaGFuZCwgaW4gc29tZSBtZWFuaW5nZnVsIGNhc2VzICh3aGVu
IG9wZW4gcmVhZC1vbmx5LCB3aXRoIHFlbXUtaW1nIGluZm8pLA0Kd2UgY2FuIHJldXNlIGluZm9y
bWF0aW9uIG9idGFpbmVkIGR1cmluZyBsb2FkaW5nIGJpdG1hcHMgb24gb3BlbigpLiBIb3dldmVy
LCBmb3IgaW4tdXNlDQpiaXRtYXBzIHdlJ2xsIGhhdmUgdG8gbG9hZCB0aGVtIHRvIGNvdW50IGRp
cnR5IGJpdHMuIFdoaWNoIGlzIG5vdCBhIHByb2JsZW0gZm9yIHFlbXUtaW1nLA0KYnV0IGFnYWlu
LCBtYXkgYmUgbm90IGdvb2QgaWRlYSB3aGlsZSB2bSBpcyBydW5uaW5nIChhcyBpdCBtYXkgdGFr
ZSB0b28gbXVjaCB0aW1lKS4NCg0KQWxzbywgZXhwb3J0aW5nIGRpcnR5LWNvdW50IGZvciBpbi11
c2UgYml0bWFwcyB3aGlsZSB2bSBpcyBydW5uaW5nIG1heSBiZSBhbWJpZ3VvdXMsIGFzDQpzb21l
IG9mIHRoZSBpbi11c2UgYml0bWFwcyAob3IgYWxsKSB3aWxsIGJlIGJpdG1hcHMgaW4tdXNlIGJ5
IGV4YWN0bHkgdGhpcyB2bSBydW4sIHNvDQphY3R1YWwgZGlydHktY291bnQgaXMgaW4gQmRydkRp
cnR5Qml0bWFwIGluZm8uDQoNCkFuZCwgYW5vdGhlciBpZGVhOiB3ZSBoYXZlIGV4dHJhX2RhdGEg
ZmllbGQgaW4gYml0bWFwIGxpc3QgaW4gcWNvdzIsDQp3aGljaCBtYXkgYmUgc2FmZWx5IGlnbm9y
ZWQgaWYgZXh0cmFfZGF0YV9jb21wYXRpYmxlIGlzIHNldCBmb3IgdGhpcyBiaXRtYXAuIFNvLCBp
dCBtYXkNCmJlIGEgZ29vZCByZWFzb24gdG8gaW1wbGVtZW50IGZpcnN0IHR5cGUgb2YgY29tcGF0
aWJsZSBleHRyYSBkYXRhLi4gQnV0IEkgZG9uJ3Qgc3VyZSB0aGF0DQppdCdzIHdvcnRoIGl0Lg0K
DQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=
