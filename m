Received: from eggs.gnu.org ([2001:4830:134:3::10]:60353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ewxpC-0007jr-3I
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 18:27:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ewxp8-0008BU-Ub
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 18:27:46 -0400
Resent-Message-Id: <E1ewxp8-0008BU-Ub@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1ewxp8-0008AF-MS
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 18:27:42 -0400
In-Reply-To: <1521211002-4529-1-git-send-email-wanpengli@tencent.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152121128086.66.14391574185954997530@71c20359a636>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 16 Mar 2018 07:41:21 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] i386/kvm: add support for
 KVM_CAP_X86_DISABLE_EXITS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kernellwp@gmail.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com, ehabkost@redhat.com, rkrcmar@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDE1MjEyMTEwMDItNDUyOS0xLWdpdC1zZW5kLWVtYWlsLXdhbnBlbmdsaUB0ZW5j
ZW50LmNvbQpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSBpMzg2L2t2bTogYWRkIHN1cHBv
cnQgZm9yIEtWTV9DQVBfWDg2X0RJU0FCTEVfRVhJVFMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9
PT0KIyEvYmluL2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAk
QkFTRS4uIHwgd2MgLWwpCmZhaWxlZD0wCgpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVs
aW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCgpjb21taXRzPSIkKGdpdCBsb2cgLS1mb3Jt
YXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsgZG8KICAgIGVjaG8g
IkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMp
Li4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVj
a3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0xCiAgICAgICAgZWNo
bwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBURVNUIFNDUklQ
VCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEz
Mzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcg
dGFnXSAgICAgICAgICAgICAgIHBhdGNoZXcvMTUyMTIxMTAwMi00NTI5LTEtZ2l0LXNlbmQtZW1h
aWwtd2FucGVuZ2xpQHRlbmNlbnQuY29tIC0+IHBhdGNoZXcvMTUyMTIxMTAwMi00NTI5LTEtZ2l0
LXNlbmQtZW1haWwtd2FucGVuZ2xpQHRlbmNlbnQuY29tCiB0IFt0YWcgdXBkYXRlXSAgICAgICAg
ICAgIHBhdGNoZXcvMjAxODAzMTUwMzQ1MDcuNjM0MS0xLWZhbXpAcmVkaGF0LmNvbSAtPiBwYXRj
aGV3LzIwMTgwMzE1MDM0NTA3LjYzNDEtMS1mYW16QHJlZGhhdC5jb20KU3dpdGNoZWQgdG8gYSBu
ZXcgYnJhbmNoICd0ZXN0Jwo5YWJhYmUzNWJjIGkzODYva3ZtOiBhZGQgc3VwcG9ydCBmb3IgS1ZN
X0NBUF9YODZfRElTQUJMRV9FWElUUwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KQ2hlY2tpbmcgUEFU
Q0ggMS8xOiBpMzg2L2t2bTogYWRkIHN1cHBvcnQgZm9yIEtWTV9DQVBfWDg2X0RJU0FCTEVfRVhJ
VFMuLi4KV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzUyOiBGSUxFOiB0YXJnZXQv
aTM4Ni9rdm0uYzoxMDAzOgorICAgICAgICBpbnQgZGlzYWJsZV9leGl0cyA9IGt2bV9jaGVja19l
eHRlbnNpb24oY3MtPmt2bV9zdGF0ZSwgS1ZNX0NBUF9YODZfRElTQUJMRV9FWElUUyk7CgpFUlJP
UjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzU4OiBGSUxFOiB0YXJnZXQvaTM4Ni9rdm0uYzox
MDA5OgorICAgICAgICBpZiAoa3ZtX3ZtX2VuYWJsZV9jYXAoY3MtPmt2bV9zdGF0ZSwgS1ZNX0NB
UF9YODZfRElTQUJMRV9FWElUUywgMCwgZGlzYWJsZV9leGl0cykpIHsKCnRvdGFsOiAxIGVycm9y
cywgMSB3YXJuaW5ncywgMzYgbGluZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUgcHJv
YmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBw
b3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGlu
IE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdp
dGggY29kZTogMQoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3
IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRj
aGV3LWRldmVsQGZyZWVsaXN0cy5vcmc=
