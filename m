Received: from eggs.gnu.org ([209.51.188.92]:38070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1grKPu-0004cu-Oi
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:26:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1grKPt-0007T5-GC
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:26:54 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Wed, 6 Feb 2019 10:26:31 +0000
Message-ID: <279354c8-08a9-c3e8-96ef-cbbfb66c4872@virtuozzo.com>
References: <1549397675-189741-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1549397675-189741-4-git-send-email-andrey.shinkevich@virtuozzo.com>
	<9dc9efac-ef70-062f-4668-7ee57bab8026@virtuozzo.com>
In-Reply-To: <9dc9efac-ef70-062f-4668-7ee57bab8026@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A628DBD53B513409DBBA79A8E08AE30@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v12 3/3] qcow2: list of bitmaps new test 242
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>

DQoNCk9uIDA2LzAyLzIwMTkgMTA6NDIsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3Jv
dGU6DQo+IDA1LjAyLjIwMTkgMjM6MTQsIEFuZHJleSBTaGlua2V2aWNoIHdyb3RlOg0KPj4gQSBu
ZXcgdGVzdCBmaWxlIDI0MiBhZGRlZCB0byB0aGUgcWVtdS1pb3Rlc3RzIHNldC4gSXQgY2hlY2tz
DQo+PiB0aGUgZm9ybWF0IG9mIHFjb3cyIHNwZWNpZmljIGluZm9ybWF0aW9uIGZvciB0aGUgbmV3
IGFkZGVkDQo+PiBzZWN0aW9uIHRoYXQgbGlzdHMgZGV0YWlscyBvZiBiaXRtYXBzLg0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBTaGlua2V2aWNoIDxhbmRyZXkuc2hpbmtldmljaEB2aXJ0
dW96em8uY29tPg0KPj4gLS0tDQo+PiAgICB0ZXN0cy9xZW11LWlvdGVzdHMvMjQyICAgICB8IDEw
MCArKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAgIHRlc3RzL3FlbXUtaW90ZXN0cy8y
NDIub3V0IHwgMTY3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPj4gICAgdGVzdHMvcWVtdS1pb3Rlc3RzL2dyb3VwICAgfCAgIDEgKw0KPj4gICAgMyBmaWxl
cyBjaGFuZ2VkLCAyNjggaW5zZXJ0aW9ucygrKQ0KPj4gICAgY3JlYXRlIG1vZGUgMTAwNzU1IHRl
c3RzL3FlbXUtaW90ZXN0cy8yNDINCj4+ICAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9xZW11
LWlvdGVzdHMvMjQyLm91dA0KPj4NCj4+IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlvdGVzdHMv
MjQyIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzI0Mg0KPj4gbmV3IGZpbGUgbW9kZSAxMDA3NTUNCj4+
IGluZGV4IDAwMDAwMDAuLjk1YzFmMTgNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL3Rlc3Rz
L3FlbXUtaW90ZXN0cy8yNDINCj4gDQo+IFsuLl0NCj4gDQo+PiArDQo+PiArZGVmIHRvZ2dsZV9m
bGFnKG9mZnNldCk6DQo+PiArICAgIGYgPSBvcGVuKGRpc2ssICJyK2IiKQ0KPj4gKyAgICBmLnNl
ZWsob2Zmc2V0LCAwKQ0KPj4gKyAgICBjID0gZi5yZWFkKDEpDQo+PiArICAgIHRvZ2dsZWQgPSBj
aHIob3JkKGMpIF4gYml0bWFwX2ZsYWdfdW5rbm93bikNCj4+ICsgICAgZi5zZWVrKC0xLCAxKQ0K
Pj4gKyAgICBmLndyaXRlKHRvZ2dsZWQpDQo+PiArICAgIGYuY2xvc2UoKQ0KPiANCj4gb2ssIGJ1
dCBiZXR0ZXIgdXNlICJ3aXRoIiwgbGlrZQ0KPiB3aXRoIG9wZW4oZGlzaywgInIrYiIpIGFzIGY6
DQo+ICAgICAgLi4uDQo+IA0KPiBhcyBmaWxlIHdpbGwgYmUgY2xvc2VkIG9uIGFueSBleGNlcHRp
b24NCj4gDQo+IA0KPiBXaXRoIG9yIHdpdGhvdXQgdGhhdCBmaXhlZDoNCj4gUmV2aWV3ZWQtYnk6
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4N
Cj4gDQo+IA0KDQpEZWFyIFZsYWRpbWlyLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgaGFyZCB3b3Jr
IG9mIHRoZSByZXZpZXdlciwgdGhlIGdyZWF0IHBhdGllbmNlDQphbmQgdGhlIHNwZWNpYWwgY2Fy
ZSBhYm91dCB0aGlzIHNlcmllcy4NCi0tIA0KV2l0aCB0aGUgYmVzdCByZWdhcmRzLA0KQW5kcmV5
IFNoaW5rZXZpY2gNCg==
