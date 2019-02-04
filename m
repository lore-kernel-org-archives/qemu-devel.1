Received: from eggs.gnu.org ([209.51.188.92]:59391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gqhOd-0005pR-Bo
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 11:47:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gqhOc-0001JF-5H
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 11:46:59 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 4 Feb 2019 16:46:49 +0000
Message-ID: <175fb7e8-eec3-8031-55c9-b859ce8f6af0@virtuozzo.com>
References: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1548942405-760115-3-git-send-email-andrey.shinkevich@virtuozzo.com>
	<87pnsbxsi7.fsf@dusky.pond.sub.org>
	<3ed70b8e-f778-f942-2841-905223d3af8d@redhat.com>
	<87womjwbwj.fsf@dusky.pond.sub.org>
	<c017dbfe-f619-b626-211a-d3bdafb451aa@redhat.com>
	<877eefsnyh.fsf@dusky.pond.sub.org>
	<45148ff4-ea14-31ff-c298-4c8a349ad08b@virtuozzo.com>
	<8db32102-7daa-6b5a-8752-46727cbef106@redhat.com>
	<bed5c588-b41b-bb93-92a8-e1ffc6f4fac7@virtuozzo.com>
In-Reply-To: <bed5c588-b41b-bb93-92a8-e1ffc6f4fac7@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E3148DB55631D44B1CF283B9CCDB8CC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v11 2/3] qemu-img info lists bitmap
 directory entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "jsnow@redhat.com" <jsnow@redhat.com>

MDQuMDIuMjAxOSAxOTozNSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MDQuMDIuMjAxOSAxOToyNCwgRXJpYyBCbGFrZSB3cm90ZToNCj4+IE9uIDIvNC8xOSAxMDowMyBB
TSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+DQo+Pj4+Pj4gV2hhdCB3
b3VsZCBRTVAgY2xpZW50cyBkbyB3aXRoIHRoaXMgaW5mb3JtYXRpb24/DQo+Pj4+Pg0KPj4+Pj4g
J3FlbXUtaW1nIGluZm8nIGlzIHRoZSBpbnRlbmRlZCBRTVAgY2xpZW50OyBhbmQgaXQgd2lsbCBw
cmludCB0aGUNCj4+Pj4+IHVua25vd24tZmxhZ3MgYWxvbmcgd2l0aCBldmVyeXRoaW5nIGVsc2Uu
IEluIG90aGVyIHdvcmRzLCB3ZSdyZSB0cnlpbmcNCj4+Pj4+IHRvIG1ha2UgcWVtdS1pbWcgYmVj
b21lIHVzZWZ1bCBmb3IgaW5zcGVjdGluZyBhcyBtdWNoIHVzZWZ1bCBpbmZvcm1hdGlvbg0KPj4+
Pj4gYXMgcG9zc2libGUgZnJvbSBhbiBpbWFnZSB3aXRoIHVua25vd24gb3JpZ2lucy7CoCBLbm93
aW5nIHRoYXQgYW4gaW1hZ2UNCj4+Pj4+IHVzZXMgYml0bWFwcyB3aXRoIGZsYWdzIHVua25vd24g
dG8gVEhJUyB2ZXJzaW9uIG9mIHFlbXUgaXMgYSBnb29kDQo+Pj4+PiBpbmRpY2F0aW9uIHRoYXQg
eW91IHNob3VsZCBiZSBjYXJlZnVsIGFib3V0IHVzaW5nL2FsdGVyaW5nIHRoZSBpbWFnZQ0KPj4+
Pj4gd2l0aG91dCBmaXJzdCB1cGdyYWRpbmcgcWVtdSwgYXMgaXQgbWF5IGRlc3Ryb3kgZGF0YSB0
aGF0IHNvbWUgb3RoZXINCj4+Pj4+IHByb2R1Y3QgZGVzaXJlcyB0byB1dGlsaXplLg0KPj4+Pg0K
Pj4+PiBPa2F5LsKgIE5vdyB3b3JrIHRoYXQgaW50byB0aGUgZG9jdW1lbnRhdGlvbiA6KQ0KPj4+
Pg0KPj4+DQo+Pj4gSSdsbCB0cnk6DQo+Pj4NCj4+PiBAdW5rbm93bi1mbGFnczogYW55IGZsYWdz
IGV4Y2VwdCAnaW4tdXNlJyBhbmQgJ2F1dG8nIHNldCBmb3IgdGhlIGJpdG1hcC4NCj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFByZXNlbmNlIG9mIG5vbi16ZXJvIEB1bmtu
b3duLWZsYWdzIGRlZmluaXRlbHkgc2hvd3MgdGhhdA0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgaW1hZ2Ugd2FzIGNyZWF0ZWQgYnkgbmV3ZXIgdmVyc2lvbiBvZiBzb2Z0
d2FyZSAod2hpY2gNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN1cHBv
cnRzIG1vcmUgYml0bWFwIGZsYWdzKSBvciBjb3JydXB0ZWQuIEltYWdlIGNhbid0IGJlDQo+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1c2VkIGZvciByLXcgd2l0aCBub24t
emVybyBAdW5rbm93bi1mbGFncyBpbiBhbnkgYml0bWFwLg0KPj4NCj4+IFRoZSBncmFtbWFyIHN0
aWxsIGZlZWxzIGF3a3dhcmQuwqAgTWF5YmU6DQo+Pg0KPj4gQHVua25vd24tZmxhZ3M6IElmIHBy
ZXNlbnQsIHRoaXMgaXMgdGhlIHZhbHVlIG9mIGFkZGl0aW9uYWwgYml0bWFwIGZsYWdzDQo+PiB0
aGF0IHdlcmUgc2V0IGluIHRoZSBpbWFnZSBidXQgbm90IHJlcG9ydGVkIGluIEBmbGFncywgaW1w
bHlpbmcgdGhhdCB0aGUNCj4+IGltYWdlIHdhcyBjcmVhdGVkIHdpdGggYSBuZXdlciB2ZXJzaW9u
IG9mIHNvZnR3YXJlICh0aGF0IHN1cHBvcnRzIG5ldw0KPj4gZmxhZ3MpIG9yIGhhcyBiZWVuIGNv
cnJ1cHRlZC4gTW9kaWZ5aW5nIHRoZSBpbWFnZSB3aXRob3V0IHVwZ3JhZGluZyBxZW11DQo+PiBm
aXJzdCB3aWxsIGxpa2VseSBicmVhayB0aGUgY29udGVudHMgb2YgdGhlIGJpdG1hcC4NCj4+DQo+
IA0KPiBUaGFuayB5b3UhDQo+IA0KPiBPb3BzLCBobSwgSSBub3cgZG91YnQsIGhvdyBBbmRyZXkn
cyBwYXRjaGVzIHdvcmssIGlmIGJpdG1hcF9saXN0X2xvYWQgZnVuY3Rpb24NCj4gZmFpbHMgd2hl
biB1bmtub3duIGZsYWdzIGFyZSBmb3VuZC4gU28sIGNhbiB3ZSByZWFsbHkgc2hvdyB1bmtub3du
LWZsYWdzLA0KPiBvciB3ZSdsbCBmYWlsIGlmIHRoZXJlIGFueT8NCj4gDQo+IEFuZCBpZiB3ZSBm
YWlsIChJIGhvcGUgd2UgZmFpbCkgb24gdW5rbm93biBmbGFncywgdGhhbiB3ZSBkb24ndCBuZWVk
IHRoaXMNCj4gZmllbGQgOikuDQo+IA0KDQpCdXQgd2UgY2FuIHVwZGF0ZSBiaXRtYXBfbGlzdF9s
b2FkLCB0byBoYXZlIGEgZmxhZywgYW5kIHNob3cgYml0bWFwcyB3aXRoDQp1bmtub3duIGZsYWdz
IGluIHFlbXUtaW1nIGluZm8uLiBBbmQgd2UgaGF2ZSB0byBzb21laG93IG5vdCBmYWlsIG9uIG9w
ZW4gYmVmb3JlDQppdC4gSSdtIHZlcnkgc29ycnkgdGhhdCBJIHVuZGVyc3RhbmQgaXQgYWxsIG9u
bHkgbm93IDooLg0KDQpTbywgZG8gd2UgcmVhbGx5IG5lZWQgdW5rbm93bi1mbGFncyBmaWVsZD8g
SWYgeWVzLCBtYXkgYmUsIGRvIGl0IGFzIGEgbmV4dCBzdGVwPw0KQW5kIHByb2NlZWQgbm93IHdp
dGhvdXQgdGhlbT8NCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=
