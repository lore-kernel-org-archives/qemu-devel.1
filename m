Received: from eggs.gnu.org ([2001:4830:134:3::10]:57921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dhXhp-00054E-C1
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:00:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dhXhl-0008Av-49
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:00:09 -0400
Resent-Message-Id: <E1dhXhl-0008Av-49@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1dhXhk-0008AK-TX
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:00:05 -0400
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <150278758924.78.16068223215275870985@dd743fd916bd>
In-Reply-To: <20170815084430.7128-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 15 Aug 2017 01:59:50 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH for-2.10 v2 0/2] trace: fix simpletrace.stp
 flight recorder mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAx
NzA4MTUwODQ0MzAuNzEyOC0xLXN0ZWZhbmhhQHJlZGhhdC5jb20KU3ViamVjdDogW1FlbXUtZGV2
ZWxdIFtQQVRDSCBmb3ItMi4xMCB2MiAwLzJdIHRyYWNlOiBmaXggc2ltcGxldHJhY2Uuc3RwIGZs
aWdodCByZWNvcmRlciBtb2RlClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09
PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRC
QVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxp
bWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIkKGdp
dCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsg
ZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1m
b3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4v
c2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0x
CiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09
PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVm
N2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9x
ZW11CiB0IFt0YWcgdXBkYXRlXSAgICAgICAgICAgIHBhdGNoZXcvMjAxNzA4MTUwODQ0MzAuNzEy
OC0xLXN0ZWZhbmhhQHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDE3MDgxNTA4NDQzMC43MTI4LTEt
c3RlZmFuaGFAcmVkaGF0LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjdkNmE0
ZWFlOGQgc2ltcGxldHJhY2U6IGZpeCBmbGlnaHQgcmVjb3JkZXIgLS1uby1oZWFkZXIgb3B0aW9u
CmIzNzFlZDI0N2QgdHJhY2U6IHVzZSBzdGF0aWMgZXZlbnQgSUQgbWFwcGluZyBpbiBzaW1wbGV0
cmFjZS5zdHAKCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMjogdHJhY2U6
IHVzZSBzdGF0aWMgZXZlbnQgSUQgbWFwcGluZyBpbiBzaW1wbGV0cmFjZS5zdHAuLi4KQ2hlY2tp
bmcgUEFUQ0ggMi8yOiBzaW1wbGV0cmFjZTogZml4IGZsaWdodCByZWNvcmRlciAtLW5vLWhlYWRl
ciBvcHRpb24uLi4KRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiM0MDogRklMRTogc2Ny
aXB0cy9zaW1wbGV0cmFjZS5weToxMDE6CisgICAgIiIiRGVzZXJpYWxpemUgdHJhY2UgcmVjb3Jk
cyBmcm9tIGEgZmlsZSwgeWllbGRpbmcgcmVjb3JkIHR1cGxlcyAoZXZlbnRfbnVtLCB0aW1lc3Rh
bXAsIHBpZCwgYXJnMSwgLi4uLCBhcmc2KS4KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywg
NDYgbGluZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSBy
ZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0
IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoK
PT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKCi0t
LQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hl
dy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQGZyZWVs
aXN0cy5vcmc=
