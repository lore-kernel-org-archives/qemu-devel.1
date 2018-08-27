Received: from eggs.gnu.org ([2001:4830:134:3::10]:34720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1fuJHH-00085Y-SE
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 11:18:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1fuJHD-0008Bb-Lv
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 11:18:03 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:19284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peng.hao2@zte.com.cn>)
	id 1fuJHD-00089r-9K
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 11:17:59 -0400
Date: Mon, 27 Aug 2018 23:17:49 +0800 (CST)
Message-ID: <201808272317499067164@zte.com.cn>
Mime-Version: 1.0
From: <peng.hao2@zte.com.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5BPATCH_V4_4/4=5D_target-i386=3A_add_i44?=
 =?utf-8?q?0fx_0xcf8_portascoalesced=5Fpio?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com
Cc: liran.alon@oracle.com, pbonzini@redhat.com, ehabkost@redhat.com, rkrcmar@redhat.com, kvm@vger.kernel.org, qemu-devel@nongnu.org, zhong.weidong@zte.com.cn

Pk9uIE1vbiwgQXVnIDI3LCAyMDE4IGF0IDA0OjI1OjAwUE0gKzA4MDAsIHBlbmcuaGFvMkB6dGUu
Y29tLmNuIHdyb3RlOgo+PiA+PiBPbiAyNSBBdWcgMjAxOCwgYXQgMTU6MTksIFBlbmcgSGFvIDxw
ZW5nLmhhbzJAenRlLmNvbS5jbj4gd3JvdGU6Cj4+ID4+IAo+PiA+PiBkaWZmIC0tZ2l0IGEvaHcv
cGNpLWhvc3QvcGlpeC5jIGIvaHcvcGNpLWhvc3QvcGlpeC5jCj4+ID4+IGluZGV4IDBlNjA4MzQu
LmRhNzM3NDMgMTAwNjQ0Cj4+ID4+IC0tLSBhL2h3L3BjaS1ob3N0L3BpaXguYwo+PiA+PiArKysg
Yi9ody9wY2ktaG9zdC9waWl4LmMKPj4gPj4gQEAgLTMyNyw2ICszMjcsMTAgQEAgc3RhdGljIHZv
aWQgaTQ0MGZ4X3BjaWhvc3RfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnAp
Cj4+ID4+IAo+PiA+PiAgICAgc3lzYnVzX2FkZF9pbyhzYmQsIDB4Y2ZjLCAmcy0+ZGF0YV9tZW0p
Owo+PiA+PiAgICAgc3lzYnVzX2luaXRfaW9wb3J0cyhzYmQsIDB4Y2ZjLCA0KTsKPj4gPj4gKwo+
PiA+PiArICAgIC8qIHJlZ2lzdGVyIGk0NDBmeCAweGNmOCBwb3J0IGFzIGNvYWxlc2NlZCBwaW8g
Ki8KPj4gPj4gKyAgICBtZW1vcnlfcmVnaW9uX3NldF9mbHVzaF9jb2FsZXNjZWQoJnMtPmRhdGFf
bWVtKTsKPj4gPj4gKyAgICBtZW1vcnlfcmVnaW9uX2FkZF9jb2FsZXNjaW5nKCZzLT5jb25mX21l
bSwgMCwgNCk7Cj4+ID4+IH0KPj4gPj4gCj4+ID5JcyB0aGVyZSBhIHJlYXNvbiB0byBub3QgcmVn
aXN0ZXIgdGhpcyBwb3J0IGFzIGNvYWxlc2NlZCBQSU8gYWxzbyBmb3IgUTM1Pwo+PiA+SW4gcTM1
X2hvc3RfcmVhbGl6ZSgpPwo+PiA+SWYgbm90LCBJIHdvdWxkIGRvIHRoYXQgYXMgYW4gZXh0cmEg
cGF0Y2ggYXMgcGFydCBvZiB0aGlzIHNlcmllcy4KPj4gSnVzdCBhcyBJIG1lbnRpb25lZCBpbiBw
YXRjaCBbMC80XSAsIHlvdSBjYW4gYWRkIHBjaS0+Pmhvc3QgY29uZmlnIHBvcnQgYXMgY29hbGVz
ZWNkIHBpby4gSSB0aGluayAgaXQgd29ya3MgZm9yIHEzNSBwb3J0IDB4Y2Y4Lgo+PiA+LUxpcmFu
Cj4KPldoYXQncyB0aGUgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQgZm9yIHEzNT8KcTM1IGFsc28g
aGFzICB0aGUgc2FtZSBwY2ktaG9zdCBjb25maWcgcG9ydCAweGNmOCAgYXMgIHBpaXguIEkgdGVz
dCB0aGUgY29hbGVzY2VkIHBpbyBmb3IgCnEzNSBwY2ktaG9zdCBjb25maWcgcG9ydCAweGNmOC4g
SXQgc3BlbnQgbGVzcyBWTS1leGl0IGF2ZyB0aW1lIGZyb20gM3VzIHRvIDAuNnVzLgoKPi0tIAo+
TVNU
