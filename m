Received: from eggs.gnu.org ([2001:4830:134:3::10]:59055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ep0jF-0005vR-5q
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:56:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ep0j4-0004zX-Tv
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:56:44 -0500
Resent-Message-Id: <E1ep0j4-0004zX-Tv@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1ep0j4-0004ub-80
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:56:34 -0500
In-Reply-To: <20180222234702.15705-1-airlied@gmail.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151934377831.744.16700958441784584400@bdbb90650ae5>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 22 Feb 2018 15:56:19 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] virtio-gpu-3d: add support for second
 capability set (v3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: airlied@gmail.com
Cc: famz@redhat.com, qemu-devel@nongnu.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwMjIyMjM0NzAyLjE1NzA1LTEtYWlybGllZEBnbWFpbC5jb20KU3ViamVj
dDogW1FlbXUtZGV2ZWxdIFtQQVRDSF0gdmlydGlvLWdwdS0zZDogYWRkIHN1cHBvcnQgZm9yIHNl
Y29uZCBjYXBhYmlsaXR5IHNldCAodjMpCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jp
bi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8
IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0t
cmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2lu
ZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAg
IGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5w
bCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZp
CiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09
PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9t
IGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAg
ICAgICAgICAgICBwYXRjaGV3LzIwMTgwMjIyMjM0NzAyLjE1NzA1LTEtYWlybGllZEBnbWFpbC5j
b20gLT4gcGF0Y2hldy8yMDE4MDIyMjIzNDcwMi4xNTcwNS0xLWFpcmxpZWRAZ21haWwuY29tCiAq
IFtuZXcgdGFnXSAgICAgICAgICAgICAgIHBhdGNoZXcvMjAxODAyMjIyMzQ5MTkuOTA2MC0xLXJp
Y2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcgLT4gcGF0Y2hldy8yMDE4MDIyMjIzNDkxOS45MDYw
LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZwpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2gg
J3Rlc3QnCmJiMDQ4OGM1NzIgdmlydGlvLWdwdS0zZDogYWRkIHN1cHBvcnQgZm9yIHNlY29uZCBj
YXBhYmlsaXR5IHNldCAodjMpCgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAx
LzE6IHZpcnRpby1ncHUtM2Q6IGFkZCBzdXBwb3J0IGZvciBzZWNvbmQgY2FwYWJpbGl0eSBzZXQg
KHYzKS4uLgpFUlJPUjogYnJhY2VzIHt9IGFyZSBuZWNlc3NhcnkgZm9yIGFsbCBhcm1zIG9mIHRo
aXMgc3RhdGVtZW50CiM0NDogRklMRTogaHcvZGlzcGxheS92aXJ0aW8tZ3B1LTNkLmM6NjUwOgor
ICAgIGlmIChjYXBzZXQyX21heF92ZXIpClsuLi5dCisgICAgZWxzZQpbLi4uXQoKdG90YWw6IDEg
ZXJyb3JzLCAwIHdhcm5pbmdzLCA1NCBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNoIGhhcyBzdHls
ZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZh
bHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFU
Q0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0
ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRv
IHBhdGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
