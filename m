Received: from eggs.gnu.org ([2001:4830:134:3::10]:36623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ebpHD-000383-GM
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:05:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ebpH8-00082U-MM
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:05:19 -0500
Resent-Message-Id: <E1ebpH8-00082U-MM@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1ebpH8-00081Y-EK
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:05:14 -0500
In-Reply-To: <20180117145029.28736-1-tournier.elie@gmail.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151620147216.575.7249351335768910793@5adcb62bf0d6>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 17 Jan 2018 07:04:33 -0800 (PST)
Subject: Re: [Qemu-devel] [RFC 0/2] Use SDL to create an OpenGL ES context
 for virglrenderer.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: tournier.elie@gmail.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, kraxel@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwMTE3MTQ1MDI5LjI4NzM2LTEtdG91cm5pZXIuZWxpZUBnbWFpbC5jb20K
U3ViamVjdDogW1FlbXUtZGV2ZWxdIFtSRkMgMC8yXSBVc2UgU0RMIHRvIGNyZWF0ZSBhbiBPcGVu
R0wgRVMgY29udGV4dCBmb3IgdmlyZ2xyZW5kZXJlci4KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9
PT0KIyEvYmluL2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAk
QkFTRS4uIHwgd2MgLWwpCmZhaWxlZD0wCgpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVs
aW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQoKY29tbWl0cz0iJChn
aXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7
IGRvCiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0t
Zm9ybWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAu
L3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9
MQogICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9
PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRl
ZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3Qv
cWVtdQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3LzIwMTgwMTE3MTQ1MDI5LjI4
NzM2LTEtdG91cm5pZXIuZWxpZUBnbWFpbC5jb20gLT4gcGF0Y2hldy8yMDE4MDExNzE0NTAyOS4y
ODczNi0xLXRvdXJuaWVyLmVsaWVAZ21haWwuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAn
dGVzdCcKMGUxZDM2YWY4YSBzZGwyOiBnbGVzIG9wdGlvbiB3aWxsIGNyZWF0ZSBhIGdsZXMgY29u
dGV4dApiNTUyYjdlODA3IHNkbDI6IEFkZCBnbGVzIG9wdGlvbnMKCj09PSBPVVRQVVQgQkVHSU4g
PT09CkNoZWNraW5nIFBBVENIIDEvMjogc2RsMjogQWRkIGdsZXMgb3B0aW9ucy4uLgpDaGVja2lu
ZyBQQVRDSCAyLzI6IHNkbDI6IGdsZXMgb3B0aW9uIHdpbGwgY3JlYXRlIGEgZ2xlcyBjb250ZXh0
Li4uCkVSUk9SOiBicmFjZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBz
dGF0ZW1lbnQKIzQ1OiBGSUxFOiB1aS9zZGwyLWdsLmM6MTQ1OgorICAgIGlmIChzY29uLT5vcGVu
Z2xfZXMpClsuLi5dCisgICAgZWxzZQpbLi4uXQoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdz
LCA2MCBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNl
IHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBv
cnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMu
Cgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoK
LS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRj
aGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJl
ZWxpc3RzLm9yZw==
