Received: from eggs.gnu.org ([209.51.188.92]:44361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hAvS0-0001kl-SW
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 07:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hAvRz-0006iH-Or
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 07:50:04 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 1 Apr 2019 11:49:52 +0000
Message-ID: <27d4d78b-ca9f-71f6-3fc7-262452d3dd1b@virtuozzo.com>
References: <20190329042750.14704-1-eblake@redhat.com>
	<20190330165349.32256-1-eblake@redhat.com>
In-Reply-To: <20190330165349.32256-1-eblake@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBB80C457E09184FA09C7BCEA0A67910@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 6.5/6] nbd/client: Trace server
 noncompliance on structured reads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "jsnow@redhat.com" <jsnow@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

MzAuMDMuMjAxOSAxOTo1MywgRXJpYyBCbGFrZSB3cm90ZToNCj4gSnVzdCBhcyB3ZSByZWNlbnRs
eSBhZGRlZCBhIHRyYWNlIGZvciBhIHNlcnZlciBzZW5kaW5nIGJsb2NrIHN0YXR1cw0KPiB0aGF0
IGRvZXNuJ3QgbWF0Y2ggdGhlIHNlcnZlcidzIGFkdmVydGlzZWQgbWluaW11bSBibG9jayBhbGln
bm1lbnQsDQo+IGxldCdzIGRvIHRoZSBzYW1lIGZvciByZWFkIGNodW5rcy4gIEJ1dCBzaW5jZSBx
ZW11IDMuMSBpcyBzdWNoIGENCj4gc2VydmVyIChiZWNhdXNlIGl0IGFkdmVydGlzZWQgNTEyLWJ5
dGUgYWxpZ25tZW50LCBidXQgd2hlbiBzZXJ2aW5nIGENCj4gZmlsZSB0aGF0IGVuZHMgaW4gZGF0
YSBidXQgaXMgbm90IHNlY3Rvci1hbGlnbmVkLCBOQkRfQ01EX1JFQUQgd291bGQNCj4gZGV0ZWN0
IGEgbWlkLXNlY3RvciBjaGFuZ2UgYmV0d2VlbiBkYXRhIGFuZCBob2xlIGF0IEVPRiBhbmQgdGhl
DQo+IHJlc3VsdGluZyByZWFkIGNodW5rcyBhcmUgdW5hbGlnbmVkKSwgd2UgZG9uJ3Qgd2FudCB0
byBjaGFuZ2Ugb3VyDQo+IGJlaGF2aW9yIG9mIG90aGVyd2lzZSB0b2xlcmF0aW5nIHVuYWxpZ25l
ZCByZWFkcy4NCj4gDQo+IE5vdGUgdGhhdCBldmVuIHRob3VnaCB3ZSBmaXhlZCB0aGUgc2VydmVy
IGZvciA0LjAgdG8gYWR2ZXJ0aXNlIGFuDQo+IGFjdHVhbCBibG9jayBhbGlnbm1lbnQgKHdoaWNo
IGdldHMgcmlkIG9mIHRoZSB1bmFsaWduZWQgcmVhZHMgYXQgRU9GDQo+IGZvciBwb3NpeCBmaWxl
cyksIHdlIGNhbiBzdGlsbCB0cmlnZ2VyIGl0IHZpYSBvdGhlciBtZWFuczoNCj4gDQo+ICQgcWVt
dS1uYmQgLS1pbWFnZS1vcHRzIGRyaXZlcj1ibGtkZWJ1ZyxhbGlnbj01MTIsaW1hZ2UuZHJpdmVy
PWZpbGUsaW1hZ2UuZmlsZW5hbWU9L3BhdGgvdG8vbm9uLWFsaWduZWQtZmlsZQ0KPiANCj4gQXJn
dWFibHksIHRoYXQgaXMgYSBidWcgaW4gdGhlIGJsa2RlYnVnIGJsb2NrIHN0YXR1cyBmdW5jdGlv
biwgZm9yDQo+IGxlYWtpbmcgYSBibG9jayBzdGF0dXMgdGhhdCBpcyBub3QgYWxpZ25lZC4gSXQg
bWF5IGFsc28gYmUgcG9zc2libGUgdG8NCj4gb2JzZXJ2ZSBpc3N1ZXMgd2l0aCBhIGJhY2tpbmcg
bGF5ZXIgd2l0aCBzbWFsbGVyIGFsaWdubWVudCB0aGFuIHRoZQ0KPiBhY3RpdmUgbGF5ZXIsIGFs
dGhvdWdoIHNvIGZhciBJIGhhdmUgYmVlbiB1bmFibGUgdG8gd3JpdGUgYSByZWxpYWJsZQ0KPiBp
b3Rlc3QgZm9yIHRoYXQgc2NlbmFyaW8uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBFcmljIEJsYWtl
IDxlYmxha2VAcmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1P
Z2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KDQoNCi0tIA0KQmVzdCByZWdh
cmRzLA0KVmxhZGltaXINCg==
