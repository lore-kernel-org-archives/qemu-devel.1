Received: from eggs.gnu.org ([209.51.188.92]:40672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIzlj-0003qk-BE
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:03:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIzlh-0001CY-91
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:03:47 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 23 Apr 2019 18:03:36 +0000
Message-ID: <eaa73eb3-a84f-a263-13b2-e25588f00fd7@virtuozzo.com>
References: <20190422221714.7630-1-jsnow@redhat.com>
	<20190422221714.7630-2-jsnow@redhat.com>
In-Reply-To: <20190422221714.7630-2-jsnow@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <901CD8BD2C0B1143BCDE519EE0ED55E7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 1/2] Makefile: add nit-picky mode to
 sphinx-build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aliang@redhat.com" <aliang@redhat.com>, "kchamart@redhat.com" <kchamart@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Fam Zheng <fam@euphon.net>, "nsoffer@redhat.com" <nsoffer@redhat.com>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, "armbru@redhat.com" <armbru@redhat.com>

MjMuMDQuMjAxOSAxOjE3LCBKb2huIFNub3cgd3JvdGU6DQo+IElmIHdlIGFkZCByZWZlcmVuY2Vz
IHRoYXQgZG9uJ3QgcmVzb2x2ZSAob3IgYWNjaWRlbnRhbGx5IHJlbW92ZSB0aGVtKSwNCj4gaXQg
d2lsbCBiZSBoZWxwZnVsIHRvIGhhdmUgYW4gZXJyb3IgbWVzc2FnZSBhbGVydGluZyB1cyB0byB0
aGF0Lg0KDQphY2NvcmRpbmdseSB0byBkb2NzIEkndmUgZm91bmQsIG5vdCBlcnJvciBidXQgd2Fy
bmluZy4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSm9obiBTbm93IDxqc25vd0ByZWRoYXQuY29t
Pg0KDQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNv
dkB2aXJ0dW96em8uY29tPg0KDQo+IC0tLQ0KPiAgIE1ha2VmaWxlIHwgMiArLQ0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL01ha2VmaWxlIGIvTWFrZWZpbGUNCj4gaW5kZXggMDRhMGQ0NTA1MC4uZmY5Y2UyZWQ0YyAx
MDA2NDQNCj4gLS0tIGEvTWFrZWZpbGUNCj4gKysrIGIvTWFrZWZpbGUNCj4gQEAgLTg5OSw3ICs4
OTksNyBAQCBkb2NzL3ZlcnNpb24udGV4aTogJChTUkNfUEFUSCkvVkVSU0lPTg0KPiAgIHNwaGlu
eGRvY3M6ICQoTUFOVUFMX0JVSUxERElSKS9kZXZlbC9pbmRleC5odG1sICQoTUFOVUFMX0JVSUxE
RElSKS9pbnRlcm9wL2luZGV4Lmh0bWwNCj4gICANCj4gICAjIENhbm5lZCBjb21tYW5kIHRvIGJ1
aWxkIGEgc2luZ2xlIG1hbnVhbA0KPiAtYnVpbGQtbWFudWFsID0gJChjYWxsIHF1aWV0LWNvbW1h
bmQsc3BoaW54LWJ1aWxkICQoaWYgJChWKSwsLXEpIC1iIGh0bWwgLUQgdmVyc2lvbj0kKFZFUlNJ
T04pIC1EIHJlbGVhc2U9IiQoRlVMTF9WRVJTSU9OKSIgLWQgLmRvY3RyZWVzLyQxICQoU1JDX1BB
VEgpL2RvY3MvJDEgJChNQU5VQUxfQlVJTERESVIpLyQxICwiU1BISU5YIiwiJChNQU5VQUxfQlVJ
TERESVIpLyQxIikNCj4gK2J1aWxkLW1hbnVhbCA9ICQoY2FsbCBxdWlldC1jb21tYW5kLHNwaGlu
eC1idWlsZCAkKGlmICQoViksLC1xKSAtbiAtYiBodG1sIC1EIHZlcnNpb249JChWRVJTSU9OKSAt
RCByZWxlYXNlPSIkKEZVTExfVkVSU0lPTikiIC1kIC5kb2N0cmVlcy8kMSAkKFNSQ19QQVRIKS9k
b2NzLyQxICQoTUFOVUFMX0JVSUxERElSKS8kMSAsIlNQSElOWCIsIiQoTUFOVUFMX0JVSUxERElS
KS8kMSIpDQo+ICAgIyBXZSBhc3N1bWUgYWxsIFJTVCBmaWxlcyBpbiB0aGUgbWFudWFsJ3MgZGly
ZWN0b3J5IGFyZSB1c2VkIGluIGl0DQo+ICAgbWFudWFsLWRlcHMgPSAkKHdpbGRjYXJkICQoU1JD
X1BBVEgpL2RvY3MvJDEvKi5yc3QpICQoU1JDX1BBVEgpL2RvY3MvJDEvY29uZi5weSAkKFNSQ19Q
QVRIKS9kb2NzL2NvbmYucHkNCj4gICANCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFk
aW1pcg0K
