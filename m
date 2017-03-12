Received: from eggs.gnu.org ([2001:4830:134:3::10]:43103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cn8zM-0002Mm-RA
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 15:17:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cn8zI-0001Zi-5u
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 15:17:08 -0400
Resent-Message-Id: <E1cn8zI-0001Zi-5u@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1cn8zH-0001Yx-Vl
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 15:17:04 -0400
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <148934620169.33.450426621801571953@6c512846dbc7>
In-Reply-To: <1489345956-29167-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sun, 12 Mar 2017 12:16:42 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] memory: use 128 bit in info mtree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzClN1
YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hdIG1lbW9yeTogdXNlIDEyOCBiaXQgaW4gaW5mbyBt
dHJlZQpNZXNzYWdlLWlkOiAxNDg5MzQ1OTU2LTI5MTY3LTEtZ2l0LXNlbmQtZW1haWwtbXN0QHJl
ZGhhdC5jb20KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKCkJBU0U9YmFz
ZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAkQkFTRS4uIHwgd2MgLWwpCmZhaWxlZD0w
CgojIFVzZWZ1bCBnaXQgb3B0aW9ucwpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1p
dCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQoKY29tbWl0cz0iJChnaXQg
bG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRv
CiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9y
bWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3Nj
cmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQog
ICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0g
VEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdm
NDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVt
dQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzE0ODkzNDU5NTYtMjkxNjctMS1naXQtc2Vu
ZC1lbWFpbC1tc3RAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzE0ODkzNDU5NTYtMjkxNjctMS1naXQt
c2VuZC1lbWFpbC1tc3RAcmVkaGF0LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3Qn
CmQyZjcyYjcgbWVtb3J5OiB1c2UgMTI4IGJpdCBpbiBpbmZvIG10cmVlCgo9PT0gT1VUUFVUIEJF
R0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6IG1lbW9yeTogdXNlIDEyOCBiaXQgaW4gaW5mbyBt
dHJlZS4uLgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiM3OTogRklM
RTogbWVtb3J5LmM6MjUyNzoKK15JXkkgICAiLSIgSU5UMTI4X0ZNVDFfcGx4IElOVDEyOF9GTVQy
X3BseCQKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzk4OiBGSUxF
OiBtZW1vcnkuYzoyNTQxOgorXkleSSAgICItIiBJTlQxMjhfRk1UMV9wbHggSU5UMTI4X0ZNVDJf
cGx4JAoKdG90YWw6IDIgZXJyb3JzLCAwIHdhcm5pbmdzLCA5NyBsaW5lcyBjaGVja2VkCgpZb3Vy
IHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVz
ZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5l
ciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRl
c3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRv
bWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5
b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
