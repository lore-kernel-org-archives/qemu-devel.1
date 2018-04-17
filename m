Received: from eggs.gnu.org ([2001:4830:134:3::10]:36000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1f8Lz6-0002pu-M7
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 04:29:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1f8Lz2-0001xG-Dm
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 04:29:04 -0400
Resent-Message-Id: <E1f8Lz2-0001xG-Dm@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1f8Lz2-0001wg-4f
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 04:29:00 -0400
In-Reply-To: <1523953455-28053-1-git-send-email-wanpengli@tencent.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152395371576.1890.5896070372821813251@71c20359a636>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 17 Apr 2018 01:28:36 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH RESEND v2] i386/kvm: add support for
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
c3NhZ2UtaWQ6IDE1MjM5NTM0NTUtMjgwNTMtMS1naXQtc2VuZC1lbWFpbC13YW5wZW5nbGlAdGVu
Y2VudC5jb20KU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCBSRVNFTkQgdjJdIGkzODYva3Zt
OiBhZGQgc3VwcG9ydCBmb3IgS1ZNX0NBUF9YODZfRElTQUJMRV9FWElUUwoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cg
LS1vbmVsaW5lICRCQVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KCmNvbW1pdHM9IiQoZ2l0
IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBk
bwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZv
cm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9z
Y3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEK
ICAgICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09
IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3
ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3Fl
bXUKICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0Y2hldy8xNTIzOTUzNDU1LTI4MDUzLTEt
Z2l0LXNlbmQtZW1haWwtd2FucGVuZ2xpQHRlbmNlbnQuY29tIC0+IHBhdGNoZXcvMTUyMzk1MzQ1
NS0yODA1My0xLWdpdC1zZW5kLWVtYWlsLXdhbnBlbmdsaUB0ZW5jZW50LmNvbQpTd2l0Y2hlZCB0
byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjYxZGQ0OWIwYTEgaTM4Ni9rdm06IGFkZCBzdXBwb3J0IGZv
ciBLVk1fQ0FQX1g4Nl9ESVNBQkxFX0VYSVRTCgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2lu
ZyBQQVRDSCAxLzE6IGkzODYva3ZtOiBhZGQgc3VwcG9ydCBmb3IgS1ZNX0NBUF9YODZfRElTQUJM
RV9FWElUUy4uLgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojNjU6IEZJTEU6IHRh
cmdldC9pMzg2L2t2bS5jOjEwMzM6CisgICAgICAgIGludCBkaXNhYmxlX2V4aXRzID0ga3ZtX2No
ZWNrX2V4dGVuc2lvbihjcy0+a3ZtX3N0YXRlLCBLVk1fQ0FQX1g4Nl9ESVNBQkxFX0VYSVRTKTsK
CkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwojNzU6IEZJTEU6IHRhcmdldC9pMzg2L2t2
bS5jOjEwNDM6CisgICAgICAgIGlmIChrdm1fdm1fZW5hYmxlX2NhcChjcy0+a3ZtX3N0YXRlLCBL
Vk1fQ0FQX1g4Nl9ESVNBQkxFX0VYSVRTLCAwLCBkaXNhYmxlX2V4aXRzKSkgewoKdG90YWw6IDEg
ZXJyb3JzLCAxIHdhcm5pbmdzLCA0OCBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNoIGhhcyBzdHls
ZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZh
bHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFU
Q0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0
ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRv
IHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==
