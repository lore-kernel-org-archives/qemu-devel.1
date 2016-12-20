Received: from eggs.gnu.org ([2001:4830:134:3::10]:37086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cJTdU-0002nN-99
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 18:15:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cJTdT-0001WQ-4q
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 18:15:56 -0500
Resent-Message-Id: <E1cJTdT-0001WQ-4q@eggs.gnu.org>
Received: from sender163-mail.zoho.com ([74.201.84.163]:21383)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1cJTdS-0001Vt-St
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 18:15:55 -0500
In-Reply-To: <20161220230732.17862-1-samuel.thibault@ens-lyon.org>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <148227574230.73.12239976842886455682@790289a7ca88>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 20 Dec 2016 15:15:43 -0800 (PST)
Subject: Re: [Qemu-devel] [PULL 0/2] slirp updates: MIN/MAX,
 tftp dynamic blocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: samuel.thibault@ens-lyon.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, jan.kiszka@siemens.com

SGksCgpZb3VyIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTYxMjIwMjMwNzMyLjE3ODYyLTEtc2FtdWVsLnRoaWJhdWx0QGVucy1seW9u
Lm9yZwpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BVTEwgMC8yXSBzbGlycCB1cGRhdGVzOiBNSU4v
TUFYLCB0ZnRwIGR5bmFtaWMgYmxvY2tzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jp
bi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8
IHdjIC1sKQpmYWlsZWQ9MAoKIyBVc2VmdWwgZ2l0IG9wdGlvbnMKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUK
CmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBj
IGluICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdp
dCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9y
bWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAg
ICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpl
eGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIx
ZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0
Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDE2MTIyMDIz
MDczMi4xNzg2Mi0xLXNhbXVlbC50aGliYXVsdEBlbnMtbHlvbi5vcmcgLT4gcGF0Y2hldy8yMDE2
MTIyMDIzMDczMi4xNzg2Mi0xLXNhbXVlbC50aGliYXVsdEBlbnMtbHlvbi5vcmcKU3dpdGNoZWQg
dG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo5YzU1NDRlIHNsaXJwOiBzdXBwb3J0IGR5bmFtaWMgYmxv
Y2sgc2l6ZSBmb3IgVEZUUCB0cmFuc2ZlcnMKOGRlMWQ1NiBzbGlycCwgZGlzYXM6IFJlcGxhY2Ug
bWluL21heCB3aXRoIE1JTi9NQVggbWFjcm9zCgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2lu
ZyBQQVRDSCAxLzI6IHNsaXJwLCBkaXNhczogUmVwbGFjZSBtaW4vbWF4IHdpdGggTUlOL01BWCBt
YWNyb3MuLi4KQ2hlY2tpbmcgUEFUQ0ggMi8yOiBzbGlycDogc3VwcG9ydCBkeW5hbWljIGJsb2Nr
IHNpemUgZm9yIFRGVFAgdHJhbnNmZXJzLi4uCkVSUk9SOiBzdXNwZWN0IGNvZGUgaW5kZW50IGZv
ciBjb25kaXRpb25hbCBzdGF0ZW1lbnRzICgxMCwgMTQpCiM5MDogRklMRTogc2xpcnAvdGZ0cC5j
OjM5MzoKKyAgICAgICAgICBpZiAoYmxrc2l6ZSA+IDApIHsKKyAgICAgICAgICAgICAgc3B0LT5i
bG9ja19zaXplID0gTUlOKGJsa3NpemUsIFRGVFBfQkxPQ0tTSVpFX01BWCk7Cgp0b3RhbDogMSBl
cnJvcnMsIDAgd2FybmluZ3MsIDEwMSBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNoIGhhcyBzdHls
ZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZh
bHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFU
Q0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0
ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRv
IHBhdGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
