Received: from eggs.gnu.org ([2001:4830:134:3::10]:43184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gZaZW-00011G-A1
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:03:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gZaZS-00059N-6G
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:03:30 -0500
Received: from mail-eopbgr30106.outbound.protection.outlook.com
	([40.107.3.106]:18944
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1gZaZP-00056t-UY
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:03:26 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 19 Dec 2018 12:03:19 +0000
Message-ID: <5e8486d1-5782-0fcd-a028-05efea867de1@virtuozzo.com>
References: <20181218225714.284495-1-eblake@redhat.com>
In-Reply-To: <20181218225714.284495-1-eblake@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <C26DF89DDC7B814A8FE8533B2655D6E4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 0/3] nbd-client: drop extra error noise
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

MTkuMTIuMjAxOCAxOjU3LCBFcmljIEJsYWtlIHdyb3RlOg0KPiBUaGlzIGlzIGEgY291bnRlci1w
cm9wb3NhbCB0byBWbGFkaW1pcidzIGluaXRpYWwgcG9zdCBmb3INCj4gcmVkdWNpbmcgdGhlIG5v
aXNlIGluIGlvdGVzdCAwODMuICBUaGUgZGlmZmVyZW5jZSBpcyB0aGF0DQo+IEkgZHJvcHBlZCBl
cnJvcl9nZXRfaGludCwgc2luY2UgSSBjb3VsZG4ndCBmaW5kIGFueSB1c2VmdWwNCj4gaGludCB0
byBiZSB0cmFjZWQgZHVyaW5nIHRyYW5zbWlzc2lvbiBwaGFzZSBpbiB0aGUgZmlyc3QgcGxhY2Us
DQo+IGFuZCBpbnN0ZWFkIGFkZGVkIGEgdHJhY2UgbWVzc2FnZSBmb3IgdGhlIG9uZSBwbGFjZSB3
aGVyZSB3ZQ0KPiBkbyBzZXQgaGludHMgZHVyaW5nIGhhbmRzaGFraW5nIHBoYXNlLg0KDQpPSywg
YWdyZWUgd2l0aCB0aGUgaWRlYS4NCg0KPiANCj4gRXJpYyBCbGFrZSAoMSk6DQo+ICAgIG5iZC9j
bGllbnQ6IFRyYWNlIGFsbCBzZXJ2ZXIgb3B0aW9uIGVycm9yIG1lc3NhZ2VzDQo+IA0KPiBWbGFk
aW1pciBTZW1lbnRzb3YtT2dpZXZza2l5ICgyKToNCj4gICAgbmJkOiBwdWJsaXNoIF9sb29rdXAg
ZnVuY3Rpb25zDQo+ICAgIGJsb2NrL25iZC1jbGllbnQ6IHVzZSB0cmFjZXMgaW5zdGVhZCBvZiBu
b2lzeSBlcnJvcl9yZXBvcnRfZXJyDQo+IA0KPiAgIGluY2x1ZGUvYmxvY2svbmJkLmggICAgICAg
IHwgIDUgKysrKysNCj4gICBuYmQvbmJkLWludGVybmFsLmggICAgICAgICB8ICA1IC0tLS0tDQo+
ICAgYmxvY2svbmJkLWNsaWVudC5jICAgICAgICAgfCAyMyArKysrKysrKysrKysrKysrKysrLS0t
LQ0KPiAgIG5iZC9jbGllbnQuYyAgICAgICAgICAgICAgIHwgIDIgKysNCj4gICBibG9jay90cmFj
ZS1ldmVudHMgICAgICAgICB8ICA0ICsrKysNCj4gICBuYmQvdHJhY2UtZXZlbnRzICAgICAgICAg
ICB8ICAxICsNCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMDgzLm91dCB8IDI4IC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4gICA3IGZpbGVzIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKyks
IDM3IGRlbGV0aW9ucygtKQ0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=
