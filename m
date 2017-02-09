Received: from eggs.gnu.org ([2001:4830:134:3::10]:40662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <juro.bystricky@intel.com>) id 1cbviI-0004NA-0x
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 15:53:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <juro.bystricky@intel.com>) id 1cbviE-0007xE-UN
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 15:53:10 -0500
Received: from mga01.intel.com ([192.55.52.88]:51804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <juro.bystricky@intel.com>)
	id 1cbviE-0007vu-LW
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 15:53:06 -0500
From: "Bystricky, Juro" <juro.bystricky@intel.com>
Date: Thu, 9 Feb 2017 20:53:04 +0000
Message-ID: <6E51916E4A1F32428260031F4C7CD2B6118FBFA6@ORSMSX112.amr.corp.intel.com>
References: <1486666321-21536-1-git-send-email-juro.bystricky@intel.com>
	<028b23eb-64a0-9e29-0940-629f0d33a364@denx.de>
In-Reply-To: <028b23eb-64a0-9e29-0940-629f0d33a364@denx.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4] nios2: Add Altera JTAG UART emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marek Vasut <marex@denx.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "crwulff@gmail.com" <crwulff@gmail.com>, "jurobystricky@hotmail.com" <jurobystricky@hotmail.com>

DQoNCj4gT24gMDIvMDkvMjAxNyAwNzo1MiBQTSwgSnVybyBCeXN0cmlja3kgd3JvdGU6DQo+ID4g
SlRBRyBVQVJUIGNvcmUgZWxpbWluYXRlcyB0aGUgbmVlZCBmb3IgYSBzZXBhcmF0ZSBSUy0yMzIg
c2VyaWFsDQo+ID4gY29ubmVjdGlvbiB0byBhIGhvc3QgUEMgZm9yIGNoYXJhY3RlciBJL08uDQo+
IA0KPiBBbmQgaG93IGRvZXMgdGhpcyBkZXNjcmliZSB0aGUgY29udGVudCBvZiB0aGlzIHBhdGNo
ID8gVGhpcyBwYXRjaCBhZGRzIGENCj4gbW9kZWwgb2YgSlRBRyBVQVJUICwgaXQgZG9lc24ndCBl
bGltaW5hdGUgYW55dGhpbmcgLi4uDQo+IA0KDQpUaGUgY29tbWl0IG1lc3NhZ2UgZXhwbGljaXRs
eSBzYXlzOg0KIkFkZCBBbHRlcmEgSlRBRyBVQVJUIGVtdWxhdGlvbi4iDQoNCkJ1dCBJIHdpbGwg
YW1lbmQgdGhlIG1lc3NhZ2Ugd2l0aCBtb3JlIGRldGFpbHMuDQoNCj4gPiBIYXJkd2FyZSBlbXVs
YXRpb24gYmFzZWQgb246DQo+ID4gaHR0cHM6Ly93d3cuYWx0ZXJhLmNvbS9lbl9VUy9wZGZzL2xp
dGVyYXR1cmUvdWcvdWdfZW1iZWRkZWRfaXAucGRmDQo+ID4gKFBsZWFzZSBzZWUgIlJlZ2lzdGVy
IE1hcCIgb24gcGFnZSA2NSkNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEp1cm8gQnlzdHJpY2t5
IDxqdXJvLmJ5c3RyaWNreUBpbnRlbC5jb20+DQo+ID4gLS0tDQo+IA0KPiBDaGFuZ2Vsb2cgaXMg
bWlzc2luZyAuLi4NCg0KSSBtb2RlbGxlZCB0aGlzIHBhdGNoIGJhc2VkIG9uIG90aGVyIG5pb3My
IHBhdGNoZXMsIG5vbmUgb2YgdGhlbSBjb250YWluZWQgDQpDaGFuZ2Vsb2cuIFNvIHBsZWFzZSBl
bGFib3JhdGUuDQoNCg0KPiA+ICsgICAgLyoNCj4gPiArICAgICAqIEZJRk8gc2l6ZSBjYW4gYmUg
c2V0IGZyb20gOCB0byAzMiw3NjggYnl0ZXMuDQo+ID4gKyAgICAgKiBPbmx5IHBvd2VycyBvZiB0
d28gYXJlIGFsbG93ZWQuDQo+ID4gKyAgICAgKi8NCj4gPiArICAgIGZpZm9fc2l6ZV9vayA9IGZh
bHNlOw0KPiA+ICsgICAgZm9yIChzaXplID0gODsgc2l6ZSA8PSAzMjc2ODsgc2l6ZSAqPSAyKSB7
DQo+ID4gKyAgICAgICAgaWYgKHNpemUgPT0gZmlmb19zaXplKSB7DQo+ID4gKyAgICAgICAgICAg
IGZpZm9fc2l6ZV9vayA9IHRydWU7DQo+ID4gKyAgICAgICAgICAgIGJyZWFrOw0KPiA+ICsgICAg
ICAgIH0NCj4gPiArICAgIH0NCj4gDQo+IElzbid0IHRoYXQgbGlrZQ0KPiANCj4gaWYgKHNpemUg
PCA4IHx8IHNpemUgPiAzMjc2OCB8fCAoc2l6ZSAmIH4oMSA8PCBmZnMoc2l6ZSkpKSkNCj4gICBl
cnJvcigpDQo+IA0KDQpwb3NzaWJseSwgaG93ZXZlciBmZnMgaXMgcmVqZWN0ZWQgYnkgY2hlY2tw
YXRjaCBhcyBub24tcG9ydGFibGUNCmxpYmMgY2FsbC4gDQoNCg0KPiA+ICsjZGVmaW5lIERFRkFV
TFRfRklGT19TSVpFIDY0DQo+IA0KPiBUaGlzIGlzIHN0aWxsIG5vdCBRT00gcHJvcGVydHkgLCB3
aHkgPw0KPiANCg0KTm90IHN1cmUgd2hhdCB5b3UgbWVhbiwgdGhlIGNvZGUgaGFzOg0KDQpERUZJ
TkVfUFJPUF9VSU5UMzIoImZpZm8tc2l6ZSIsIEFsdGVyYUpVQVJUU3RhdGUsIHJ4X2ZpZm9fc2l6
ZSwgREVGQVVMVF9GSUZPX1NJWkUpLA0KDQoNClRoYW5rcw0KDQpKdXJvDQoNCg0K
