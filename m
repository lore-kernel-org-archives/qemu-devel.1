Received: from eggs.gnu.org ([209.51.188.92]:40036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gp79R-00058E-KW
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:52:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gp79Q-0000T2-TF
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:52:45 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 31 Jan 2019 07:52:34 +0000
Message-ID: <6873a89c-125a-267c-a0b1-da6594891eb6@virtuozzo.com>
References: <1de57808-bd1d-e8a7-89b3-a08873c77346@virtuozzo.com>
	<4e3bec22-47f6-12b2-ba64-b9d310c6e0d6@redhat.com>
In-Reply-To: <4e3bec22-47f6-12b2-ba64-b9d310c6e0d6@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <D61014779D4B7541B9312C1CF1BC970D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] job_pause_point
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>

MzAuMDEuMjAxOSAyMjo1OCwgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDEvMzAvMTkg
ODo1OCBBTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEhpIQ0KPj4N
Cj4+IEkgaGF2ZSBhIHF1ZXN0aW9uIGFib3V0IGpvYl9wYXVzZV9wb2ludC4gTm93IGEgZ29vZCBq
b2Igb2YgbW92aW5nIGdlbmVyaWMgdGhpbmdzIGFib3V0DQo+PiBibG9jay1qb2JzIHRvIGpvYi5j
IGlzIGRvbmUuLg0KPj4NCj4+IGpvYl9wYXVzZV9wb2ludCBkbyB2aXNpYmxlIGpvYi1zdGF0ZSBj
aGFuZ2UsIGFzIGNoYW5naW5nIGpvYi0+c3RhdHVzIGFuZCBqb2ItPnBhdXNlZC4NCj4+DQo+PiBJ
cyBpdCBhc3N1bWVkLCB0aGF0IGpvYiBkb24ndCBkbyBhbnl0aGluZyBhZnRlciB0aGF0IHN0YXRl
IGNoYW5nZT8gSW90ZXN0cyBhcmUgd3JpdHRlbg0KPj4gZXhhY3RseSB3aXRoIHRoaXMgYXNzdW1w
dGlvbi4gT24gdGhlIG90aGVyIGhhbmQsIGNvZGUgZG9uJ3QgZ3VhcmFudGVlLCB0aGF0IGFsbCBp
bi1mbGlnaHQNCj4+IHJlcXVlc3RzIGFyZSBmaW5pc2hlZCB0byB0aGlzIHBvaW50Lg0KPj4NCj4g
DQo+IE9oLCByaWdodC4gVGhlIGpvYiBiZWluZyBwYXVzZWQgb25seSBjZXJ0aWZpZXMgdGhhdCB0
aGUgY29yb3V0aW5lDQo+IGRyaXZpbmcgdGhlIGpvYiBpc24ndCBydW5uaW5nLiBJdCBoYXMgbm8g
cmVhbCBpZGVhIGFib3V0IG1pcnJvcidzDQo+IGFzeW5jaHJvbm91cyBjaGlsZHJlbi4NCj4gDQo+
PiBNb3Jlb3Zlciwgb25seSB0aGUgam9iIGl0c2VsZiBrbm93cyBhYm91dCBpdCdzIGluLWZsaWdo
dCByZXF1ZXN0cywgdGhlcmVmb3JlIHdlIGNhbid0DQo+PiBoYW5kbGUgaXQgaW4gZ2VuZXJpYyBq
b2JfcGF1c2VfcG9pbnQoKS4gU28sIHNob3VsZCBub3Qgam9iIGRvIHNvbWV0aGluZyBsaWtlDQo+
Pg0KPj4gaWYgKGpvYl9zaG91bGRfcGF1c2UoKSkgew0KPj4gICAgICBkb24ndCBjcmVhdGUgbW9y
ZSByZXF1ZXN0cw0KPj4gICAgICB3YWl0IGFsbCBpbi1mbGlnaHQgcmVxdWVzdHMgdG8gY29tcGxl
dGUNCj4+IH0NCj4+IGpvYl9wYXVzZV9wb2ludCgpDQo+Pg0KPj4gT3IgZGlkbid0IEkgbWlzcyB0
aGVzZSB0aGluZ3MgYWxyZWFkeSBkaXNjdXNzZWQ/DQo+Pg0KPiANCj4gV2VsbCwgbWlycm9yJ3Mg
cGF1c2UgY2FsbGJhY2sgZG9lcyB0aGlzOg0KPiANCj4gc3RhdGljIHZvaWQgY29yb3V0aW5lX2Zu
IG1pcnJvcl9wYXVzZShKb2IgKmpvYikNCj4gew0KPiAgICAgIE1pcnJvckJsb2NrSm9iICpzID0g
Y29udGFpbmVyX29mKGpvYiwgTWlycm9yQmxvY2tKb2IsIGNvbW1vbi5qb2IpOw0KPiANCj4gICAg
ICBtaXJyb3Jfd2FpdF9mb3JfYWxsX2lvKHMpOw0KPiB9DQo+IA0KPiBUaGF0J3MgaW52b2tlZCBC
RUZPUkUgd2UgY2hhbmdlIG91ciBzdGF0dXMuIFRoYXQgb3VnaHQgdG8gYmUgc3VmZmljaWVudCwN
Cj4gaXMgaXQgbm90Pw0KPiANCj4gLS1qcw0KPiANCg0KT2gsIHllcywgc2VlbXMgdGhhdCBpdCBp
cyB3aGF0IEkgbWlzc2VkLCB0aGFuayB5b3UuDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGlt
aXINCg==
