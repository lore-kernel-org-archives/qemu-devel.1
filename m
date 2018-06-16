Received: from eggs.gnu.org ([2001:4830:134:3::10]:42546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fUZzj-0002iD-7d
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 11:53:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fUZzf-0001rV-CU
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 11:53:35 -0400
Resent-Message-Id: <E1fUZzf-0001rV-CU@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1fUZzf-0001r4-3j
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 11:53:31 -0400
In-Reply-To: <20180615222855.44421-1-mst@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152910755004.708.82579643736289459@d39dc562802a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 15 Jun 2018 17:05:50 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v3 0/2] kvm: limited x86 CPU power
 management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com, ehabkost@redhat.com, kvm@vger.kernel.org, rth@twiddle.net

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwNjE1MjIyODU1LjQ0NDIxLTEtbXN0QHJlZGhhdC5jb20KU3ViamVjdDog
W1FlbXUtZGV2ZWxdIFtQQVRDSCB2MyAwLzJdIGt2bTogbGltaXRlZCB4ODYgQ1BVIHBvd2VyIG1h
bmFnZW1lbnQKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKCkJBU0U9YmFz
ZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAkQkFTRS4uIHwgd2MgLWwpCmZhaWxlZD0w
CgpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlz
dG9ncmFtCgpjb21taXRzPSIkKGdpdCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4p
Igpmb3IgYyBpbiAkY29tbWl0czsgZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3Rh
bDogJChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAk
YyAtLWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsg
dGhlbgogICAgICAgIGZhaWxlZD0xCiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkK
ZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhj
ZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIu
Y29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgICAgICAgIHBhdGNo
ZXcvMjAxODA2MTUyMjI4NTUuNDQ0MjEtMS1tc3RAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMTgw
NjE1MjIyODU1LjQ0NDIxLTEtbXN0QHJlZGhhdC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNo
ICd0ZXN0JwplYzZmMjhjYmM5IGkzODYvY3B1OiBtYWtlIC1jcHUgaG9zdCBzdXBwb3J0IG1vbml0
b3IvbXdhaXQKOGRmNGJlYjVjNSBrdm06IHN1cHBvcnQgLWRlZGljYXRlZCBjcHUtcG09b258b2Zm
Cgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzI6IGt2bTogc3VwcG9ydCAt
ZGVkaWNhdGVkIGNwdS1wbT1vbnxvZmYuLi4KRVJST1I6IGRvIG5vdCBpbml0aWFsaXNlIGdsb2Jh
bHMgdG8gMCBvciBOVUxMCiMxMDM6IEZJTEU6IHZsLmM6MTQ1OgorYm9vbCBlbmFibGVfY3B1X3Bt
ID0gZmFsc2U7Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDExMCBsaW5lcyBjaGVja2Vk
CgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBv
ZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFp
bnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgpDaGVja2luZyBQQVRDSCAy
LzI6IGkzODYvY3B1OiBtYWtlIC1jcHUgaG9zdCBzdXBwb3J0IG1vbml0b3IvbXdhaXQuLi4KPT09
IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKCi0tLQpF
bWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5v
cmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5j
b20=
