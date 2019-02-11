Received: from eggs.gnu.org ([209.51.188.92]:35600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1gt304-0001Ep-IO
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 23:15:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1gt303-00053T-Hi
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 23:15:20 -0500
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Mon, 11 Feb 2019 04:15:11 +0000
Message-ID: <BN6PR21MB07857DF2253F6D7380B85F239E640@BN6PR21MB0785.namprd21.prod.outlook.com>
References: <20190210165735.GA23862@nyan>
In-Reply-To: <20190210165735.GA23862@nyan>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [v3 PATCH] hw/arm/bcm2835_peripherals: add bcm283x
 sp804-alike timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark <alnyan@airmail.cc>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, "open
	list:Raspberry Pi" <qemu-arm@nongnu.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>

SGkgTWFyaywNCg0KPiBGcm9tOiBNYXJrIDxhbG55YW5AYWlybWFpbC5jYz4NCj4gU2VudDogU3Vu
ZGF5LCAxMCBGZWJydWFyeSAyMDE5IDA4OjU4DQo+IFN1YmplY3Q6IFt2MyBQQVRDSF0gaHcvYXJt
L2JjbTI4MzVfcGVyaXBoZXJhbHM6IGFkZCBiY20yODN4IHNwODA0LWFsaWtlDQo+IHRpbWVyDQoN
ClRoYW5rcyBmb3IgdGhlIHBhdGNoLiBUaGUgaW50ZWdyYXRpb24gd2l0aCBiY20yODM1X3Blcmlw
aGVyYWxzIGxvb2tzIGdvb2QsIGJ1dCBob3BlZnVsbHkgb25lIG9mIHRoZSBRRU1VIG1haW50YWlu
ZXJzIGNhbiBnaXZlIHlvdSBhIHJldmlldyBvZiB0aGUgdGltZXIgaW1wbGVtZW50YXRpb24gYXMg
SSdtIHJlYWxseSBzaG9ydCBvbiB0aW1lIGF0IHRoZSBtb21lbnQuDQoNCklmIHlvdSBkaWRuJ3Qg
YWxyZWFkeSBzZWUgaXQsIHlvdSBtYXkgd2FudCB0byBjb21wYXJlIHdpdGggdGhlIGltcGxlbWVu
dGF0aW9uIGhlcmUsIHdoaWNoIG9yaWdpbmF0ZXMgZnJvbSBHcmVnb3J5IEVzdHJhZGU6DQpodHRw
czovL2dpdGh1Yi5jb20vMHhhYnUvcWVtdS9ibG9iL3Jhc3BpL2h3L3RpbWVyL2JjbTI4MzVfdGlt
ZXIuYw0KLi4uIHNhZGx5IEkgbmV2ZXIgZ290IGFyb3VuZCB0byBtZXJnaW5nIGl0IHVwc3RyZWFt
IHdpdGggdGhlIHJlc3Qgb2YgdGhlIHJhc3BpIGVtdWxhdGlvbi4g4pi5DQoNCkNoZWVycywNCkFu
ZHJldw0KDQo=
