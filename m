Received: from eggs.gnu.org ([209.51.188.92]:45015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gqgiZ-0001RY-JH
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 11:03:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gqgiT-0006hF-Qn
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 11:03:31 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 4 Feb 2019 16:03:22 +0000
Message-ID: <45148ff4-ea14-31ff-c298-4c8a349ad08b@virtuozzo.com>
References: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1548942405-760115-3-git-send-email-andrey.shinkevich@virtuozzo.com>
	<87pnsbxsi7.fsf@dusky.pond.sub.org>
	<3ed70b8e-f778-f942-2841-905223d3af8d@redhat.com>
	<87womjwbwj.fsf@dusky.pond.sub.org>
	<c017dbfe-f619-b626-211a-d3bdafb451aa@redhat.com>
	<877eefsnyh.fsf@dusky.pond.sub.org>
In-Reply-To: <877eefsnyh.fsf@dusky.pond.sub.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <473B9B28D27D524193BB6004EDC6FA1F@eurprd08.prod.outlook.com>
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
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "jsnow@redhat.com" <jsnow@redhat.com>

MDQuMDIuMjAxOSAxNjowNSwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+IEVyaWMgQmxha2Ug
PGVibGFrZUByZWRoYXQuY29tPiB3cml0ZXM6DQo+IA0KPj4gT24gMi8xLzE5IDE6MjMgUE0sIE1h
cmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPj4NCj4+Pj4+PiArIyBAdW5rbm93bi1mbGFnczogYW55
IHJlbWFpbmluZyBmbGFncyBub3QgcmVjb2duaXplZCBieSB0aGUgY3VycmVudCBxZW11IHZlcnNp
b24NCj4+Pj4+DQo+Pj4+PiBJbnRlbmRlZCB1c2UgY2FzZXMgZm9yIEB1bmtub3duLWZsYWdzPw0K
Pj4+Pg0KPj4+PiBUaGUgcWNvdzIgc3BlYyBkZWZpbmVzIGJpdCAyIGV4dHJhX2RhdGFfY29tcGF0
aWJsZTsgYW5kIGFsc28gbGVhdmVzIHRoZQ0KPj4+PiBkb29yIG9wZW4gZm9yIGZ1dHVyZSBleHRl
bnNpb25zIHRoYXQgbWF5IGRlZmluZSBvdGhlciBiaXRzLiBJZiBhIG5ldw0KPj4+PiB2ZXJzaW9u
IG9mIHFlbXUgKG9yIHNvbWUgbm9uLXFlbXUgcWNvdzIgY3JlYXRpb24gYXBwKSBjcmVhdGVzIGFu
IGltYWdlDQo+Pj4+IHdpdGggYWRkaXRpb25hbCBmZWF0dXJlIGJpdHMgc2V0LCBUSElTIHZlcnNp
b24gb2YgcWVtdSBkb2Vzbid0IGtub3cgd2hhdA0KPj4+PiBuYW1lIHRvIGdpdmUgdGhvc2UgYml0
cywgYnV0IGNhbiBzdGlsbCBpbmZvcm0gdGhlIHVzZXIgdGhhdCB0aG9zZSBiaXRzDQo+Pj4+IGFy
ZSBzZXQgdmlhIHRoaXMgZmllbGQuIEl0IHdpbGwgYmUgb21pdHRlZCBmb3IgYWxsIGltYWdlcyBj
cmVhdGVkIGJ5DQo+Pj4+IHRoaXMgdmVyc2lvbiBvZiBxZW11Lg0KPj4+DQo+Pj4gV2hhdCB3b3Vs
ZCBRTVAgY2xpZW50cyBkbyB3aXRoIHRoaXMgaW5mb3JtYXRpb24/DQo+Pg0KPj4gJ3FlbXUtaW1n
IGluZm8nIGlzIHRoZSBpbnRlbmRlZCBRTVAgY2xpZW50OyBhbmQgaXQgd2lsbCBwcmludCB0aGUN
Cj4+IHVua25vd24tZmxhZ3MgYWxvbmcgd2l0aCBldmVyeXRoaW5nIGVsc2UuIEluIG90aGVyIHdv
cmRzLCB3ZSdyZSB0cnlpbmcNCj4+IHRvIG1ha2UgcWVtdS1pbWcgYmVjb21lIHVzZWZ1bCBmb3Ig
aW5zcGVjdGluZyBhcyBtdWNoIHVzZWZ1bCBpbmZvcm1hdGlvbg0KPj4gYXMgcG9zc2libGUgZnJv
bSBhbiBpbWFnZSB3aXRoIHVua25vd24gb3JpZ2lucy4gIEtub3dpbmcgdGhhdCBhbiBpbWFnZQ0K
Pj4gdXNlcyBiaXRtYXBzIHdpdGggZmxhZ3MgdW5rbm93biB0byBUSElTIHZlcnNpb24gb2YgcWVt
dSBpcyBhIGdvb2QNCj4+IGluZGljYXRpb24gdGhhdCB5b3Ugc2hvdWxkIGJlIGNhcmVmdWwgYWJv
dXQgdXNpbmcvYWx0ZXJpbmcgdGhlIGltYWdlDQo+PiB3aXRob3V0IGZpcnN0IHVwZ3JhZGluZyBx
ZW11LCBhcyBpdCBtYXkgZGVzdHJveSBkYXRhIHRoYXQgc29tZSBvdGhlcg0KPj4gcHJvZHVjdCBk
ZXNpcmVzIHRvIHV0aWxpemUuDQo+IA0KPiBPa2F5LiAgTm93IHdvcmsgdGhhdCBpbnRvIHRoZSBk
b2N1bWVudGF0aW9uIDopDQo+IA0KDQpJJ2xsIHRyeToNCg0KQHVua25vd24tZmxhZ3M6IGFueSBm
bGFncyBleGNlcHQgJ2luLXVzZScgYW5kICdhdXRvJyBzZXQgZm9yIHRoZSBiaXRtYXAuDQogICAg
ICAgICAgICAgICAgIFByZXNlbmNlIG9mIG5vbi16ZXJvIEB1bmtub3duLWZsYWdzIGRlZmluaXRl
bHkgc2hvd3MgdGhhdA0KICAgICAgICAgICAgICAgICBpbWFnZSB3YXMgY3JlYXRlZCBieSBuZXdl
ciB2ZXJzaW9uIG9mIHNvZnR3YXJlICh3aGljaA0KICAgICAgICAgICAgICAgICBzdXBwb3J0cyBt
b3JlIGJpdG1hcCBmbGFncykgb3IgY29ycnVwdGVkLiBJbWFnZSBjYW4ndCBiZQ0KICAgICAgICAg
ICAgICAgICB1c2VkIGZvciByLXcgd2l0aCBub24temVybyBAdW5rbm93bi1mbGFncyBpbiBhbnkg
Yml0bWFwLg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==
