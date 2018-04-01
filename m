Received: from eggs.gnu.org ([2001:4830:134:3::10]:50065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1f2aOZ-0007sv-UI
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 06:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1f2aOV-00034r-E9
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 06:39:31 -0400
Resent-Message-Id: <E1f2aOV-00034r-E9@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1f2aOV-00034D-5z
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 06:39:27 -0400
In-Reply-To: <20180401084848.36725-1-jiangshanlai@gmail.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152257280473.1047.14112992955306982969@71c20359a636>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sun, 1 Apr 2018 01:53:26 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH V3] migration: add capability to bypass the
 shared memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jiangshanlai@gmail.com
Cc: famz@redhat.com, sameo@linux.intel.com, gnawux@gmail.com, qemu-devel@nongnu.org, james.o.hunt@intel.com, bergwolf@gmail.com, dgilbert@redhat.com, armbru@redhat.com, quintela@redhat.com, sebastien.boeuf@intel.com, xiaoguangrong@tencent.com, xiaoguangrong.eric@gmail.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwNDAxMDg0ODQ4LjM2NzI1LTEtamlhbmdzaGFubGFpQGdtYWlsLmNvbQpT
dWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIFYzXSBtaWdyYXRpb246IGFkZCBjYXBhYmlsaXR5
IHRvIGJ5cGFzcyB0aGUgc2hhcmVkIG1lbW9yeQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQoj
IS9iaW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNF
Li4gfCB3YyAtbCkKZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0
IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KCmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0l
SCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hl
Y2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4i
CiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0
Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAg
ICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVO
RCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQK
RnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWdd
ICAgICAgICAgICAgICAgcGF0Y2hldy8yMDE4MDQwMTA4NDg0OC4zNjcyNS0xLWppYW5nc2hhbmxh
aUBnbWFpbC5jb20gLT4gcGF0Y2hldy8yMDE4MDQwMTA4NDg0OC4zNjcyNS0xLWppYW5nc2hhbmxh
aUBnbWFpbC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo4ODg2ZWRjOWNmIG1p
Z3JhdGlvbjogYWRkIGNhcGFiaWxpdHkgdG8gYnlwYXNzIHRoZSBzaGFyZWQgbWVtb3J5Cgo9PT0g
T1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6IG1pZ3JhdGlvbjogYWRkIGNhcGFi
aWxpdHkgdG8gYnlwYXNzIHRoZSBzaGFyZWQgbWVtb3J5Li4uCkVSUk9SOiBicmFjZXMge30gYXJl
IG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1lbnQKIzExODogRklMRTogbWln
cmF0aW9uL21pZ3JhdGlvbi5jOjE1MjU6CisgICAgaWYgKG1pZ3JhdGVfcG9zdGNvcHlfcmFtKCkp
ClsuLi5dCgpFUlJPUjogYnJhY2VzIHt9IGFyZSBuZWNlc3NhcnkgZm9yIGFsbCBhcm1zIG9mIHRo
aXMgc3RhdGVtZW50CiMxNTA6IEZJTEU6IG1pZ3JhdGlvbi9yYW0uYzo3ODQ6CisgICAgaWYgKCFi
aXRtYXApClsuLi5dCgp0b3RhbDogMiBlcnJvcnMsIDAgd2FybmluZ3MsIDEwOCBsaW5lcyBjaGVj
a2VkCgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFu
eSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUg
bWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVO
RCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVy
YXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVh
c2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==
