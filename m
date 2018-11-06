Received: from eggs.gnu.org ([2001:4830:134:3::10]:35709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gK33X-0004JN-8C
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:14:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gK33V-0005BB-Er
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:14:14 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 6 Nov 2018 15:13:58 +0000
Message-ID: <e1d4fa92-9f84-080c-04e3-4fc9b683c11d@virtuozzo.com>
References: <20181101182738.70462-1-vsementsov@virtuozzo.com>
	<20181101182738.70462-7-vsementsov@virtuozzo.com>
	<w514lcudz3y.fsf@maestria.local.igalia.com>
In-Reply-To: <w514lcudz3y.fsf@maestria.local.igalia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <625BE1F207AFA14DBE89D9B7C5679DC5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 6/7] qcow2: aio support for
 compressed cluster read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>

MDYuMTEuMjAxOCAxODowNiwgQWxiZXJ0byBHYXJjaWEgd3JvdGU6DQo+IE9uIFRodSAwMSBOb3Yg
MjAxOCAwNzoyNzozNyBQTSBDRVQsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6
DQo+DQo+PiArICAgIGJ1ZiA9IGdfdHJ5X21hbGxvYyhjc2l6ZSk7DQo+PiArICAgIGlmICghYnVm
KSB7DQo+PiArICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4+ICsgICAgfQ0KPj4gKyAgICBpb3Yu
aW92X2Jhc2UgPSBidWY7DQo+PiArICAgIGlvdi5pb3ZfbGVuID0gY3NpemU7DQo+PiArICAgIHFl
bXVfaW92ZWNfaW5pdF9leHRlcm5hbCgmbG9jYWxfcWlvdiwgJmlvdiwgMSk7DQo+PiAgIA0KPj4g
LSAgICAgICAgaW92Lmlvdl9iYXNlID0gcy0+Y2x1c3Rlcl9kYXRhOw0KPj4gLSAgICAgICAgaW92
Lmlvdl9sZW4gPSBjc2l6ZTsNCj4+IC0gICAgICAgIHFlbXVfaW92ZWNfaW5pdF9leHRlcm5hbCgm
bG9jYWxfcWlvdiwgJmlvdiwgMSk7DQo+PiArICAgIG91dF9idWYgPSBxZW11X2Jsb2NrYWxpZ24o
YnMsIHMtPmNsdXN0ZXJfc2l6ZSk7DQo+IFlvdSBzaG91bGQgYWxzbyBjaGVjayB3aGV0aGVyIG91
dF9idWYgaXMgTlVMTCwgc2hvdWxkbid0IHlvdT8NCg0KTm8sIGl0IHdpbGwgYWJvcnQgb24gZmFp
bC4gcWVtdV90cnlfYmxvY2thbGlnbiByZXN1bHQgc2hvdWxkIGJlIGNoZWNrZWQuDQoNCj4NCj4g
QmVydG8NCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQoNCg==
