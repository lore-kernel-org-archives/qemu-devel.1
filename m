Received: from eggs.gnu.org ([2001:4830:134:3::10]:39803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1expek-0003YT-7J
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 03:56:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1expeg-0007ak-BR
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 03:56:34 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:52096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jiang.biao2@zte.com.cn>)
	id 1expeg-0007ZP-0n
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 03:56:30 -0400
Date: Mon, 19 Mar 2018 15:56:18 +0800 (CST)
Message-ID: <201803191556183250813@zte.com.cn>
In-Reply-To: <20180313075739.11194-4-xiaoguangrong@tencent.com>
References: 20180313075739.11194-1-xiaoguangrong@tencent.com,
	20180313075739.11194-4-xiaoguangrong@tencent.com
Mime-Version: 1.0
From: <jiang.biao2@zte.com.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5BPATCH_3/8=5D_migration=3A_support_to_d?=
 =?utf-8?q?etect_compressionand_decompression_errors?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, xiaoguangrong@tencent.com, qemu-devel@nongnu.org, kvm@vger.kernel.org

SGksIGd1YW5ncm9uZwo+IEBAIC0xMDUxLDExICsxMDUyLDEzIEBAIHN0YXRpYyBpbnQgZG9fY29t
cHJlc3NfcmFtX3BhZ2UoUUVNVUZpbGUgKmYsIHpfc3RyZWFtICpzdHJlYW0sIFJBTUJsb2NrICpi
bG9jaywKPiB7Cj4gUkFNU3RhdGUgKnJzID0gcmFtX3N0YXRlOwo+IGludCBieXRlc19zZW50LCBi
bGVuOwo+IC0gICAgdWludDhfdCAqcCA9IGJsb2NrLT5ob3N0ICsgKG9mZnNldCAmIFRBUkdFVF9Q
QUdFX01BU0spOwo+ICsgICAgdWludDhfdCBidWZbVEFSR0VUX1BBR0VfU0laRV0sICpwOwoKPiAr
ICAgIHAgPSBibG9jay0+aG9zdCArIChvZmZzZXQgJiBUQVJHRVRfUEFHRV9NQVNLKTsKPiBieXRl
c19zZW50ID0gc2F2ZV9wYWdlX2hlYWRlcihycywgZiwgYmxvY2ssIG9mZnNldCB8Cj4gUkFNX1NB
VkVfRkxBR19DT01QUkVTU19QQUdFKTsKPiAtICAgIGJsZW4gPSBxZW11X3B1dF9jb21wcmVzc2lv
bl9kYXRhKGYsIHN0cmVhbSwgcCwgVEFSR0VUX1BBR0VfU0laRSk7Cj4gKyAgICBtZW1jcHkoYnVm
LCBwLCBUQVJHRVRfUEFHRV9TSVpFKTsKPiArICAgIGJsZW4gPSBxZW11X3B1dF9jb21wcmVzc2lv
bl9kYXRhKGYsIHN0cmVhbSwgYnVmLCBUQVJHRVRfUEFHRV9TSVpFKTsKTWVtb3J5IGNvcHkgb3Bl
cmF0aW9uIGZvciBldmVyeSBwYWdlIHRvIGJlIGNvbXByZXNzZWQgaXMgbm90IGNoZWFwLCBlc3Bl
Y2lhbGx5CndoZW4gdGhlIHBhZ2UgbnVtYmVyIGlzIGh1Z2UsIGFuZCBpdCBtYXkgYmUgbm90IG5l
Y2Vzc2FyeSBmb3IgcGFnZXMgbmV2ZXIgCnVwZGF0ZWQgZHVyaW5nIG1pZ3JhdGlvbi4gCklzIHRo
ZXJlIGFueSBwb3NzaWJpbGl0eSB0aGF0IHdlIGNhbiBkaXN0aW5ndWlzaCB0aGUgcmVhbCBjb21w
cmVzcy9kZWNvbXByZXNzIAplcnJvcnMgZnJvbSB0aG9zZSBiZWluZyBjYXVzZWQgYnkgc291cmNl
IFZNIHVwZGF0aW5nPyBTdWNoIGFzIHRoZSByZXR1cm4gCnZhbHVlIG9mIHFlbXVfdW5jb21wcmVz
cyhkaXN0aW5ndWlzaCBaX0RBVEFfRVJST1IgYW5kIG90aGVyIGVycm9yIGNvZGVzIApyZXR1cm5l
ZCBieSBpbmZsYXRlKCkpPyAKCkppYW5nClJlZ2FyZHMs
