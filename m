Received: from eggs.gnu.org ([2001:4830:134:3::10]:35478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fQfYM-00024b-E9
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 17:01:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fQfYI-0006Tk-0r
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 17:01:10 -0400
Resent-Message-Id: <E1fQfYI-0006Tk-0r@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1fQfYH-0006Sz-Ny
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 17:01:05 -0400
In-Reply-To: <20180606205629.66987-1-lfy@google.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152831885238.438.29108589282701719@d39dc562802a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 6 Jun 2018 14:00:53 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] Improve file-backed RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, rth@twiddle.net, crosthwaite.peter@gmail.com, ehabkost@redhat.com, lfy@google.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwNjA2MjA1NjI5LjY2OTg3LTEtbGZ5QGdvb2dsZS5jb20KU3ViamVjdDog
W1FlbXUtZGV2ZWxdIFtQQVRDSF0gSW1wcm92ZSBmaWxlLWJhY2tlZCBSQU0KCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9n
IC0tb25lbGluZSAkQkFTRS4uIHwgd2MgLWwpCmZhaWxlZD0wCgpnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCgpjb21taXRzPSIkKGdp
dCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsg
ZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1m
b3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4v
c2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0x
CiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09
PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVm
N2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9x
ZW11CiAqIFtuZXcgdGFnXSAgICAgICAgICAgICAgIHBhdGNoZXcvMjAxODA2MDYxODEzNTIuNjEx
NDQtMS1sZnlAZ29vZ2xlLmNvbSAtPiBwYXRjaGV3LzIwMTgwNjA2MTgxMzUyLjYxMTQ0LTEtbGZ5
QGdvb2dsZS5jb20KICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0Y2hldy8yMDE4MDYwNjIw
NTYyOS42Njk4Ny0xLWxmeUBnb29nbGUuY29tIC0+IHBhdGNoZXcvMjAxODA2MDYyMDU2MjkuNjY5
ODctMS1sZnlAZ29vZ2xlLmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjk5OTI3
MDc1NWIgSW1wcm92ZSBmaWxlLWJhY2tlZCBSQU0KCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNr
aW5nIFBBVENIIDEvMTogSW1wcm92ZSBmaWxlLWJhY2tlZCBSQU0uLi4KRVJST1I6IGRvIG5vdCBp
bml0aWFsaXNlIGdsb2JhbHMgdG8gMCBvciBOVUxMCiMzMDA6IEZJTEU6IHZsLmM6MTQ0OgoraW50
IG1lbV9maWxlX3NoYXJlZCA9IDA7IC8qIG1hcCBmaWxlLWJhY2tlZCBSQU0gaW4gc2hhcmVkIG1v
ZGUgKi8KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMjMwIGxpbmVzIGNoZWNrZWQKCllv
dXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRo
ZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFp
bmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoK
VGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1
dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5k
IHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t
