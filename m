Received: from eggs.gnu.org ([209.51.188.92]:41659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gyBzQ-0000Tx-Br
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 03:51:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gyBzJ-0003O5-DW
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 03:51:55 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Mon, 25 Feb 2019 08:51:40 +0000
Message-ID: <38ba9457-1709-6f21-5c3f-4a84347c44b1@virtuozzo.com>
References: <1550834773-873512-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<078b2a09-b86f-3705-68cf-452f7845cda5@redhat.com>
In-Reply-To: <078b2a09-b86f-3705-68cf-452f7845cda5@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <484FFDEABD159D4FAAEF083183503CB1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] iotests: handle TypeError for Python3
 in test 242
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "crosa@redhat.com" <crosa@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "philmd@redhat.com" <philmd@redhat.com>, Denis Lunev <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

DQoNCk9uIDIyLzAyLzIwMTkgMTc6NTMsIEVyaWMgQmxha2Ugd3JvdGU6DQo+IE9uIDIvMjIvMTkg
NToyNiBBTSwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+PiBUaGUgZGF0YSB0eXBlIGZvciBi
eXRlcyBpbiBQeXRob24zIGRpZmZlcnMgZnJvbSB0aGUgb25lIGluIFB5dGhvbjIuDQo+PiBUaG9z
ZSBjYXNlcyBzaG91bGQgYmUgbWFuYWdlZCBzZXBhcmF0ZWx5Lg0KPj4NCj4+IHYxOg0KPj4gSW4g
dGhlIGZpcnN0IHZlcnNpb24sIHRoZSBUeXBlRXJyb3IgaW4gUHl0aG9uMyB3YXMgaGFuZGxlZCBh
cyB0aGUNCj4+IGV4Y2VwdGlvbi4NCj4+IERpc2N1c3NlZCBpbiB0aGUgZS1tYWlsIHRocmVhZCB3
aXRoIHRoZSBNZXNzYWdlIElEOg0KPj4gPDE1NTA1MTk5OTctMjUzNTM0LTEtZ2l0LXNlbmQtZW1h
aWwtYW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbT4NCj4gDQo+IFRoaXMgcGFyYWdyYXBo
IGJlbG9uZ3MuLi4NCj4gDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IFNoaW5rZXZpY2gg
PGFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20+DQo+PiBSZXBvcnRlZC1ieTogS2V2aW4g
V29sZiA8a3dvbGZAcmVkaGF0LmNvbT4NCj4+IC0tLQ0KPiANCj4gLi4uaGVyZSwgYWZ0ZXIgdGhl
IC0tLSBtYXJrZXIuIEl0IGlzIHVzZWZ1bCB0byByZXZpZXdlcnMsIGJ1dCBkb2VzIG5vdA0KPiBu
ZWVkIHRvIGxhbmQgaW4gdGhlIGxvbmctdGVybSBnaXQgaGlzdG9yeSAoYSB5ZWFyIGZyb20gbm93
LCB3ZSB3b24ndA0KPiBjYXJlIGlmIGl0IHdhcyB2MiBvciB2MTAgdGhhdCBsYW5kZWQsIG5vciBo
b3cgaXQgY2hhbmdlZCBmcm9tIHRoZQ0KPiB2ZXJzaW9ucyB0aGF0IGRpZG4ndCBsYW5kKS4gIEkg
Y2FuIGNsZWFuIGl0IHVwIG9uIHN0YWdpbmcuDQo+IA0KPiBSZXZpZXdlZC1ieTogRXJpYyBCbGFr
ZSA8ZWJsYWtlQHJlZGhhdC5jb20+DQo+IA0KPiBXaWxsIHN0YWdlIHRocm91Z2ggbXkgTkJEIHRy
ZWUuDQo+IA0KDQpZZXMsIHBsZWFzZSwgRXJpYy4gQWN0dWFsbHksIEkgaGFkIG1pc3NlZCB0byBw
dXQgdGhhdCBwYXJhZ3JhcGggYmVsbG93DQp0aGUgZGFzaGVzIHdoaWxlIGNvbXBvc2luZyBpdCBh
cyBhIGNvdmVyIGxldHRlci4gVGhhdCB3YXMgbXkgZmF1bHQuDQpBY2tub3dsZWRnZWQgd2l0aCB0
aGFua3MuIEkgd2lsbCB0YWtlIHlvdXIgY29tbWVudCBpbnRvIGFjY291bnQgZm9yDQpmdXR1cmUu
DQoNCi0tIA0KV2l0aCB0aGUgYmVzdCByZWdhcmRzLA0KQW5kcmV5IFNoaW5rZXZpY2gNCg==
