Received: from eggs.gnu.org ([2001:4830:134:3::10]:44665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fWXYR-0001Cc-6L
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 21:41:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fWXYO-0003aK-3G
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 21:41:31 -0400
Resent-Message-Id: <E1fWXYO-0003aK-3G@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21095)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1fWXYN-0003YO-Qq
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 21:41:28 -0400
In-Reply-To: <20180622192148.178309-1-mst@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152970452128.897.14893998355415806916@d39dc562802a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 22 Jun 2018 14:55:21 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v6 0/2] kvm: limited x86 CPU power
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
c3NhZ2UtaWQ6IDIwMTgwNjIyMTkyMTQ4LjE3ODMwOS0xLW1zdEByZWRoYXQuY29tClN1YmplY3Q6
IFtRZW11LWRldmVsXSBbUEFUQ0ggdjYgMC8yXSBrdm06IGxpbWl0ZWQgeDg2IENQVSBwb3dlciBt
YW5hZ2VtZW50Cgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJh
c2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9
MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhp
c3RvZ3JhbQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4u
KSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90
YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cg
JGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07
IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkp
CmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4
Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHVi
LmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRj
aGV3LzIwMTgwNjIyMTkyMTQ4LjE3ODMwOS0xLW1zdEByZWRoYXQuY29tIC0+IHBhdGNoZXcvMjAx
ODA2MjIxOTIxNDguMTc4MzA5LTEtbXN0QHJlZGhhdC5jb20KICogW25ldyB0YWddICAgICAgICAg
ICAgICAgcGF0Y2hldy8yMDE4MDYyMjE5MzcwMC42NTIzLTEtbmFyYXZhbXVkYW5AZGlnaXRhbG9j
ZWFuLmNvbSAtPiBwYXRjaGV3LzIwMTgwNjIyMTkzNzAwLjY1MjMtMS1uYXJhdmFtdWRhbkBkaWdp
dGFsb2NlYW4uY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKYzRlZjg2N2M5OCBp
Mzg2L2NwdTogbWFrZSAtY3B1IGhvc3Qgc3VwcG9ydCBtb25pdG9yL213YWl0CjdhNDJmOTM0YjQg
a3ZtOiBzdXBwb3J0IC1vdmVyY29tbWl0IGNwdS1wbT1vbnxvZmYKCj09PSBPVVRQVVQgQkVHSU4g
PT09CkNoZWNraW5nIFBBVENIIDEvMjoga3ZtOiBzdXBwb3J0IC1vdmVyY29tbWl0IGNwdS1wbT1v
bnxvZmYuLi4KRVJST1I6IGRvIG5vdCBpbml0aWFsaXNlIGdsb2JhbHMgdG8gMCBvciBOVUxMCiMx
MTk6IEZJTEU6IHZsLmM6MTQ1OgorYm9vbCBlbmFibGVfY3B1X3BtID0gZmFsc2U7Cgp0b3RhbDog
MSBlcnJvcnMsIDAgd2FybmluZ3MsIDEyNSBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNoIGhhcyBz
dHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJl
IGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNL
UEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgpDaGVja2luZyBQQVRDSCAyLzI6IGkzODYvY3B1OiBtYWtl
IC1jcHUgaG9zdCBzdXBwb3J0IG1vbml0b3IvbXdhaXQuLi4KPT09IE9VVFBVVCBFTkQgPT09CgpU
ZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0
b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQg
eW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
