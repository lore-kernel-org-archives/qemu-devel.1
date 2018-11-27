Received: from eggs.gnu.org ([2001:4830:134:3::10]:33751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ricardo.perez_blanco@nokia.com>) id 1gRYxt-0007g0-5w
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 03:43:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ricardo.perez_blanco@nokia.com>) id 1gRYxn-0000Y8-5M
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 03:43:29 -0500
From: "Perez Blanco, Ricardo (Nokia - BE/Antwerp)"
	<ricardo.perez_blanco@nokia.com>
Date: Tue, 27 Nov 2018 08:43:06 +0000
Message-ID: <AM6PR07MB536866E0CCDADD411210C7EBB3D00@AM6PR07MB5368.eurprd07.prod.outlook.com>
References: <20181126191454.9455-1-ricardo.perez_blanco@nokia.com>
	<CAFEAcA8MZD1nBPqtPEX91v97si5_MgjXUCPOiJd-tzBg5KvF8g@mail.gmail.com>
In-Reply-To: <CAFEAcA8MZD1nBPqtPEX91v97si5_MgjXUCPOiJd-tzBg5KvF8g@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] [PATCH] Allow AArch64 processors to boot
 from a kernel placed over 4GB.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "ricardoperezblanco@gmail.com" <ricardoperezblanco@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

SGkgUGV0ZXIsDQoNCkFGQUlLLCB0aGVyZSBpcyBubyBib2FyZCBpbiBRRU1VIHRoYXQgaGFzIGl0
cyBtZW1vcnkgb3ZlciA0R2lCLCBob3dldmVyLCB3ZSBhcmUgd29ya2luZyBpbiBzb21lIHByb3Rv
dHlwZXMgYW5kIHByb29mIG9mIGNvbmNlcHRzIG9mIGJvYXJkcyB3aXRoIG1lbW9yeSBvdmVyIDRH
aUIuDQoNCktpbmQgcmVnYXJkcywNCg0KUmljYXJkbw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4N
Cj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciAyNiwgMjAxOCA5OjM1IFBNDQo+IFRvOiBQZXJleiBC
bGFuY28sIFJpY2FyZG8gKE5va2lhIC0gQkUvQW50d2VycCkNCj4gPHJpY2FyZG8ucGVyZXpfYmxh
bmNvQG5va2lhLmNvbT4NCj4gQ2M6IHJpY2FyZG9wZXJlemJsYW5jb0BnbWFpbC5jb207IHFlbXUt
YXJtIDxxZW11LWFybUBub25nbnUub3JnPjsNCj4gUUVNVSBEZXZlbG9wZXJzIDxxZW11LWRldmVs
QG5vbmdudS5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIFtQQVRDSF0gQWxsb3cgQUFyY2g2
NCBwcm9jZXNzb3JzIHRvIGJvb3QgZnJvbSBhIGtlcm5lbA0KPiBwbGFjZWQgb3ZlciA0R0IuDQo+
IA0KPiBPbiBNb24sIDI2IE5vdiAyMDE4IGF0IDE5OjE1LCBQZXJleiBCbGFuY28sIFJpY2FyZG8g
KE5va2lhIC0NCj4gQkUvQW50d2VycCkgPHJpY2FyZG8ucGVyZXpfYmxhbmNvQG5va2lhLmNvbT4g
d3JvdGU6DQo+ID4NCj4gPiBTb21lIG1hY2hpbmUgYmFzZWQgb24gQUFyY2g2NCBjYW4gaGF2ZSBp
dHMgbWFpbiBtZW1vcnkgb3ZlciA0R0JzLiBXaXRoDQo+ID4gdGhlIGN1cnJlbnQgcGF0aCwgdGhl
c2UgbWFjaGluZXMgY2FuIHN1cHBvcnQgIi1rZXJuZWwiIGluIHFlbXUNCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFJpY2FyZG8gUGVyZXogQmxhbmNvIDxyaWNhcmRvLnBlcmV6X2JsYW5jb0Bub2tp
YS5jb20+DQo+IA0KPiBEb2VzIHRoaXMgZml4IGFuIGlzc3VlIHdpdGggb25lIG9mIHRoZSBjdXJy
ZW50IGJvYXJkcyB3ZSBoYXZlIGluIFFFTVU/IEkgdGhpbmsNCj4gdGhleSBhbGwgaGF2ZSBSQU0g
YmVsb3cgNEdCLi4uDQo+IA0KPiB0aGFua3MNCj4gLS0gUE1NDQo=
