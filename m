Received: from eggs.gnu.org ([2001:4830:134:3::10]:40637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1f3ukl-00027c-DX
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 22:35:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1f3uki-0003Zf-4K
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 22:35:55 -0400
Resent-Message-Id: <E1f3uki-0003Zf-4K@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1f3ukh-0003ZR-Ve
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 22:35:52 -0400
In-Reply-To: <20180405022002.17809-1-david@gibson.dropbear.id.au>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152289571648.1698.14222443168217841096@71c20359a636>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 4 Apr 2018 19:35:17 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCHv2 for-2.13 0/2] Helpers to obtain host page
 sizes for guest RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: david@gibson.dropbear.id.au
Cc: famz@redhat.com, ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwNDA1MDIyMDAyLjE3ODA5LTEtZGF2aWRAZ2lic29uLmRyb3BiZWFyLmlk
LmF1ClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0h2MiBmb3ItMi4xMyAwLzJdIEhlbHBlcnMg
dG8gb2J0YWluIGhvc3QgcGFnZSBzaXplcyBmb3IgZ3Vlc3QgUkFNCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9u
ZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
cmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQoKY29tbWl0cz0iJChnaXQgbG9n
IC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAg
ICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0
PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3Njcmlw
dHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAg
ICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVT
VCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRi
ZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQog
KiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3LzIwMTgwNDA1MDIyMDAyLjE3ODA5LTEt
ZGF2aWRAZ2lic29uLmRyb3BiZWFyLmlkLmF1IC0+IHBhdGNoZXcvMjAxODA0MDUwMjIwMDIuMTc4
MDktMS1kYXZpZEBnaWJzb24uZHJvcGJlYXIuaWQuYXUKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNo
ICd0ZXN0JwozYTIwMTlhOGFkIEFkZCBob3N0X21lbW9yeV9iYWNrZW5kX3BhZ2VzaXplKCkgaGVs
cGVyCmQ3MGIxYjJiOTIgTWFrZSBxZW11X21lbXBhdGhfZ2V0cGFnZXNpemUoKSBhY2NlcHQgTlVM
TAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KQ2hlY2tpbmcgUEFUQ0ggMS8yOiBNYWtlIHFlbXVfbWVt
cGF0aF9nZXRwYWdlc2l6ZSgpIGFjY2VwdCBOVUxMLi4uCkVSUk9SOiBicmFjZXMge30gYXJlIG5l
Y2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1lbnQKIzk2OiBGSUxFOiB1dGlsL21t
YXAtYWxsb2MuYzo1NjoKKyAgICAgICAgfSB3aGlsZSAocmV0ICE9IDAgJiYgZXJybm8gPT0gRUlO
VFIpOwpbLi4uXQoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA4MiBsaW5lcyBjaGVja2Vk
CgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBv
ZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFp
bnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgpDaGVja2luZyBQQVRDSCAy
LzI6IEFkZCBob3N0X21lbW9yeV9iYWNrZW5kX3BhZ2VzaXplKCkgaGVscGVyLi4uCj09PSBPVVRQ
VVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwg
Z2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t
