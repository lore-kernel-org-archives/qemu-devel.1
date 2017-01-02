Received: from eggs.gnu.org ([2001:4830:134:3::10]:41618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cO9h4-0006Hk-RP
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:59:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cO9h0-0000X9-Uk
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:58:58 -0500
Resent-Message-Id: <E1cO9h0-0000X9-Uk@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1cO9h0-0000Wk-Oq
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:58:54 -0500
In-Reply-To: <20170102205536.4151-1-jcd@tribudubois.net>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <148339072405.142.1092059694938121726@790289a7ca88>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 2 Jan 2017 12:58:44 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] [i.MX] Remove MSGDATA register support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jcd@tribudubois.net
Cc: famz@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org, mar.krzeminski@gmail.com

SGksCgpZb3VyIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSF0gW2kuTVhdIFJlbW92ZSBNU0dEQVRBIHJlZ2lzdGVyIHN1cHBvcnQuCk1l
c3NhZ2UtaWQ6IDIwMTcwMTAyMjA1NTM2LjQxNTEtMS1qY2RAdHJpYnVkdWJvaXMubmV0ClR5cGU6
IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNl
Cm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAK
CiMgVXNlZnVsIGdpdCBvcHRpb25zCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0
IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIkKGdpdCBs
b2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsgZG8K
ICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1mb3Jt
YXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4vc2Ny
aXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0xCiAg
ICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBU
RVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0
NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11
CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAxNzAxMDIyMDU1MzYuNDE1MS0xLWpjZEB0
cmlidWR1Ym9pcy5uZXQgLT4gcGF0Y2hldy8yMDE3MDEwMjIwNTUzNi40MTUxLTEtamNkQHRyaWJ1
ZHVib2lzLm5ldApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjQ1ZmVjMjcgUmVtb3Zl
IE1TR0RBVEEgcmVnaXN0ZXIgc3VwcG9ydC4KCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5n
IFBBVENIIDEvMTogUmVtb3ZlIE1TR0RBVEEgcmVnaXN0ZXIgc3VwcG9ydC4uLi4KRVJST1I6IGNv
ZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMzU6IEZJTEU6IGh3L3NzaS9pbXhfc3Bp
LmM6MzgyOgorXkkvKiBBbnl3YXkgaXQgaXMgbm90IHVzZWQgYnkgTGludXggZHJpdmVyICovJAoK
RVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMzY6IEZJTEU6IGh3L3Nz
aS9pbXhfc3BpLmM6MzgzOgorXkkvKiBTbyBmb3Igbm93IHdlIGp1c3QgaWdub3JlIGl0ICovJAoK
dG90YWw6IDIgZXJyb3JzLCAwIHdhcm5pbmdzLCAyMyBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNo
IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJv
cnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2Vl
CkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29t
bWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNh
bGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZl
ZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
