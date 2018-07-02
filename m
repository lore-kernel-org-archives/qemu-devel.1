Received: from eggs.gnu.org ([2001:4830:134:3::10]:36516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fZoTZ-0000y6-NE
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 22:22:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fZoTW-0007fR-IA
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 22:22:01 -0400
Resent-Message-Id: <E1fZoTW-0007fR-IA@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1fZoTW-0007dl-8q
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 22:21:58 -0400
In-Reply-To: <20180626143538.5390-1-alex.bennee@linaro.org>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <153049810360.615.1955926020961347428@946cad8fd14e>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sun, 1 Jul 2018 19:21:44 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] blogposts: add post about the new
 check-tcg infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwNjI2MTQzNTM4LjUzOTAtMS1hbGV4LmJlbm5lZUBsaW5hcm8ub3JnClN1
YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hdIGJsb2dwb3N0czogYWRkIHBvc3QgYWJvdXQgdGhl
IG5ldyBjaGVjay10Y2cgaW5mcmFzdHJ1Y3R1cmUKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0K
IyEvYmluL2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAkQkFT
RS4uIHwgd2MgLWwpCmZhaWxlZD0wCgpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1p
dCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCgpjb21taXRzPSIkKGdpdCBsb2cgLS1mb3JtYXQ9
JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsgZG8KICAgIGVjaG8gIkNo
ZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMpLi4u
IgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVja3Bh
dGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0xCiAgICAgICAgZWNobwog
ICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBURVNUIFNDUklQVCBF
TkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0
ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKMWVmYWQ5YmZmMCBibG9ncG9zdHM6IGFk
ZCBwb3N0IGFib3V0IHRoZSBuZXcgY2hlY2stdGNnIGluZnJhc3RydWN0dXJlCgo9PT0gT1VUUFVU
IEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6IGJsb2dwb3N0czogYWRkIHBvc3QgYWJvdXQg
dGhlIG5ldyBjaGVjay10Y2cgaW5mcmFzdHJ1Y3R1cmUuLi4KV0FSTklORzogYWRkZWQsIG1vdmVk
IG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMTQ6
IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKRVJST1I6IHRyYWlsaW5nIHdoaXRlc3BhY2UKIzEwMzog
RklMRTogX3Bvc3RzLzIwMTgtMDYtMjEtdGNnLXRlc3RpbmcubWQ6ODU6CituZWVkIHRvIGJlIGZv
bGxvd2VkIHRvIGFkZCBuZXcgdGVzdHM/ICQKCkVSUk9SOiB0cmFpbGluZyB3aGl0ZXNwYWNlCiMx
NDA6IEZJTEU6IF9wb3N0cy8yMDE4LTA2LTIxLXRjZy10ZXN0aW5nLm1kOjEyMjoKK2Rvbid0IGJ1
aWxkLiAkCgp0b3RhbDogMiBlcnJvcnMsIDEgd2FybmluZ3MsIDEzOSBsaW5lcyBjaGVja2VkCgpZ
b3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0
aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRh
aW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0K
ClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBh
dXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2Vu
ZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==
