Received: from eggs.gnu.org ([209.51.188.92]:40788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gy9fm-000154-5I
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 01:23:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gy9fc-0000lz-FO
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 01:23:22 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 25 Feb 2019 06:23:08 +0000
Message-ID: <ea11d4a7-73da-5a49-cebb-ef7b91f2bb11@virtuozzo.com>
References: <20190223000614.13894-1-jsnow@redhat.com>
	<20190223000614.13894-2-jsnow@redhat.com>
In-Reply-To: <20190223000614.13894-2-jsnow@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <94CC9BEA16E47F418513F0970793789E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 01/10] block/dirty-bitmap: add recording
 and busy properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, "libvir-list@redhat.com" <libvir-list@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>

MjMuMDIuMjAxOSAzOjA2LCBKb2huIFNub3cgd3JvdGU6DQo+IFRoZSBjdXJyZW50IEFQSSBhbGxv
d3MgdXMgdG8gcmVwb3J0IGEgc2luZ2xlIHN0YXR1cywgd2hpY2ggd2UndmUgZGVmaW5lZCBhczoN
Cj4gDQo+IEZyb3plbjogaGFzIGEgc3VjY2Vzc29yLCB0cmVhdGVkIGFzIHFtcF9sb2NrZWQsIG1h
eSBvciBtYXkgbm90IGJlIGVuYWJsZWQuDQo+IExvY2tlZDogbm8gc3VjY2Vzc29yLCBxbXBfbG9j
a2VkLiBtYXkgb3IgbWF5IG5vdCBiZSBlbmFibGVkLg0KPiBEaXNhYmxlZDogTm90IGZyb3plbiBv
ciBsb2NrZWQsIGRpc2FibGVkLg0KPiBBY3RpdmU6IE5vdCBmcm96ZW4sIGxvY2tlZCwgb3IgZGlz
YWJsZWQuDQo+IA0KPiBUaGUgcHJvYmxlbSBpcyB0aGF0IGJvdGggIkZyb3plbiIgYW5kICJMb2Nr
ZWQiIG1lYW4gbmVhcmx5IHRoZSBzYW1lIHRoaW5nLA0KPiBhbmQgdGhhdCBib3RoIG9mIHRoZW0g
ZG8gbm90IGludHVpdCB3aGV0aGVyIHRoZXkgYXJlIHJlY29yZGluZyBndWVzdCB3cml0ZXMNCj4g
b3Igbm90Lg0KPiANCj4gVGhpcyBwYXRjaCBkZXByZWNhdGVzIHRoYXQgc3RhdHVzIGZpZWxkIGFu
ZCBpbnRyb2R1Y2VzIHR3byBvcnRob2dvbmFsDQo+IHByb3BlcnRpZXMgaW5zdGVhZCB0byByZXBs
YWNlIGl0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSm9obiBTbm93PGpzbm93QHJlZGhhdC5jb20+
DQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292
QHZpcnR1b3p6by5jb20+DQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K
