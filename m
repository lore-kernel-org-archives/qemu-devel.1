Received: from eggs.gnu.org ([2001:4830:134:3::10]:41639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gPWLA-0005Z3-3I
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:31:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gPWL9-0002Jo-7e
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:31:03 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 21 Nov 2018 17:30:53 +0000
Message-ID: <1bc34791-6ae3-cbcd-222f-468b89205f64@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6AE51CA7A09B24FACF28DB863898145@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] encrypt in threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

SGkgRGFuaWVsIQ0KDQpBZnRlciBtb3ZpbmcgY29tcHJlc3Npb24gdG8gdGhyZWFkcyBpbiBRY293
MiBpdCdzIGFuIG9idmlvdXMgbmV4dCBzdGVwIHRvDQoidGhyZWFkeWZ5IiBlbmNyeXB0aW9uIGlu
IFFjb3cyIHRvby4NCg0KQnV0IGl0IHR1cm5lZCBvdXQgdG8gYmUgbm90IGFzIHNpbXBsZSBhcyBJ
IGFzc3VtZWQuIElmIEkgY2FsbCBxY3J5cHRvX2Jsb2NrX2VuY3J5cHQNCmluIHBhcmFsbGVsIHRo
cmVhZHMgd2l0aCB0aGUgc2FtZSBmaXJzdCBhcmd1bWVudCAoYmxvY2spLCBpdCBqdXN0IHByb2R1
Y2Ugd3JvbmcNCnRoaW5ncyAocGF0dGVybiB2ZXJpZmljYXRpb24gZmFpbHMgaW4gaW90ZXN0cyku
Lg0KDQpTbywgY2FuIHlvdSBhZHZpc2UgdGhlIHdheSB0byBwYXJhbGxlbGl6ZSBlbmNyeXB0aW9u
L2RlY3J5cHRpb24/DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==
