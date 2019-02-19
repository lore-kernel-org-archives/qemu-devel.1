Received: from eggs.gnu.org ([209.51.188.92]:42028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gw4Fl-0004AK-SH
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:12:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gw4Fl-0004Ky-2A
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:12:01 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 19 Feb 2019 12:11:51 +0000
Message-ID: <30c66aaa-2807-69cd-2395-dcd49e59b136@virtuozzo.com>
References: <20190219115937.21587-1-stefanha@redhat.com>
	<2598979f-d8b5-4324-3ca4-f87802d4a9d1@redhat.com>
In-Reply-To: <2598979f-d8b5-4324-3ca4-f87802d4a9d1@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <629FEF5409206F4FB194EECCFDEA0DD5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] iotests: drop unnecessary accel=kvm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

MTkuMDIuMjAxOSAxNTowMiwgVGhvbWFzIEh1dGggd3JvdGU6DQo+IE9uIDE5LzAyLzIwMTkgMTIu
NTksIFN0ZWZhbiBIYWpub2N6aSB3cm90ZToNCj4+IFRlc3RzIDIzNSBhbmQgMjM4IGRvIG5vdCBy
ZXF1aXJlIHRoZSBrdm0gYWNjZWxlcmF0b3IuICBUQ0cgd29ya3MgZmluZS4NCj4+DQo+PiBVc2Ug
dGhlIGRlZmF1bHQgYWNjZWxlcmF0b3IgaW5zdGVhZCBvZiByZXF1aXJpbmcga3ZtLg0KPj4NCj4+
IFN1Z2dlc3RlZC1ieTogVGhvbWFzIEh1dGggPHRodXRoQHJlZGhhdC5jb20+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+DQo+PiAtLS0NCj4+
ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzIzNSB8IDEgLQ0KPj4gICB0ZXN0cy9xZW11LWlvdGVzdHMv
MjM4IHwgMSAtDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkNCj4+DQo+PiBk
aWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzIzNSBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8y
MzUNCj4+IGluZGV4IGQ2ZWRkOTdhYjQuLjMyOWRhOGYwYzIgMTAwNzU1DQo+PiAtLS0gYS90ZXN0
cy9xZW11LWlvdGVzdHMvMjM1DQo+PiArKysgYi90ZXN0cy9xZW11LWlvdGVzdHMvMjM1DQo+PiBA
QCAtNDksNyArNDksNiBAQCBxZW11X2ltZ19jcmVhdGUoJy1mJywgaW90ZXN0cy5pbWdmbXQsICct
bycsICdwcmVhbGxvY2F0aW9uPW1ldGFkYXRhJywgZGlzaywNCj4+ICAgICAgICAgICAgICAgICAg
IHN0cihzaXplKSkNCj4+ICAgDQo+PiAgIHZtID0gUUVNVU1hY2hpbmUoaW90ZXN0cy5xZW11X3By
b2cpDQo+PiAtdm0uYWRkX2FyZ3MoJy1tYWNoaW5lJywgJ2FjY2VsPWt2bScpDQo+IA0KPiBBY2Nv
cmRpbmcgdG8gdGhlIGluaXRpYWwgY29tbWl0IGxvZyBvZiAyMzU6DQo+IA0KPiAgICJpb3Rlc3Rz
OiBzaW1wbGUgbWlycm9yIHRlc3Qgd2l0aCBrdm0gb24gMUcgaW1hZ2UiDQo+IA0KPiAuLi4gc28g
SSBhc3N1bWUgS1ZNIHdhcyB1c2VkIG9uIHB1cnBvc2UgaGVyZT8NCj4gDQo+ICAgVGhvbWFzDQo+
IA0KDQpBcyBJIHJlbWVtYmVyIGt2bSBpcyBub3QgcmVhbGx5IG5lY2Vzc2FyeSwgYW5kIHRlc3Qg
aGF2ZSBhIGNvbW1lbnQgYWJvdXQgaXQ6DQojIEFuZCBpdCBkaWRuJ3QgcmVwcm9kdWNlIGlmIGF0
IGxlYXN0IG9uZSBvZiB0aGUgZm9sbG93aW5nOg0KLi4uDQojIDMuIGRyb3Aga3ZtIGFuZCB1c2Ug
aW90ZXN0cy5WTSgpIChtYXliZSwgYmVjYXVzZSBvZiBxdGVzdCkgKGhvd2V2ZXIsIGl0IHN0aWxs
DQojICAgIHJlcHJvZHVjZXMsIGlmIGp1c3QgZHJvcCBrdm0sIGJ1dCBnZGIgZmFpbGVkIHRvIHBy
b2R1Y2UgZnVsbCBiYWNrdHJhY2VzDQojICAgIGZvciBtZSkNCg0KQnV0IHRoZSBjb21tZW50IHNo
b3VsZCBiZSB1cGRhdGVkIHdpdGggdGhpcyBwYXRjaC4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpW
bGFkaW1pcg0K
