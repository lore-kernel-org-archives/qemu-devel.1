Received: from eggs.gnu.org ([209.51.188.92]:60666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gyJHp-0005jx-UQ
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:39:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gyJHn-0000jm-TU
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:39:25 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 25 Feb 2019 16:39:14 +0000
Message-ID: <1c4720aa-2831-ae7c-379d-8b7702a9dd23@virtuozzo.com>
References: <1550762799-830661-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1550762799-830661-3-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1550762799-830661-3-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <3627619DEF8B5C47880C0A58834A6740@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 2/2] block-stream: include base into job
 node list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "berto@igalia.com" <berto@igalia.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>

MjEuMDIuMjAxOSAxODoyNiwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IFRoZSBibG9jay1z
dHJlYW0gam9iIG5lZWRzIHRvIG93biB0aGUgYmFzZSBub2RlIGFzIHRoZSBsaW1pdGVyDQo+IG9m
IHRoZSBjb3B5LW9uLXJlYWQgb3BlcmF0aW9uLiBTbywgdGhlIGJhc2Ugbm9kZSBpcyBpbmNsdWRl
ZCBpbg0KPiB0aGUgam9iIG5vZGUgbGlzdCAoYmxvY2tfam9iX2FkZF9iZHJ2KS4NCj4gQWxzbywg
dGhlIGJsb2NrLXN0cmVhbSBqb2Igd291bGQgbm90IGFsbG93IHRoZSBiYXNlIG5vZGUgdG8gZ28N
Cj4gYXdheSBkdWUgdG8gdGhlIGdyYXBoIG1vZGlmaWNhdGlvbiwgZS5nLiB3aGVuIGEgZmlsdGVy
IG5vZGUgaXMNCj4gaW5zZXJ0ZWQgYmV0d2VlbiB0aGUgYm90dG9tIG5vZGUgYW5kIHRoZSBiYXNl
IG5vZGUuDQo+IEZvciB0aGF0IHJlYXNvbiwgdGhlIGZsYWcgQkxLX1BFUk1fR1JBUEhfTU9EIGlz
IHVuc2V0IGluIHRoZQ0KPiBzaGFyZWQgcGVybWlzc2lvbiBiaXQgbWFzayBvZiB0aGUgYmFzZSBu
b2RlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IFNoaW5rZXZpY2ggPGFuZHJleS5zaGlu
a2V2aWNoQHZpcnR1b3p6by5jb20+DQo+IC0tLQ0KPiAgIGJsb2NrL3N0cmVhbS5jIHwgOSArKysr
KysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvYmxvY2svc3RyZWFtLmMgYi9ibG9jay9zdHJlYW0uYw0KPiBpbmRleCA3YTQ5YWMwLi5j
OGY5M2Q0IDEwMDY0NA0KPiAtLS0gYS9ibG9jay9zdHJlYW0uYw0KPiArKysgYi9ibG9jay9zdHJl
YW0uYw0KPiBAQCAtMjU5LDYgKzI1OSwxNSBAQCB2b2lkIHN0cmVhbV9zdGFydChjb25zdCBjaGFy
ICpqb2JfaWQsIEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICZlcnJvcl9hYm9ydCk7DQo+ICAgICAgIH0NCj4gICANCj4gKyAgICBpZiAoYmFzZSkg
ew0KPiArICAgICAgICAvKg0KPiArICAgICAgICAgKiBUaGUgYmFzZSBub2RlIHNob3VsZCBub3Qg
ZGlzYXBwZWFyIGR1cmluZyB0aGUgam9iLg0KPiArICAgICAgICAgKi8NCj4gKyAgICAgICAgYmxv
Y2tfam9iX2FkZF9iZHJ2KCZzLT5jb21tb24sICJiYXNlIiwgYmFzZSwgMCwNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgIEJMS19QRVJNX0FMTCAmIH5CTEtfUEVSTV9HUkFQSF9NT0QsDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAmZXJyb3JfYWJvcnQpOw0KPiArICAgIH0NCj4g
Kw0KPiAgICAgICBzLT5iYXNlID0gYmFzZTsNCj4gICAgICAgcy0+YmFja2luZ19maWxlX3N0ciA9
IGdfc3RyZHVwKGJhY2tpbmdfZmlsZV9zdHIpOw0KPiAgICAgICBzLT5ic19yZWFkX29ubHkgPSBi
c19yZWFkX29ubHk7DQo+IA0KDQoNCkhtbSwgaW50ZXJzdGluZywgaXMgQkxLX1BFUk1fR1JBUEhf
TU9EIGEgZ29vZCB3YXkgdG8gbG9jayByZWxhdGlvbnMgaW4gbm9kZSBncmFwaD8NCg0KYmRydl9y
ZXBsYWNlX25vZGUgZG9uJ3QgY2hlY2sgdGhpcyBwZXJtaXNzaW9uLiBTbywgSSBkb24ndCB1bmRl
cnN0YW5kLCBob3cgdGhpcw0KcGVybWlzc2lvbiB3b3Jrcy4uIEdyYXBoIG1vZGlmaWNhdGlvbiBv
cGVyYXRpb24gaW4gZGlmZmVyZW5jZSB3aXRoIHJlYWQgb3Igd3JpdGUNCmFyZSBub3QgZG9uZSB0
aHJvdWdoIEJkcnZDaGlsZCBhdCBhbGwuDQoNCkFyZSB0aGVyZSBhbnkgaWRlYXMgb3Igd29yayBz
dGFydGVkIGZvciBzb21lIGFub3RoZXIgbWVjaGFuaXNtIG9mICJmcmVlemluZyIgYSBzdWJncmFw
aA0KZHVyaW5nIGFuIG9wZXJhdGlvbj8NCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWly
DQo=
