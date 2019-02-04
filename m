Received: from eggs.gnu.org ([209.51.188.92]:55444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gqhDC-0000SO-6K
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 11:35:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gqhDB-0001wg-8b
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 11:35:10 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 4 Feb 2019 16:35:03 +0000
Message-ID: <bed5c588-b41b-bb93-92a8-e1ffc6f4fac7@virtuozzo.com>
References: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1548942405-760115-3-git-send-email-andrey.shinkevich@virtuozzo.com>
	<87pnsbxsi7.fsf@dusky.pond.sub.org>
	<3ed70b8e-f778-f942-2841-905223d3af8d@redhat.com>
	<87womjwbwj.fsf@dusky.pond.sub.org>
	<c017dbfe-f619-b626-211a-d3bdafb451aa@redhat.com>
	<877eefsnyh.fsf@dusky.pond.sub.org>
	<45148ff4-ea14-31ff-c298-4c8a349ad08b@virtuozzo.com>
	<8db32102-7daa-6b5a-8752-46727cbef106@redhat.com>
In-Reply-To: <8db32102-7daa-6b5a-8752-46727cbef106@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB16CA356096B54CACE66F035FCB56F5@eurprd08.prod.outlook.com>
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

MDQuMDIuMjAxOSAxOToyNCwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gMi80LzE5IDEwOjAzIEFN
LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPiANCj4+Pj4+IFdoYXQgd291
bGQgUU1QIGNsaWVudHMgZG8gd2l0aCB0aGlzIGluZm9ybWF0aW9uPw0KPj4+Pg0KPj4+PiAncWVt
dS1pbWcgaW5mbycgaXMgdGhlIGludGVuZGVkIFFNUCBjbGllbnQ7IGFuZCBpdCB3aWxsIHByaW50
IHRoZQ0KPj4+PiB1bmtub3duLWZsYWdzIGFsb25nIHdpdGggZXZlcnl0aGluZyBlbHNlLiBJbiBv
dGhlciB3b3Jkcywgd2UncmUgdHJ5aW5nDQo+Pj4+IHRvIG1ha2UgcWVtdS1pbWcgYmVjb21lIHVz
ZWZ1bCBmb3IgaW5zcGVjdGluZyBhcyBtdWNoIHVzZWZ1bCBpbmZvcm1hdGlvbg0KPj4+PiBhcyBw
b3NzaWJsZSBmcm9tIGFuIGltYWdlIHdpdGggdW5rbm93biBvcmlnaW5zLiAgS25vd2luZyB0aGF0
IGFuIGltYWdlDQo+Pj4+IHVzZXMgYml0bWFwcyB3aXRoIGZsYWdzIHVua25vd24gdG8gVEhJUyB2
ZXJzaW9uIG9mIHFlbXUgaXMgYSBnb29kDQo+Pj4+IGluZGljYXRpb24gdGhhdCB5b3Ugc2hvdWxk
IGJlIGNhcmVmdWwgYWJvdXQgdXNpbmcvYWx0ZXJpbmcgdGhlIGltYWdlDQo+Pj4+IHdpdGhvdXQg
Zmlyc3QgdXBncmFkaW5nIHFlbXUsIGFzIGl0IG1heSBkZXN0cm95IGRhdGEgdGhhdCBzb21lIG90
aGVyDQo+Pj4+IHByb2R1Y3QgZGVzaXJlcyB0byB1dGlsaXplLg0KPj4+DQo+Pj4gT2theS4gIE5v
dyB3b3JrIHRoYXQgaW50byB0aGUgZG9jdW1lbnRhdGlvbiA6KQ0KPj4+DQo+Pg0KPj4gSSdsbCB0
cnk6DQo+Pg0KPj4gQHVua25vd24tZmxhZ3M6IGFueSBmbGFncyBleGNlcHQgJ2luLXVzZScgYW5k
ICdhdXRvJyBzZXQgZm9yIHRoZSBiaXRtYXAuDQo+PiAgICAgICAgICAgICAgICAgICBQcmVzZW5j
ZSBvZiBub24temVybyBAdW5rbm93bi1mbGFncyBkZWZpbml0ZWx5IHNob3dzIHRoYXQNCj4+ICAg
ICAgICAgICAgICAgICAgIGltYWdlIHdhcyBjcmVhdGVkIGJ5IG5ld2VyIHZlcnNpb24gb2Ygc29m
dHdhcmUgKHdoaWNoDQo+PiAgICAgICAgICAgICAgICAgICBzdXBwb3J0cyBtb3JlIGJpdG1hcCBm
bGFncykgb3IgY29ycnVwdGVkLiBJbWFnZSBjYW4ndCBiZQ0KPj4gICAgICAgICAgICAgICAgICAg
dXNlZCBmb3Igci13IHdpdGggbm9uLXplcm8gQHVua25vd24tZmxhZ3MgaW4gYW55IGJpdG1hcC4N
Cj4gDQo+IFRoZSBncmFtbWFyIHN0aWxsIGZlZWxzIGF3a3dhcmQuICBNYXliZToNCj4gDQo+IEB1
bmtub3duLWZsYWdzOiBJZiBwcmVzZW50LCB0aGlzIGlzIHRoZSB2YWx1ZSBvZiBhZGRpdGlvbmFs
IGJpdG1hcCBmbGFncw0KPiB0aGF0IHdlcmUgc2V0IGluIHRoZSBpbWFnZSBidXQgbm90IHJlcG9y
dGVkIGluIEBmbGFncywgaW1wbHlpbmcgdGhhdCB0aGUNCj4gaW1hZ2Ugd2FzIGNyZWF0ZWQgd2l0
aCBhIG5ld2VyIHZlcnNpb24gb2Ygc29mdHdhcmUgKHRoYXQgc3VwcG9ydHMgbmV3DQo+IGZsYWdz
KSBvciBoYXMgYmVlbiBjb3JydXB0ZWQuIE1vZGlmeWluZyB0aGUgaW1hZ2Ugd2l0aG91dCB1cGdy
YWRpbmcgcWVtdQ0KPiBmaXJzdCB3aWxsIGxpa2VseSBicmVhayB0aGUgY29udGVudHMgb2YgdGhl
IGJpdG1hcC4NCj4gDQoNClRoYW5rIHlvdSENCg0KT29wcywgaG0sIEkgbm93IGRvdWJ0LCBob3cg
QW5kcmV5J3MgcGF0Y2hlcyB3b3JrLCBpZiBiaXRtYXBfbGlzdF9sb2FkIGZ1bmN0aW9uDQpmYWls
cyB3aGVuIHVua25vd24gZmxhZ3MgYXJlIGZvdW5kLiBTbywgY2FuIHdlIHJlYWxseSBzaG93IHVu
a25vd24tZmxhZ3MsDQpvciB3ZSdsbCBmYWlsIGlmIHRoZXJlIGFueT8NCg0KQW5kIGlmIHdlIGZh
aWwgKEkgaG9wZSB3ZSBmYWlsKSBvbiB1bmtub3duIGZsYWdzLCB0aGFuIHdlIGRvbid0IG5lZWQg
dGhpcw0KZmllbGQgOikuDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==
