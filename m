Received: from eggs.gnu.org ([2001:4830:134:3::10]:40090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <juro.bystricky@intel.com>) id 1cbbOV-0004rI-R7
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 18:11:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <juro.bystricky@intel.com>) id 1cbbOR-00040e-Pu
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 18:11:23 -0500
Received: from mga06.intel.com ([134.134.136.31]:19476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <juro.bystricky@intel.com>)
	id 1cbbOR-000403-HH
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 18:11:19 -0500
From: "Bystricky, Juro" <juro.bystricky@intel.com>
Date: Wed, 8 Feb 2017 23:11:16 +0000
Message-ID: <6E51916E4A1F32428260031F4C7CD2B6118FB110@ORSMSX112.amr.corp.intel.com>
References: <1486590191-10949-1-git-send-email-juro.bystricky@intel.com>
	<CAFEAcA9GE_4+u847H6MF=_AWywd=O6nFrqLyRKyP9OJ2t-4EMg@mail.gmail.com>
In-Reply-To: <CAFEAcA9GE_4+u847H6MF=_AWywd=O6nFrqLyRKyP9OJ2t-4EMg@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 0/1] Nios2: Altera JATAG UART
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marek Vasut <marex@denx.de>, "jurobystricky@hotmail.com" <jurobystricky@hotmail.com>, Chris Wulff <crwulff@gmail.com>

bm8gcHJvYmxlbSwganVzdCBzZW50IGluIGEgcGF0Y2ggdjMuDQpJIGZvdW5kIGEgc2hvcnRlciBs
aW5rLCBzbyBpdCBzaG91bGQga2VlcA0KY2hlY2thcHRjaCBoYXBweSBhcyB3ZWxsLg0KDQoNCg0K
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZXRlciBNYXlkZWxsIFttYWls
dG86cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnXQ0KPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5
IDgsIDIwMTcgMzowMCBQTQ0KPiBUbzogQnlzdHJpY2t5LCBKdXJvIDxqdXJvLmJ5c3RyaWNreUBp
bnRlbC5jb20+DQo+IENjOiBRRU1VIERldmVsb3BlcnMgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz47
IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPjsNCj4ganVyb2J5c3RyaWNreUBob3RtYWlsLmNv
bTsgQ2hyaXMgV3VsZmYgPGNyd3VsZmZAZ21haWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1FlbXUt
ZGV2ZWxdIFtQQVRDSCB2MiAwLzFdIE5pb3MyOiBBbHRlcmEgSkFUQUcgVUFSVA0KPiANCj4gT24g
OCBGZWJydWFyeSAyMDE3IGF0IDIxOjQzLCBKdXJvIEJ5c3RyaWNreSA8anVyby5ieXN0cmlja3lA
aW50ZWwuY29tPg0KPiB3cm90ZToNCj4gPiBTZWNvbmQgdmVyc2lvbiwgaGFkIHRvIHJlbW92ZSBh
IGxvbmcgd2ViIGxpbmsgKG92ZXIgOTAgY2hhcnMpLg0KPiANCj4gQ2FuIHdlIGhhdmUgdGhlIHZl
cnNpb24gd2l0aCB0aGUgVVJMLCBwbGVhc2U/DQo+IENoZWNrcGF0Y2ggaXNuJ3QgaW5mYWxsaWJs
ZSwgYW5kIHVzdWFsbHkgaXRzIGVycm9ycw0KPiBhcmUgbW9yZSBvZiBhICJsb29rIGF0IHRoaXMg
YW5kIHNlZSBpZiBpdCdzIGZpeGFibGUiDQo+IHRoYW4gYW4gdW53YWl2YWJsZSByZXF1aXJlbWVu
dC4NCj4gDQo+IEluIHRoaXMgY2FzZSB0aGUgVVJMIGlzIGNsZWFybHkgdXNlZnVsIGluZm9ybWF0
aW9uDQo+IGZvciBmdXR1cmUgcmVhZGVycyBhbmQgaXQgY2FuJ3QgYmUgZm9sZGVkLCBzbw0KPiB0
aGUgb3Zlci1sb25nIGxpbmUgaXMgZmluZS4NCj4gDQo+IHRoYW5rcw0KPiAtLSBQTU0NCg==
