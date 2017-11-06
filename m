Received: from eggs.gnu.org ([2001:4830:134:3::10]:59881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eD2Z2-0001Co-CH
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 01:13:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eD2Yz-0003ZJ-8A
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 01:13:16 -0500
Resent-Message-Id: <E1eD2Yz-0003ZJ-8A@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1eD2Yy-0003Tv-V5
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 01:13:13 -0500
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151000683988.336.12701448268483176497@bafd83ae6430>
In-Reply-To: <alpine.DEB.2.10.1711061412330.30448@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 6 Nov 2017 14:20:41 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v2] aarch64: advertise the GIC system
 register interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sstabellini@kernel.org
Cc: famz@redhat.com, peter.maydell@linaro.org, julien.grall@arm.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, xen-devel@lists.xen.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSCB2Ml0gYWFyY2g2NDogYWR2ZXJ0aXNlIHRoZSBHSUMgc3lzdGVtIHJlZ2lz
dGVyIGludGVyZmFjZQpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogYWxwaW5lLkRFQi4yLjEwLjE3
MTEwNjE0MTIzMzAuMzA0NDhAc3N0YWJlbGxpbmktVGhpbmtQYWQtWDI2MAoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cg
LS1vbmVsaW5lICRCQVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCgpj
b21taXRzPSIkKGdpdCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBp
biAkY29tbWl0czsgZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQg
bG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1h
dD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAg
ICAgIGZhaWxlZD0xCiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhp
dCAkZmFpbGVkCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZm
ODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNo
ZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgICAgICAgIHBhdGNoZXcvYWxwaW5l
LkRFQi4yLjEwLjE3MTEwNjE0MTIzMzAuMzA0NDhAc3N0YWJlbGxpbmktVGhpbmtQYWQtWDI2MCAt
PiBwYXRjaGV3L2FscGluZS5ERUIuMi4xMC4xNzExMDYxNDEyMzMwLjMwNDQ4QHNzdGFiZWxsaW5p
LVRoaW5rUGFkLVgyNjAKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwpkM2UxY2VjNTQ5
IGFhcmNoNjQ6IGFkdmVydGlzZSB0aGUgR0lDIHN5c3RlbSByZWdpc3RlciBpbnRlcmZhY2UKCj09
PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMTogYWFyY2g2NDogYWR2ZXJ0aXNl
IHRoZSBHSUMgc3lzdGVtIHJlZ2lzdGVyIGludGVyZmFjZS4uLgpFUlJPUjogc3BhY2VzIHJlcXVp
cmVkIGFyb3VuZCB0aGF0ICd8JyAoY3R4OlZ4VikKIzY3OiBGSUxFOiB0YXJnZXQvYXJtL2hlbHBl
ci5jOjQ2OTA6CisgICAgICAgICAgICAgIC5yZXNldHZhbHVlID0gY3B1LT5naWN2M19zeXNyZWdz
ID8gKGNwdS0+aWRfYWE2NHBmcjB8MHgwMTAwMDAwMCkgOgogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoKdG90YWw6IDEg
ZXJyb3JzLCAwIHdhcm5pbmdzLCAzNCBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNoIGhhcyBzdHls
ZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZh
bHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFU
Q0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0
ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRv
IHBhdGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
