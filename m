Received: from eggs.gnu.org ([2001:4830:134:3::10]:49163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gD3HT-0005Ij-6k
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 04:03:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gD3HP-0004bd-DL
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 04:03:42 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:22648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peng.hao2@zte.com.cn>)
	id 1gD3HP-0004B4-2B
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 04:03:39 -0400
Date: Thu, 18 Oct 2018 16:03:21 +0800 (CST)
Message-ID: <201810181603210927379@zte.com.cn>
In-Reply-To: <32bbd4a7-94eb-1f0a-7f2f-d59d5e47dda6@redhat.com>
References: 1539795177-21038-1-git-send-email-peng.hao2@zte.com.cn,
	32bbd4a7-94eb-1f0a-7f2f-d59d5e47dda6@redhat.com
Mime-Version: 1.0
From: <peng.hao2@zte.com.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5BPATCH_V6_3/5=5D_target-i386=3A_add_rtc?=
 =?utf-8?q?_0x70_port_as_coalesced=5Fpio?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: rkrcmar@redhat.com, mst@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org

Pk9uIDE3LzEwLzIwMTggMTg6NTIsIFBlbmcgSGFvIHdyb3RlOgo+PiArICAgIC8qIHJlZ2lzdGVy
IHJ0YyAweDcwIHBvcnQgYXMgY29hbGVzY2VkX3BpbyAqLwo+PiArICAgIG1lbW9yeV9yZWdpb25f
c2V0X2ZsdXNoX2NvYWxlc2NlZCgmcy0+aW8pOwo+PiArICAgIG1lbW9yeV9yZWdpb25faW5pdF9p
bygmcy0+Y29hbGVzY2VkX2lvLCBPQkpFQ1QocyksICZjbW9zX29wcywKPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgcywgInJ0YzEiLCAxKTsKPj4gKyAgICBpc2FfcmVnaXN0ZXJfaW9wb3J0
KGlzYWRldiwgJnMtPmNvYWxlc2NlZF9pbywgYmFzZSk7Cj4KPkkgdGhpbmsgaW5zdGVhZCBvZiBp
c2FfcmVnaXN0ZXJfaW9wb3J0IHlvdSBjYW4gdXNlCj5tZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdp
b24sIHNvIHRoYXQgcy0+Y29hbGVzY2VkX2lvIGlzIGFkZGVkIGJlbG93IHMtPmlvPwo+CmlzYV9y
ZWdpc3Rlcl9pb3BvcnQgYWxzbyBjYWxsZWQgbWVtb3J5X3JlZ2lvbl9hZGRfc3VicmVnaW9uLgpt
b2RpZnkgY29kZSAgbGlrZSB0aGlzOgogIC8vaXNhX3JlZ2lzdGVyX2lvcG9ydChpc2FkZXYsICZz
LT5jb2FsZXNjZWRfaW8sIGJhc2UpOwogICAgbWVtb3J5X3JlZ2lvbl9hZGRfc3VicmVnaW9uKGdl
dF9zeXN0ZW1faW8oKSwweDcwLCZzLT5jb2FsZXNjZWRfaW8pOwpUaGUgcmVnaW9uYWwgZGlzdHJp
YnV0aW9uIGJlZm9yZSBhbmQgYWZ0ZXIgY29kZSBtb2RpZmljYXRpb24gaXMgY29uc2lzdGVudC4K
CiAgIDAwMDAwMDAwMDAwMDAwNzAtMDAwMDAwMDAwMDAwMDA3MCAocHJpbyAwLCBpL28pOiBydGMx
CiAgICAwMDAwMDAwMDAwMDAwMDcwLTAwMDAwMDAwMDAwMDAwNzEgKHByaW8gMCwgaS9vKTogcnRj
Cj5UaGlzIHdheSwgeW91IGRvbid0IHJlbHkgb24gdGhlIGJlaGF2aW9yIG9mIG92ZXJsYXBwaW5n
IHJlZ2lvbnMuCj4KPlBhb2xvCj4KPj4gKyAgICBtZW1vcnlfcmVnaW9uX2FkZF9jb2FsZXNjaW5n
KCZzLT5jb2FsZXNjZWRfaW8sIDAsIDEpOwo+PiAr
