Received: from eggs.gnu.org ([2001:4830:134:3::10]:46303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1dYCew-0003Ca-Oa
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 10:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1dYCes-000180-Ph
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 10:42:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:59084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1dYCes-00016q-78
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 10:42:30 -0400
From: "Valluri, Amarnath" <amarnath.valluri@intel.com>
Date: Thu, 20 Jul 2017 14:42:25 +0000
Message-ID: <1500561863.29166.1.camel@intel.com>
References: <1500367747-8992-1-git-send-email-amarnath.valluri@intel.com>
	<1500367747-8992-9-git-send-email-amarnath.valluri@intel.com>
	<a15251e3-de79-dcf3-3db9-83dd4f5980bb@linux.vnet.ibm.com>
In-Reply-To: <a15251e3-de79-dcf3-3db9-83dd4f5980bb@linux.vnet.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <D206872AC76C9442821B995DD5EDAAAD@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6 8/8] tpm: Added support for TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "stefanb@linux.vnet.ibm.com" <stefanb@linux.vnet.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

T24gVHVlLCAyMDE3LTA3LTE4IGF0IDEwOjM5IC0wNDAwLCBTdGVmYW4gQmVyZ2VyIHdyb3RlOg0K
PiBPbiAwNy8xOC8yMDE3IDA0OjQ5IEFNLCBBbWFybmF0aCBWYWxsdXJpIHdyb3RlOg0KPiA+IA0K
PiA+IGRpZmYgLS1naXQgYS9ody90cG0vTWFrZWZpbGUub2JqcyBiL2h3L3RwbS9NYWtlZmlsZS5v
YmpzDQo+ID4gaW5kZXggNjRjZWNjMy4uNDFmMGI3YSAxMDA2NDQNCj4gPiAtLS0gYS9ody90cG0v
TWFrZWZpbGUub2Jqcw0KPiA+ICsrKyBiL2h3L3RwbS9NYWtlZmlsZS5vYmpzDQo+ID4gQEAgLTEs
MiArMSwzIEBADQo+ID4gwqAgY29tbW9uLW9iai0kKENPTkZJR19UUE1fVElTKSArPSB0cG1fdGlz
Lm8NCj4gPiDCoCBjb21tb24tb2JqLSQoQ09ORklHX1RQTV9QQVNTVEhST1VHSCkgKz0gdHBtX3Bh
c3N0aHJvdWdoLm8NCj4gPiB0cG1fdXRpbC5vDQo+ID4gK2NvbW1vbi1vYmotJChDT05GSUdfVFBN
X0VNVUxBVE9SKSArPSB0cG1fZW11bGF0b3IubyB0cG1fdXRpbC5vDQo+ID4gZGlmZiAtLWdpdCBh
L2h3L3RwbS90cG1fZW11bGF0b3IuYyBiL2h3L3RwbS90cG1fZW11bGF0b3IuYw0KPiA+IG5ldyBm
aWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMC4uYzkwOTE0Yw0KPiA+IC0tLSAvZGV2
L251bGwNCj4gPiArKysgYi9ody90cG0vdHBtX2VtdWxhdG9yLmMNCj4gPiBAQCAtMCwwICsxLDk3
MyBAQA0KPiA+ICsvKg0KPiA+ICsgKsKgwqBlbXVsYXRvciBUUE0gZHJpdmVyDQo+ID4gKyAqDQo+
ID4gKyAqwqDCoENvcHlyaWdodCAoYykgMjAxNyBJbnRlbCBDb3Jwb3JhdGlvbg0KPiA+ICsgKsKg
wqBBdXRob3I6IEFtYXJuYXRoIFZhbGx1cmkgPGFtYXJuYXRoLnZhbGx1cmlAaW50ZWwuY29tPg0K
PiA+ICsgKg0KPiA+ICsgKsKgwqBDb3B5cmlnaHQgKGMpIDIwMTAgLSAyMDEzIElCTSBDb3Jwb3Jh
dGlvbg0KPiA+ICsgKsKgwqBBdXRob3JzOg0KPiA+ICsgKsKgwqDCoMKgU3RlZmFuIEJlcmdlciA8
c3RlZmFuYkB1cy5pYm0uY29tPg0KPiA+ICsgKg0KPiA+ICsgKsKgwqBDb3B5cmlnaHQgKEMpIDIw
MTEgSUFJSywgR3JheiBVbml2ZXJzaXR5IG9mIFRlY2hub2xvZ3kNCj4gPiArICrCoMKgwqDCoEF1
dGhvcjogQW5kcmVhcyBOaWVkZXJsDQo+ID4gKyAqDQo+ID4gKyAqIFRoaXMgbGlicmFyeSBpcyBm
cmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3INCj4gPiArICogbW9k
aWZ5IGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIExlc3NlciBHZW5lcmFsIFB1YmxpYw0K
PiA+ICsgKiBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0
aW9uOyBlaXRoZXINCj4gPiArICogdmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNlLCBvciAoYXQgeW91
ciBvcHRpb24pIGFueSBsYXRlcg0KPiA+IHZlcnNpb24uDQo+ID4gKyAqDQo+ID4gKyAqIFRoaXMg
bGlicmFyeSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVs
LA0KPiA+ICsgKiBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1w
bGllZCB3YXJyYW50eSBvZg0KPiA+ICsgKiBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1Ig
QSBQQVJUSUNVTEFSIFBVUlBPU0UuwqDCoFNlZSB0aGUNCj4gPiBHTlUNCj4gPiArICogTGVzc2Vy
IEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4NCj4gPiArICoNCj4gPiAr
ICogWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIExlc3NlciBHZW5l
cmFsDQo+ID4gUHVibGljDQo+ID4gKyAqIExpY2Vuc2UgYWxvbmcgd2l0aCB0aGlzIGxpYnJhcnk7
IGlmIG5vdCwgc2VlIDxodHRwOi8vd3d3LmdudS5vcg0KPiA+IGcvbGljZW5zZXMvPg0KPiA+ICsg
Kg0KPiA+ICsgKi8NCj4gPiArDQo+ID4gKyNpbmNsdWRlICJxZW11L29zZGVwLmgiDQo+ID4gKyNp
bmNsdWRlICJxZW11L2Vycm9yLXJlcG9ydC5oIg0KPiA+ICsjaW5jbHVkZSAicWVtdS9zb2NrZXRz
LmgiDQo+ID4gKyNpbmNsdWRlICJpby9jaGFubmVsLXNvY2tldC5oIg0KPiA+ICsjaW5jbHVkZSAi
c3lzZW11L3RwbV9iYWNrZW5kLmgiDQo+ID4gKyNpbmNsdWRlICJ0cG1faW50LmgiDQo+ID4gKyNp
bmNsdWRlICJody9ody5oIg0KPiA+ICsjaW5jbHVkZSAiaHcvaTM4Ni9wYy5oIg0KPiA+ICsjaW5j
bHVkZSAidHBtX3V0aWwuaCINCj4gPiArI2luY2x1ZGUgInRwbV9pb2N0bC5oIg0KPiA+ICsjaW5j
bHVkZSAibWlncmF0aW9uL21pZ3JhdGlvbi5oIg0KPiBNaXNzaW5nOiBtaWdyYXRpb24vYmxvY2tl
ci5oDQpPb3BzIHRoZXJlIHdhcyBzb21ldGhpbmcgd2VudCB3cm9uZyB3aGlsZSByZWJhc2luZywg
aSB3aWxsIHJlc2VuZC4NCg0KLSBBbWFybmF0aA==
