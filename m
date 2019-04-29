Received: from eggs.gnu.org ([209.51.188.92]:36681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hL2QH-0001vx-Lh
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:18:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hL2QG-0000Qg-P7
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:18:05 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 29 Apr 2019 09:17:56 +0000
Message-ID: <5746f6e2-c6bc-23a4-686f-b6943fedbe2c@virtuozzo.com>
References: <20190426221528.30293-1-jsnow@redhat.com>
	<20190426221528.30293-2-jsnow@redhat.com>
In-Reply-To: <20190426221528.30293-2-jsnow@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <57C41FCC8C1BFB45B92A870F86DACE22@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 1/2] Makefile: add nit-picky mode to
 sphinx-build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kchamart@redhat.com" <kchamart@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "aliang@redhat.com" <aliang@redhat.com>, "nsoffer@redhat.com" <nsoffer@redhat.com>, Fam Zheng <fam@euphon.net>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, "eblake@redhat.com" <eblake@redhat.com>

MjcuMDQuMjAxOSAxOjE1LCBKb2huIFNub3cgd3JvdGU6DQo+IElmIHdlIGFkZCByZWZlcmVuY2Vz
IHRoYXQgZG9uJ3QgcmVzb2x2ZSAob3IgYWNjaWRlbnRhbGx5IHJlbW92ZSB0aGVtKSwNCj4gaXQg
d2lsbCBiZSBoZWxwZnVsIHRvIGhhdmUgYW4gZXJyb3IgbWVzc2FnZSBhbGVydGluZyB1cyB0byB0
aGF0Lg0KDQp0aGUgd29yZGluZyBzdGlsbCBhIGJpdCBpbiBjb25mbGljdCB3aXRoIHRoZSBmYWN0
IHRoYXQgLW4gaXMgb3JpZ2luYWxseSBhIHdhcm5pbmcsIG5vdCBlcnJvciwNCmJ1dCBJIGRvbid0
IHJlYWxseSBjYXJlOg0KDQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tp
eSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQo+IA0KPiBUdXJuIHdhcm5pbmdzIGludG8g
ZXJyb3JzIHNvIHdlIGNhbiBiZSBhbGVydGVkIHRvIHByb2JsZW1zIGluIGJ1aWxkaW5nDQo+IHRo
ZSBkb2N1bWVudGF0aW9uIHdoZW4gdGhleSBhcmlzZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpv
aG4gU25vdyA8anNub3dAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICAgTWFrZWZpbGUgfCAyICstDQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvTWFrZWZpbGUgYi9NYWtlZmlsZQ0KPiBpbmRleCA2MjZhMDRkMzA1Li4xMjEx
ZTc4YzkxIDEwMDY0NA0KPiAtLS0gYS9NYWtlZmlsZQ0KPiArKysgYi9NYWtlZmlsZQ0KPiBAQCAt
OTI2LDcgKzkyNiw3IEBAIGRvY3MvdmVyc2lvbi50ZXhpOiAkKFNSQ19QQVRIKS9WRVJTSU9ODQo+
ICAgc3BoaW54ZG9jczogJChNQU5VQUxfQlVJTERESVIpL2RldmVsL2luZGV4Lmh0bWwgJChNQU5V
QUxfQlVJTERESVIpL2ludGVyb3AvaW5kZXguaHRtbA0KPiAgIA0KPiAgICMgQ2FubmVkIGNvbW1h
bmQgdG8gYnVpbGQgYSBzaW5nbGUgbWFudWFsDQo+IC1idWlsZC1tYW51YWwgPSAkKGNhbGwgcXVp
ZXQtY29tbWFuZCxzcGhpbngtYnVpbGQgJChpZiAkKFYpLCwtcSkgLWIgaHRtbCAtRCB2ZXJzaW9u
PSQoVkVSU0lPTikgLUQgcmVsZWFzZT0iJChGVUxMX1ZFUlNJT04pIiAtZCAuZG9jdHJlZXMvJDEg
JChTUkNfUEFUSCkvZG9jcy8kMSAkKE1BTlVBTF9CVUlMRERJUikvJDEgLCJTUEhJTlgiLCIkKE1B
TlVBTF9CVUlMRERJUikvJDEiKQ0KPiArYnVpbGQtbWFudWFsID0gJChjYWxsIHF1aWV0LWNvbW1h
bmQsc3BoaW54LWJ1aWxkICQoaWYgJChWKSwsLXEpIC1XIC1uIC1iIGh0bWwgLUQgdmVyc2lvbj0k
KFZFUlNJT04pIC1EIHJlbGVhc2U9IiQoRlVMTF9WRVJTSU9OKSIgLWQgLmRvY3RyZWVzLyQxICQo
U1JDX1BBVEgpL2RvY3MvJDEgJChNQU5VQUxfQlVJTERESVIpLyQxICwiU1BISU5YIiwiJChNQU5V
QUxfQlVJTERESVIpLyQxIikNCj4gICAjIFdlIGFzc3VtZSBhbGwgUlNUIGZpbGVzIGluIHRoZSBt
YW51YWwncyBkaXJlY3RvcnkgYXJlIHVzZWQgaW4gaXQNCj4gICBtYW51YWwtZGVwcyA9ICQod2ls
ZGNhcmQgJChTUkNfUEFUSCkvZG9jcy8kMS8qLnJzdCkgJChTUkNfUEFUSCkvZG9jcy8kMS9jb25m
LnB5ICQoU1JDX1BBVEgpL2RvY3MvY29uZi5weQ0KPiAgIA0KPiANCg0KDQotLSANCkJlc3QgcmVn
YXJkcywNClZsYWRpbWlyDQo=
