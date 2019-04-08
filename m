Received: from eggs.gnu.org ([209.51.188.92]:47861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDWQr-00054N-Cp
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDWQq-00060L-Bf
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:43:37 -0400
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Mon, 8 Apr 2019 15:43:26 +0000
Message-ID: <b3c0f4bb-c606-0628-ea42-4703a2130991@virtuozzo.com>
References: <1554483379-682051-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554483379-682051-4-git-send-email-andrey.shinkevich@virtuozzo.com>
	<w511s2cy08l.fsf@maestria.local.igalia.com>
In-Reply-To: <w511s2cy08l.fsf@maestria.local.igalia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <75DCF3C212AAB845890A99784C37DFE8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 3/3] block/stream: introduce a bottom
 node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, Denis Lunev <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

DQoNCk9uIDA4LzA0LzIwMTkgMTg6MzksIEFsYmVydG8gR2FyY2lhIHdyb3RlOg0KPiBPbiBGcmkg
MDUgQXByIDIwMTkgMDY6NTY6MTkgUE0gQ0VTVCwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+
PiBAQCAtMjMyLDggKzIzMiwxMyBAQCB2b2lkIHN0cmVhbV9zdGFydChjb25zdCBjaGFyICpqb2Jf
aWQsIEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KPj4gICAgICAgU3RyZWFtQmxvY2tKb2IgKnM7DQo+
PiAgICAgICBCbG9ja0RyaXZlclN0YXRlICppdGVyOw0KPj4gICAgICAgYm9vbCBic19yZWFkX29u
bHk7DQo+PiArICAgIEJsb2NrRHJpdmVyU3RhdGUgKmJvdHRvbSA9IE5VTEw7DQo+PiArICAgIGlu
dCBiYXNpY19mbGFncyA9IEJMS19QRVJNX0NPTlNJU1RFTlRfUkVBRCB8IEJMS19QRVJNX1dSSVRF
X1VOQ0hBTkdFRDsNCj4+ICsNCj4+ICsgICAgLyogRmluZCB0aGUgYm90dG9tIG5vZGUgdGhhdCBo
YXMgdGhlIGJhc2UgYXMgaXRzIGJhY2tpbmcgaW1hZ2UgKi8NCj4+ICsgICAgYm90dG9tID0gYmRy
dl9maW5kX292ZXJsYXkoYnMsIGJhc2UpOw0KPiANCj4gV2hhdCBoYXBwZW5zIGlmIGJzID09IGJh
c2UgaGVyZSA/Pw0KPiANCj4+ICsgICAgLyoNCj4+ICsgICAgICogQmxvY2sgYWxsIGludGVybWVk
aWF0ZSBub2RlcyBiZXR3ZWVuIGJzIGFuZCBib3R0b20gKGluY2x1c2l2ZSksIGJlY2F1c2UNCj4+
ICsgICAgICogdGhleSB3aWxsIGRpc2FwcGVhciBmcm9tIHRoZSBjaGFpbiBhZnRlciB0aGlzIG9w
ZXJhdGlvbi4gVGhlIHN0cmVhbWluZw0KPj4gKyAgICAgKiBqb2IgcmVhZHMgZXZlcnkgYmxvY2sg
b25seSBvbmNlLCBhc3N1bWluZyB0aGF0IGl0IGRvZXNuJ3QgY2hhbmdlLCBzbw0KPj4gKyAgICAg
KiBmb3JiaWQgd3JpdGVzIGFuZCByZXNpemVzLg0KPj4gKyAgICAgKi8NCj4+ICsgICAgZm9yIChp
dGVyID0gYnM7IGl0ZXIgIT0gYm90dG9tOyBpdGVyID0gYmFja2luZ19icyhpdGVyKSkgew0KPj4g
KyAgICAgICAgYmxvY2tfam9iX2FkZF9iZHJ2KCZzLT5jb21tb24sICJpbnRlcm1lZGlhdGUgbm9k
ZSIsIGJhY2tpbmdfYnMoaXRlciksDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgMCwg
YmFzaWNfZmxhZ3MsICZlcnJvcl9hYm9ydCk7DQo+PiAgICAgICB9DQo+IA0KPiBUaGlzIHN0b3Bz
IHdoZW4gaXRlciA9PSBib3R0b20sIHNvIGJvdHRvbSBpcyBub3QgYWN0dWFsbHkgYmxvY2tlZC4N
Cj4gDQo+PiBkaWZmIC0tZ2l0IGEvYmxvY2svdHJhY2UtZXZlbnRzIGIvYmxvY2svdHJhY2UtZXZl
bnRzDQo+PiBpbmRleCA3MzM1YTQyLi41MzY2ZDQ1IDEwMDY0NA0KPj4gLS0tIGEvYmxvY2svdHJh
Y2UtZXZlbnRzDQo+PiArKysgYi9ibG9jay90cmFjZS1ldmVudHMNCj4+IEBAIC0yMCw3ICsyMCw3
IEBAIGJkcnZfY29fY29weV9yYW5nZV90byh2b2lkICpzcmMsIHVpbnQ2NF90IHNyY19vZmZzZXQs
IHZvaWQgKmRzdCwgdWludDY0X3QgZHN0X29mDQo+PiAgIA0KPj4gICAjIHN0cmVhbS5jDQo+PiAg
IHN0cmVhbV9vbmVfaXRlcmF0aW9uKHZvaWQgKnMsIGludDY0X3Qgb2Zmc2V0LCB1aW50NjRfdCBi
eXRlcywgaW50IGlzX2FsbG9jYXRlZCkgInMgJXAgb2Zmc2V0ICUiIFBSSWQ2NCAiIGJ5dGVzICUi
IFBSSXU2NCAiIGlzX2FsbG9jYXRlZCAlZCINCj4+IC1zdHJlYW1fc3RhcnQodm9pZCAqYnMsIHZv
aWQgKmJhc2UsIHZvaWQgKnMpICJicyAlcCBiYXNlICVwIHMgJXAiDQo+PiArc3RyZWFtX3N0YXJ0
KHZvaWQgKmJzLCB2b2lkICpib3R0b20sIHZvaWQgKnMpICJicyAlcCBib3R0b20gJXAgcyAlcCIN
Cj4gDQo+IElzIHRoaXMgY2hhbmdlIHN0aWxsIGNvcnJlY3Q/IFdlIGRvbid0IHBhc3MgYm90dG9t
IGFueW1vcmUuDQo+IA0KPiBCZXJ0bw0KPiANCg0KWWVzLCBJIHdpbGwgcm9sbCBJdCBiYWNrLg0K
LS0gDQpXaXRoIHRoZSBiZXN0IHJlZ2FyZHMsDQpBbmRyZXkgU2hpbmtldmljaA0K
