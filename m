Received: from eggs.gnu.org ([2001:4830:134:3::10]:56876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1egW6c-0008QZ-5L
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 08:37:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1egW6W-00084I-5i
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 08:37:46 -0500
Resent-Message-Id: <E1egW6W-00084I-5i@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1egW6V-00083o-Uf
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 08:37:40 -0500
In-Reply-To: <1517318239-15764-1-git-send-email-peter.maydell@linaro.org>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151731942655.1158.4388058581416030834@272c24dfa8ec>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 30 Jan 2018 05:37:07 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] linux-user/signal.c: Rename MC_* defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, riku.voipio@iki.fi, laurent@vivier.eu, patches@linaro.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDE1MTczMTgyMzktMTU3NjQtMS1naXQtc2VuZC1lbWFpbC1wZXRlci5tYXlkZWxs
QGxpbmFyby5vcmcKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSF0gbGludXgtdXNlci9zaWdu
YWwuYzogUmVuYW1lIE1DXyogZGVmaW5lcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9i
aW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4g
fCB3YyAtbCkKZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIkKGdpdCBsb2cg
LS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsgZG8KICAg
IGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9
JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0
cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0xCiAgICAg
ICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBURVNU
IFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJk
ODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAq
IFtuZXcgdGFnXSAgICAgICAgICAgICAgIHBhdGNoZXcvMTUxNzMxODIzOS0xNTc2NC0xLWdpdC1z
ZW5kLWVtYWlsLXBldGVyLm1heWRlbGxAbGluYXJvLm9yZyAtPiBwYXRjaGV3LzE1MTczMTgyMzkt
MTU3NjQtMS1naXQtc2VuZC1lbWFpbC1wZXRlci5tYXlkZWxsQGxpbmFyby5vcmcKICogW25ldyB0
YWddICAgICAgICAgICAgICAgcGF0Y2hldy8yMDE4MDEzMDEzMTcxNi41ODk5RDc0NTZENUB6ZXJv
LmVpay5ibWUuaHUgLT4gcGF0Y2hldy8yMDE4MDEzMDEzMTcxNi41ODk5RDc0NTZENUB6ZXJvLmVp
ay5ibWUuaHUKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwowNmQ5YmZiZGU5IGxpbnV4
LXVzZXIvc2lnbmFsLmM6IFJlbmFtZSBNQ18qIGRlZmluZXMKCj09PSBPVVRQVVQgQkVHSU4gPT09
CkNoZWNraW5nIFBBVENIIDEvMTogbGludXgtdXNlci9zaWduYWwuYzogUmVuYW1lIE1DXyogZGVm
aW5lcy4uLgpFUlJPUjogZG8gbm90IHVzZSBDOTkgLy8gY29tbWVudHMKIzE1NzogRklMRTogbGlu
dXgtdXNlci9zaWduYWwuYzoyOTgwOgorICAgIC8vICAgIF9fcHV0X3VzZXIoZW52LT50c3RhdGUs
ICYoKCpncnApW1NQQVJDX01DX1RTVEFURV0pKTsKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5n
cywgMTQ3IGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVh
c2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJl
cG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVS
Uy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEK
CgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3Bh
dGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBm
cmVlbGlzdHMub3Jn
