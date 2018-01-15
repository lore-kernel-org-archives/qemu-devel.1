Received: from eggs.gnu.org ([2001:4830:134:3::10]:51843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eb67q-00088t-FV
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:52:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eb67m-00058L-IY
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:52:38 -0500
Resent-Message-Id: <E1eb67m-00058L-IY@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1eb67m-00055z-9l
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:52:34 -0500
In-Reply-To: <20180115141759.11857-1-kraxel@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151602791373.557.1712710882769350620@5adcb62bf0d6>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 15 Jan 2018 06:51:54 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v2 0/2] sdl: hotkey updates and cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwMTE1MTQxNzU5LjExODU3LTEta3JheGVsQHJlZGhhdC5jb20KU3ViamVj
dDogW1FlbXUtZGV2ZWxdIFtQQVRDSCB2MiAwLzJdIHNkbDogaG90a2V5IHVwZGF0ZXMgYW5kIGNs
ZWFudXBzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UK
bj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5yZW5hbWVzIFRydWUKCmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVy
c2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tpbmcgUEFU
Q0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAgICBpZiAh
IGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1t
YWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBmaQogICAg
bj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVw
ZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRw
czovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAg
ICAgICAgcGF0Y2hldy8yMDE4MDExNTE0MzUwMC4yMjYzMS0xLWY0YnVnQGFtc2F0Lm9yZyAtPiBw
YXRjaGV3LzIwMTgwMTE1MTQzNTAwLjIyNjMxLTEtZjRidWdAYW1zYXQub3JnClN3aXRjaGVkIHRv
IGEgbmV3IGJyYW5jaCAndGVzdCcKMDY5YjkxMmQ2NyBzZGw6IHJlb3JnYW5pemUgLW5vLWZyYW1l
IHN1cHBvcnQKZTI1MzgwZmI1YyBzZGw6IHVzZSBjdHJsLWFsdC1nIGFzIGdyYWIgaG90a2V5Cgo9
PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzI6IHNkbDogdXNlIGN0cmwtYWx0
LWcgYXMgZ3JhYiBob3RrZXkuLi4KQ2hlY2tpbmcgUEFUQ0ggMi8yOiBzZGw6IHJlb3JnYW5pemUg
LW5vLWZyYW1lIHN1cHBvcnQuLi4KRVJST1I6IGJyYWNlcyB7fSBhcmUgbmVjZXNzYXJ5IGZvciBh
bGwgYXJtcyBvZiB0aGlzIHN0YXRlbWVudAojNjg6IEZJTEU6IHVpL3NkbC5jOjExNjoKKyAgICBp
ZiAobm9fZnJhbWUpClsuLi5dCgpFUlJPUjogZG8gbm90IGluaXRpYWxpc2UgZ2xvYmFscyB0byAw
IG9yIE5VTEwKIzEzMjogRklMRTogdmwuYzoxNTM6CitpbnQgbm9fZnJhbWUgPSAwOwoKdG90YWw6
IDIgZXJyb3JzLCAwIHdhcm5pbmdzLCA5NyBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNoIGhhcyBz
dHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJl
IGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNL
UEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBl
eGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5
IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNr
IHRvIHBhdGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
