Received: from eggs.gnu.org ([2001:4830:134:3::10]:34701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1dAizO-00041M-S4
	for qemu-devel@nongnu.org; Tue, 16 May 2017 16:22:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1dAizL-0000u6-6r
	for qemu-devel@nongnu.org; Tue, 16 May 2017 16:22:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:44779)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1dAizK-0000ql-Si
	for qemu-devel@nongnu.org; Tue, 16 May 2017 16:22:35 -0400
From: "Xu, Anthony" <anthony.xu@intel.com>
Date: Tue, 16 May 2017 20:22:28 +0000
Message-ID: <4712D8F4B26E034E80552F30A67BE0B1AB8D87@ORSMSX112.amr.corp.intel.com>
References: <1494897683-16395-1-git-send-email-anthony.xu@intel.com>
	<9fa04242-c144-d5d1-f49b-1bce1df10053@redhat.com>
In-Reply-To: <9fa04242-c144-d5d1-f49b-1bce1df10053@redhat.com>
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

PiBPbiAxNi8wNS8yMDE3IDAzOjIxLCBBbnRob255IFh1IHdyb3RlOg0KPiA+IHdoZW4gc21tIGlz
IGRpc2FibGVkLCBzbXJhbSBpcyBub3QgdXNlZCwgc28gZGlzYWJsZSBpdA0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogQW50aG9ueSBYdSA8YW50aG9ueS54dUBpbnRlbC5jb20+DQo+IA0KPiBXaGF0
IGlzIHRoZSBiZW5lZml0Pw0KVGhpcyBwYXRjaCByZW1vdmVzIDEgbWVtb3J5IHJlZ2lvbiBmb3Ig
aTQ0MCBwbGF0Zm9ybSBhbmQgMyBtZW1vcnkgcmVnaW9ucw0KZm9yIHEzNSBwbGF0Zm9ybS4gVGhh
dCBtYWtlcyBmdW5jdGlvbnMgd2hpY2ggaXRlcmF0ZXMgbWVtb3J5IHJlZ2lvbiB0cmVlDQphIGxp
dHRsZSBiaXQgZmFzdCBldmVuIHRoZSBtZW1vcnkgcmVnaW9ucyBhcmUgZGlzYWJsZWQuDQoNCg0K
QW50aG9ueQ0K
