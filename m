Received: from eggs.gnu.org ([2001:4830:134:3::10]:56184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1dBUv2-0003Vm-8P
	for qemu-devel@nongnu.org; Thu, 18 May 2017 19:33:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1dBUuy-0004Bm-AV
	for qemu-devel@nongnu.org; Thu, 18 May 2017 19:33:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:9950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1dBUuy-0004Be-12
	for qemu-devel@nongnu.org; Thu, 18 May 2017 19:33:16 -0400
From: "Xu, Anthony" <anthony.xu@intel.com>
Date: Thu, 18 May 2017 23:33:13 +0000
Message-ID: <4712D8F4B26E034E80552F30A67BE0B1ACCCBA@ORSMSX112.amr.corp.intel.com>
References: <1494897683-16395-1-git-send-email-anthony.xu@intel.com>
	<9fa04242-c144-d5d1-f49b-1bce1df10053@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1AB8D87@ORSMSX112.amr.corp.intel.com>
	<23ecbc03-751d-e804-ea99-949e5dabe63b@redhat.com>
In-Reply-To: <23ecbc03-751d-e804-ea99-949e5dabe63b@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] SMM: disable smram region if smm is
 disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

PiBPbiAxNi8wNS8yMDE3IDIyOjIyLCBYdSwgQW50aG9ueSB3cm90ZToNCj4gPj4gT24gMTYvMDUv
MjAxNyAwMzoyMSwgQW50aG9ueSBYdSB3cm90ZToNCj4gPj4+IHdoZW4gc21tIGlzIGRpc2FibGVk
LCBzbXJhbSBpcyBub3QgdXNlZCwgc28gZGlzYWJsZSBpdA0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1v
ZmYtYnk6IEFudGhvbnkgWHUgPGFudGhvbnkueHVAaW50ZWwuY29tPg0KPiA+Pg0KPiA+PiBXaGF0
IGlzIHRoZSBiZW5lZml0Pw0KPiA+DQo+ID4gVGhpcyBwYXRjaCByZW1vdmVzIDEgbWVtb3J5IHJl
Z2lvbiBmb3IgaTQ0MCBwbGF0Zm9ybSBhbmQgMyBtZW1vcnkNCj4gcmVnaW9ucw0KPiA+IGZvciBx
MzUgcGxhdGZvcm0uIFRoYXQgbWFrZXMgZnVuY3Rpb25zIHdoaWNoIGl0ZXJhdGVzIG1lbW9yeSBy
ZWdpb24gdHJlZQ0KPiA+IGEgbGl0dGxlIGJpdCBmYXN0IGV2ZW4gdGhlIG1lbW9yeSByZWdpb25z
IGFyZSBkaXNhYmxlZC4NCj4gDQo+IERvZXMgaXQgdHJhbnNsYXRlIHRvIGFueXRoaW5nIG1lYXN1
cmFibGUgaW4gYmVuY2htYXJrcz8gIA0KWWVzICwgd2Ugc2VlIGJvb3QgdGltZSBpbXByb3ZlbWVu
dCB3aXRoIHRoaXMgcGF0Y2ggaW4gb3VyIHNldHVwIChza2lwIGd1ZXN0IEJJT1MsIA0KZGlzYWJs
ZSBndWVzdCBQQU0pLg0KDQo+Q291bGQgeW91IGxlYXZlDQo+IHRoZSByZWdpb25zIHRoZXJlLCBi
dXQgc2tpcCB0aGUgY3JlYXRpb24gb2YgdGhlIFNNUkFNIGFkZHJlc3Mgc3BhY2UgaW4NCj4gcmVn
aXN0ZXJfc21yYW1fbGlzdGVuZXIgd2hlbiB0aGUgbWFjaGluZSBkb2Vzbid0IGhhdmUgU01NIGVu
YWJsZWQ/DQpTb3VuZHMgbGlrZSB5b3UgaGF2ZSBjb25jZXJucyBvbiByZW1vdmluZyBzbXJhbSBy
ZWdpb25zLg0KV2hhdCBhcmUgeW91ciBjb25jZXJucz8NCg0KLUFudGhvbnkNCg==
