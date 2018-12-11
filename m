Received: from eggs.gnu.org ([2001:4830:134:3::10]:44735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gWjIa-0000y2-3O
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:46:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gWjIZ-0001tI-9y
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:46:12 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 11 Dec 2018 14:45:56 +0000
Message-ID: <d1a46fc0-c87c-d684-2c41-b91e5da16949@virtuozzo.com>
References: <1544532681-53370-1-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1544532681-53370-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <D82827291AD3874AAF60BEDE85F85CF0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6] qemu-img info lists bitmap directory
 entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, Denis Lunev <den@virtuozzo.com>

MTEuMTIuMjAxOCAxNTo1MSwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IEluIHRoZSAnRm9y
bWF0IHNwZWNpZmljIGluZm9ybWF0aW9uJyBzZWN0aW9uIG9mIHRoZSAncWVtdS1pbWcgaW5mbycN
Cj4gY29tbWFuZCBvdXRwdXQsIHRoZSBzdXBwbGVtZW50YWwgaW5mb3JtYXRpb24gYWJvdXQgZXhp
c3RpbmcgUUNPVzINCj4gYml0bWFwcyB3aWxsIGJlIHNob3duLCBzdWNoIGFzIGEgYml0bWFwIG5h
bWUsIGZsYWdzIGFuZCBncmFudWxhcml0eToNCj4gDQoNClsuLl0NCg0KPiAtLS0gYS9ibG9jay9x
Y293Mi5jDQo+ICsrKyBiL2Jsb2NrL3Fjb3cyLmMNCj4gQEAgLTQyNzAsNiArNDI3MCwxMCBAQCBz
dGF0aWMgSW1hZ2VJbmZvU3BlY2lmaWMgKnFjb3cyX2dldF9zcGVjaWZpY19pbmZvKEJsb2NrRHJp
dmVyU3RhdGUgKmJzKQ0KPiAgICAgICAgICAgICAgIC5yZWZjb3VudF9iaXRzICAgICAgPSBzLT5y
ZWZjb3VudF9iaXRzLA0KPiAgICAgICAgICAgfTsNCj4gICAgICAgfSBlbHNlIGlmIChzLT5xY293
X3ZlcnNpb24gPT0gMykgew0KPiArICAgICAgICBRY293MkJpdG1hcEluZm9MaXN0ICpiaXRtYXBz
Ow0KPiArICAgICAgICBFcnJvciAqbG9jYWxfZXJyID0gTlVMTDsNCj4gKw0KPiArICAgICAgICBi
aXRtYXBzID0gcWNvdzJfZ2V0X2JpdG1hcF9pbmZvX2xpc3QoYnMsICZsb2NhbF9lcnIpOw0KPiAg
ICAgICAgICAgKnNwZWNfaW5mby0+dS5xY293Mi5kYXRhID0gKEltYWdlSW5mb1NwZWNpZmljUUNv
dzIpew0KPiAgICAgICAgICAgICAgIC5jb21wYXQgICAgICAgICAgICAgPSBnX3N0cmR1cCgiMS4x
IiksDQo+ICAgICAgICAgICAgICAgLmxhenlfcmVmY291bnRzICAgICA9IHMtPmNvbXBhdGlibGVf
ZmVhdHVyZXMgJg0KPiBAQCAtNDI3OSw3ICs0MjgzLDEyIEBAIHN0YXRpYyBJbWFnZUluZm9TcGVj
aWZpYyAqcWNvdzJfZ2V0X3NwZWNpZmljX2luZm8oQmxvY2tEcml2ZXJTdGF0ZSAqYnMpDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFFDT1cyX0lOQ09NUEFUX0NPUlJVUFQs
DQo+ICAgICAgICAgICAgICAgLmhhc19jb3JydXB0ICAgICAgICA9IHRydWUsDQo+ICAgICAgICAg
ICAgICAgLnJlZmNvdW50X2JpdHMgICAgICA9IHMtPnJlZmNvdW50X2JpdHMsDQo+ICsgICAgICAg
ICAgICAuaGFzX2JpdG1hcHMgICAgICAgID0gIWxvY2FsX2VyciwNCj4gKyAgICAgICAgICAgIC5i
aXRtYXBzICAgICAgICAgICAgPSBiaXRtYXBzLA0KPiAgICAgICAgICAgfTsNCj4gKyAgICAgICAg
LyogVE9ETzogUmVwb3J0IHRoZSBFcnJvciB1cCB0byB0aGUgY2FsbGVyIHdoZW4NCj4gKyAgICAg
ICAgICogYW4gZXJyb3IgcHJvcGFnYXRpb24gYWxnb3JpdGhtIGlzIGltcGxlbWVudGVkICovDQoN
Cg0KaG0sIGV2ZW4gYWZ0ZXIgYWRkaW5nIGVycnAgcGFyYW1ldGVyIHRvIHRoZSBmdW5jdGlvbiwg
d2UnbGwgaWdub3JlIHRoaXMgZXJyb3IsIGFzIHdlIGRvbid0IHdhbnQNCnRvIGZhaWwgdGhlIHdo
b2xlIGZ1bmN0aW9uIGJlY2F1c2Ugb2YgZmFpbGVkIGJpdG1hcHMuIFNvLCB3aXRob3V0IHRoaXMg
Y29tbWVudDoNCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZz
ZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KDQo+ICsgICAgICAgIGVycm9yX2ZyZWUobG9jYWxf
ZXJyKTsNCj4gICAgICAgfSBlbHNlIHsNCj4gICAgICAgICAgIC8qIGlmIHRoaXMgYXNzZXJ0aW9u
IGZhaWxzLCB0aGlzIHByb2JhYmx5IG1lYW5zIGEgbmV3IHZlcnNpb24gd2FzDQo+ICAgICAgICAg
ICAgKiBhZGRlZCB3aXRob3V0IGhhdmluZyBpdCBjb3ZlcmVkIGhlcmUgKi8NCj4gZGlmZiAtLWdp
dCBhL2Jsb2NrL3Fjb3cyLmggYi9ibG9jay9xY293Mi5oDQo+IGluZGV4IDg2NjJiNjguLjBlYzJi
M2QgMTAwNjQ0DQoNCg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==
