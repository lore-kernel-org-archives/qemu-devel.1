Received: from eggs.gnu.org ([2001:4830:134:3::10]:55743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cgyo1-0004Xc-IO
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:11:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cgynx-0003KK-Do
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:11:57 -0500
Resent-Message-Id: <E1cgynx-0003KK-Do@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1cgynx-0003If-6I
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:11:53 -0500
In-Reply-To: <1487875968-23454-1-git-send-email-jcmvbkbc@gmail.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <148787707413.177.7374698123877392045@0e2666bad730>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 23 Feb 2017 11:11:14 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] target/xtensa: sim: instantiate local
 memories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jcmvbkbc@gmail.com
Cc: famz@redhat.com, qemu-devel@nongnu.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMTQ4
Nzg3NTk2OC0yMzQ1NC0xLWdpdC1zZW5kLWVtYWlsLWpjbXZia2JjQGdtYWlsLmNvbQpUeXBlOiBz
ZXJpZXMKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSF0gdGFyZ2V0L3h0ZW5zYTogc2ltOiBp
bnN0YW50aWF0ZSBsb2NhbCBtZW1vcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9i
aW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4g
fCB3YyAtbCkKZmFpbGVkPTAKCiMgVXNlZnVsIGdpdCBvcHRpb25zCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVl
Cgpjb21taXRzPSIkKGdpdCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3Ig
YyBpbiAkY29tbWl0czsgZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChn
aXQgbG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZv
cm1hdD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgog
ICAgICAgIGZhaWxlZD0xCiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoK
ZXhpdCAkZmFpbGVkCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMy
MWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3Bh
dGNoZXctcHJvamVjdC9xZW11CiAtIFt0YWcgdXBkYXRlXSAgICAgIHBhdGNoZXcvMTQ4Nzg1MDY3
My0yNjQ1NS0xLWdpdC1zZW5kLWVtYWlsLXZpamF5LmtpbGFyaUBnbWFpbC5jb20gLT4gcGF0Y2hl
dy8xNDg3ODUwNjczLTI2NDU1LTEtZ2l0LXNlbmQtZW1haWwtdmlqYXkua2lsYXJpQGdtYWlsLmNv
bQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzE0ODc4NzU5NjgtMjM0NTQtMS1naXQtc2Vu
ZC1lbWFpbC1qY212YmtiY0BnbWFpbC5jb20gLT4gcGF0Y2hldy8xNDg3ODc1OTY4LTIzNDU0LTEt
Z2l0LXNlbmQtZW1haWwtamNtdmJrYmNAZ21haWwuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5j
aCAndGVzdCcKZGMzYzA1MSB0YXJnZXQveHRlbnNhOiBzaW06IGluc3RhbnRpYXRlIGxvY2FsIG1l
bW9yaWVzCgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6IHRhcmdldC94
dGVuc2E6IHNpbTogaW5zdGFudGlhdGUgbG9jYWwgbWVtb3JpZXMuLi4KRVJST1I6IE1hY3JvcyB3
aXRoIGNvbXBsZXggdmFsdWVzIHNob3VsZCBiZSBlbmNsb3NlZCBpbiBwYXJlbnRoZXNpcwojMTgw
OiBGSUxFOiB0YXJnZXQveHRlbnNhL292ZXJsYXlfdG9vbC5oOjQwMzoKKyNkZWZpbmUgTUVNX1NF
Q1RJT05TKG5hbWUpIFwKKyAgICBNRU1fTE9DQVRJT04obmFtZSwgMCksIFwKKyAgICBNRU1fTE9D
QVRJT04obmFtZSwgMSksIFwKKyAgICBNRU1fTE9DQVRJT04obmFtZSwgMiksIFwKKyAgICBNRU1f
TE9DQVRJT04obmFtZSwgMykKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMjgwIGxpbmVz
IGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAg
SWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRv
IHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQ
VVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwg
Z2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
