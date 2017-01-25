Received: from eggs.gnu.org ([2001:4830:134:3::10]:41885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cWUPE-00006H-5H
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 15:43:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cWUPA-0000XU-8O
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 15:42:59 -0500
Resent-Message-Id: <E1cWUPA-0000XU-8O@eggs.gnu.org>
Received: from sender163-mail.zoho.com ([74.201.84.163]:21474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1cWUP9-0000WO-TC
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 15:42:56 -0500
Reply-To: <qemu-devel@nongnu.org>
In-Reply-To: <20170125203852.19254-1-laurent@vivier.eu>
Message-ID: <148537694536.27.11791128628902222733@eba24e3a0d7f>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 25 Jan 2017 12:42:26 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH 0/2] linux-user: some patches for hppa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: laurent@vivier.eu
Cc: famz@redhat.com, qemu-devel@nongnu.org, riku.voipio@iki.fi, glaubitz@physik.fu-berlin.de

SGksCgpZb3VyIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzClN1
YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggMC8yXSBsaW51eC11c2VyOiBzb21lIHBhdGNoZXMg
Zm9yIGhwcGEKTWVzc2FnZS1pZDogMjAxNzAxMjUyMDM4NTIuMTkyNTQtMS1sYXVyZW50QHZpdmll
ci5ldQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNlCm49
MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAKCiMg
VXNlZnVsIGdpdCBvcHRpb25zCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIkKGdpdCBsb2cg
LS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsgZG8KICAg
IGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9
JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0
cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0xCiAgICAg
ICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBURVNU
IFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJk
ODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAq
IFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAxNzAxMjUyMDM4NTIuMTkyNTQtMS1sYXVyZW50
QHZpdmllci5ldSAtPiBwYXRjaGV3LzIwMTcwMTI1MjAzODUyLjE5MjU0LTEtbGF1cmVudEB2aXZp
ZXIuZXUKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo0OTk1Y2Y3IGxpbnV4LXVzZXI6
IGZpeCAiYXB0LWdldCB1cGRhdGUiIG9uIGxpbnV4LXVzZXIgaHBwYQoyZDcxYWRkIGxpbnV4LXVz
ZXI6IGFkZCBocHBhIG1hZ2ljIG51bWJlcnMgaW4gcWVtdS1iaW5mbXQtY29uZi5zaAoKPT09IE9V
VFBVVCBCRUdJTiA9PT0KQ2hlY2tpbmcgUEFUQ0ggMS8yOiBsaW51eC11c2VyOiBhZGQgaHBwYSBt
YWdpYyBudW1iZXJzIGluIHFlbXUtYmluZm10LWNvbmYuc2guLi4KRVJST1I6IGxpbmUgb3ZlciA5
MCBjaGFyYWN0ZXJzCiMzMzogRklMRTogc2NyaXB0cy9xZW11LWJpbmZtdC1jb25mLnNoOjk1Ogor
aHBwYV9tYWdpYz0nXHg3Zlx4NDVceDRjXHg0Nlx4MDFceDAyXHgwMVx4MDBceDAwXHgwMFx4MDBc
eDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDAyXHgwMFx4MGYnCgpFUlJPUjogbGluZSBvdmVyIDkw
IGNoYXJhY3RlcnMKIzM0OiBGSUxFOiBzY3JpcHRzL3FlbXUtYmluZm10LWNvbmYuc2g6OTY6Cito
cHBhX21hc2s9J1x4ZmZceGZmXHhmZlx4ZmZceGZmXHhmZlx4ZmZceDAwXHhmZlx4ZmZceGZmXHhm
Zlx4ZmZceGZmXHhmZlx4ZmZceGZmXHhmZVx4ZmZceGZmJwoKdG90YWw6IDIgZXJyb3JzLCAwIHdh
cm5pbmdzLCAyMiBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywg
cGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZl
cyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRB
SU5FUlMuCgpDaGVja2luZyBQQVRDSCAyLzI6IGxpbnV4LXVzZXI6IGZpeCAiYXB0LWdldCB1cGRh
dGUiIG9uIGxpbnV4LXVzZXIgaHBwYS4uLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFu
ZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5
IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRi
YWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
