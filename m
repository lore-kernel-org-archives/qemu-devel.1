Received: from eggs.gnu.org ([2001:4830:134:3::10]:44964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gQDx9-00013j-K1
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:05:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gQDws-0006pj-4o
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:05:03 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 23 Nov 2018 16:04:18 +0000
Message-ID: <ffe6d5c8-6676-7872-c131-bf49daa640d2@virtuozzo.com>
References: <20181031113418.29796-1-anton.nefedov@virtuozzo.com>
	<20181031113418.29796-4-anton.nefedov@virtuozzo.com>
In-Reply-To: <20181031113418.29796-4-anton.nefedov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <21D016CC4086EC4EB06B84E76FAFC3C9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 3/9] block: add empty account cookie type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, "berto@igalia.com" <berto@igalia.com>

MzEuMTAuMjAxOCAxNDozNCwgQW50b24gTmVmZWRvdiB3cm90ZToNCj4gVGhpcyBhZGRzIHNvbWUg
cHJvdGVjdGlvbiBmcm9tIGFjY291bnRpbmcgdW5pdGlhbGl6ZWQgY29va2llLg0KDQp1bmluaXRp
YWxpemVkDQoNCj4gVGhhdCBpcywgYmxvY2tfYWNjdF9mYWlsZWQvZG9uZSB3aXRob3V0IHByZXZp
b3VzIGJsb2NrX2FjY3Rfc3RhcnQ7DQo+IGluIHRoYXQgY2FzZSwgY29va2llIHByb2JhYmx5IGhv
bGRzIHZhbHVlcyBmcm9tIHByZXZpb3VzIG9wZXJhdGlvbi4NCj4gDQo+IChOb3RlOiBpdCBtaWdo
dCBhbHNvIGJlIHVuaXRpYWxpemVkIGhvbGRpbmcgZ2FyYmFnZSB2YWx1ZSBhbmQgdGhlcmUgaXMN
Cg0KYW5kIGhlcmUuDQoNCj4gICBzdGlsbCAiPCBCTE9DS19NQVhfSU9UWVBFIiBhc3NlcnRpb24g
Zm9yIHRoYXQuDQo+ICAgU28gYmxvY2tfYWNjdF9mYWlsZWQvZG9uZSB3aXRob3V0IHByZXZpb3Vz
IGJsb2NrX2FjY3Rfc3RhcnQgc2hvdWxkIGJlIHVzZWQNCj4gICB3aXRoIGNhdXRpb24uKQ0KPiAN
Cj4gQ3VycmVudGx5IHRoaXMgaXMgcGFydGljdWxhcmx5IHVzZWZ1bCBpbiBpZGUgY29kZSB3aGVy
ZSBpdCdzIGhhcmQgdG8NCj4ga2VlcCB0cmFjayB3aGV0aGVyIHRoZSByZXF1ZXN0IHN0YXJ0ZWQg
YWNjb3VudGluZyBvciBub3QuIEZvciBleGFtcGxlLA0KPiB0cmltIHJlcXVlc3RzIGRvIHRoZSBh
Y2NvdW50aW5nIHNlcGFyYXRlbHkuDQoNCnNvLCBpcyBpdCBhbiBleGlzdGluZyBidWc/IENvdWxk
IHlvdSBwbGVhc2UgZ2l2ZSBhbiBleGFtcGxlIGluIHRoZSBjb2RlIG9mIHN1Y2ggd3JvbmcgKGJl
Zm9yZSB0aGUgcGF0Y2gpIGFjY291bnRpbmc/DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFudG9u
IE5lZmVkb3YgPGFudG9uLm5lZmVkb3ZAdmlydHVvenpvLmNvbT4NCj4gLS0tDQo+ICAgaW5jbHVk
ZS9ibG9jay9hY2NvdW50aW5nLmggfCAxICsNCj4gICBibG9jay9hY2NvdW50aW5nLmMgICAgICAg
ICB8IDYgKysrKysrDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCj4gDQo+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2Jsb2NrL2FjY291bnRpbmcuaCBiL2luY2x1ZGUvYmxvY2sv
YWNjb3VudGluZy5oDQo+IGluZGV4IGJhOGIwNGQ1NzIuLjg3OGI0YzM1ODEgMTAwNjQ0DQo+IC0t
LSBhL2luY2x1ZGUvYmxvY2svYWNjb3VudGluZy5oDQo+ICsrKyBiL2luY2x1ZGUvYmxvY2svYWNj
b3VudGluZy5oDQo+IEBAIC0zMyw2ICszMyw3IEBAIHR5cGVkZWYgc3RydWN0IEJsb2NrQWNjdFRp
bWVkU3RhdHMgQmxvY2tBY2N0VGltZWRTdGF0czsNCj4gICB0eXBlZGVmIHN0cnVjdCBCbG9ja0Fj
Y3RTdGF0cyBCbG9ja0FjY3RTdGF0czsNCj4gICANCj4gICBlbnVtIEJsb2NrQWNjdFR5cGUgew0K
PiArICAgIEJMT0NLX0FDQ1RfTk9ORSA9IDAsDQo+ICAgICAgIEJMT0NLX0FDQ1RfUkVBRCwNCj4g
ICAgICAgQkxPQ0tfQUNDVF9XUklURSwNCj4gICAgICAgQkxPQ0tfQUNDVF9GTFVTSCwNCj4gZGlm
ZiAtLWdpdCBhL2Jsb2NrL2FjY291bnRpbmcuYyBiL2Jsb2NrL2FjY291bnRpbmcuYw0KPiBpbmRl
eCA3MGEzZDlhNDI2Li44ZDQxYzhhODNhIDEwMDY0NA0KPiAtLS0gYS9ibG9jay9hY2NvdW50aW5n
LmMNCj4gKysrIGIvYmxvY2svYWNjb3VudGluZy5jDQo+IEBAIC0xOTUsNiArMTk1LDEwIEBAIHN0
YXRpYyB2b2lkIGJsb2NrX2FjY291bnRfb25lX2lvKEJsb2NrQWNjdFN0YXRzICpzdGF0cywgQmxv
Y2tBY2N0Q29va2llICpjb29raWUsDQo+ICAgDQo+ICAgICAgIGFzc2VydChjb29raWUtPnR5cGUg
PCBCTE9DS19NQVhfSU9UWVBFKTsNCj4gICANCj4gKyAgICBpZiAoY29va2llLT50eXBlID09IEJM
T0NLX0FDQ1RfTk9ORSkgew0KPiArICAgICAgICByZXR1cm47DQo+ICsgICAgfQ0KPiArDQo+ICAg
ICAgIHFlbXVfbXV0ZXhfbG9jaygmc3RhdHMtPmxvY2spOw0KPiAgIA0KPiAgICAgICBpZiAoZmFp
bGVkKSB7DQo+IEBAIC0yMTcsNiArMjIxLDggQEAgc3RhdGljIHZvaWQgYmxvY2tfYWNjb3VudF9v
bmVfaW8oQmxvY2tBY2N0U3RhdHMgKnN0YXRzLCBCbG9ja0FjY3RDb29raWUgKmNvb2tpZSwNCj4g
ICAgICAgfQ0KPiAgIA0KPiAgICAgICBxZW11X211dGV4X3VubG9jaygmc3RhdHMtPmxvY2spOw0K
PiArDQo+ICsgICAgY29va2llLT50eXBlID0gQkxPQ0tfQUNDVF9OT05FOw0KPiAgIH0NCj4gICAN
Cj4gICB2b2lkIGJsb2NrX2FjY3RfZG9uZShCbG9ja0FjY3RTdGF0cyAqc3RhdHMsIEJsb2NrQWNj
dENvb2tpZSAqY29va2llKQ0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=
