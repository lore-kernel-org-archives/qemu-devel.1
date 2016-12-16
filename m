Received: from eggs.gnu.org ([2001:4830:134:3::10]:57427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cHuUH-0000f6-8Q
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 10:32:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cHuUB-0006Vn-F8
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 10:31:57 -0500
Resent-Message-Id: <E1cHuUB-0006Vn-F8@eggs.gnu.org>
Received: from sender163-mail.zoho.com ([74.201.84.163]:21478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1cHuUB-0006TA-78
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 10:31:51 -0500
In-Reply-To: <20161216152319.12494-1-leif.lindholm@linaro.org>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <148190229929.31.16691558559376474137@790289a7ca88>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 16 Dec 2016 07:31:40 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] smbios: stop ignoring command line options
 for TARGET_ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: leif.lindholm@linaro.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org

SGksCgpZb3VyIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzClN1
YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hdIHNtYmlvczogc3RvcCBpZ25vcmluZyBjb21tYW5k
IGxpbmUgb3B0aW9ucyBmb3IgVEFSR0VUX0FSTQpNZXNzYWdlLWlkOiAyMDE2MTIxNjE1MjMxOS4x
MjQ5NC0xLWxlaWYubGluZGhvbG1AbGluYXJvLm9yZwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09
PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRC
QVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAKCiMgVXNlZnVsIGdpdCBvcHRpb25zCmdpdCBjb25maWcg
LS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1l
cyBUcnVlCgpjb21taXRzPSIkKGdpdCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4p
Igpmb3IgYyBpbiAkY29tbWl0czsgZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3Rh
bDogJChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAk
YyAtLWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsg
dGhlbgogICAgICAgIGZhaWxlZD0xCiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkK
ZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhj
ZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIu
Y29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMTQ4
MTkwMTk2OTI1LjI1NTA0LjEyODMwNDY2MTM3NjAxNTcxMTIzLnN0Z2l0QGJhaGlhIC0+IHBhdGNo
ZXcvMTQ4MTkwMTk2OTI1LjI1NTA0LjEyODMwNDY2MTM3NjAxNTcxMTIzLnN0Z2l0QGJhaGlhCiAq
IFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAxNjEyMTYxNTIzMTkuMTI0OTQtMS1sZWlmLmxp
bmRob2xtQGxpbmFyby5vcmcgLT4gcGF0Y2hldy8yMDE2MTIxNjE1MjMxOS4xMjQ5NC0xLWxlaWYu
bGluZGhvbG1AbGluYXJvLm9yZwpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmY5MDI1
ZGMgc21iaW9zOiBzdG9wIGlnbm9yaW5nIGNvbW1hbmQgbGluZSBvcHRpb25zIGZvciBUQVJHRVRf
QVJNCgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6IHNtYmlvczogc3Rv
cCBpZ25vcmluZyBjb21tYW5kIGxpbmUgb3B0aW9ucyBmb3IgVEFSR0VUX0FSTS4uLgpFUlJPUjog
ZG8gbm90IGluaXRpYWxpc2UgZ2xvYmFscyB0byAwIG9yIE5VTEwKIzU0OiBGSUxFOiB2bC5jOjE2
MjoKK2ludCBzbWJpb3Nfb3ZlcnJpZGUgPSAwOwoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdz
LCAzMiBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNl
IHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBv
cnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMu
Cgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoK
LS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRj
aGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJl
ZWxpc3RzLm9yZw==
