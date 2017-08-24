Received: from eggs.gnu.org ([2001:4830:134:3::10]:36217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dknh9-0001ef-1p
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:40:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dknh4-0006EI-A6
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:40:55 -0400
Resent-Message-Id: <E1dknh4-0006EI-A6@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1dknh4-0006E6-2B
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:40:50 -0400
Message-ID: <150356403268.99.18335519915378603095@205a2245145f>
Reply-To: <qemu-devel@nongnu.org>
In-Reply-To: <20170824081305.8445-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 24 Aug 2017 01:40:33 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH 0/2] qxl: add support for chunked cursors.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, rene@exactcode.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTcwODI0MDgxMzA1Ljg0NDUtMS1rcmF4ZWxAcmVkaGF0LmNvbQpTdWJqZWN0
OiBbUWVtdS1kZXZlbF0gW1BBVENIIDAvMl0gcXhsOiBhZGQgc3VwcG9ydCBmb3IgY2h1bmtlZCBj
dXJzb3JzLgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNl
Cm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAK
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIkKGdpdCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZl
cnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsgZG8KICAgIGVjaG8gIkNoZWNraW5nIFBB
VENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMpLi4uIgogICAgaWYg
ISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0t
bWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0xCiAgICAgICAgZWNobwogICAgZmkKICAg
IG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpV
cGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVk
IHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKMDA4YmJhY2I5YiBxeGw6IGFkZCBzdXBwb3J0IGZvciBj
aHVua2VkIGN1cnNvcnMuCjFiOWEyZTM5ZTggcXhsOiBkcm9wIG1vbm8gY3Vyc29yIHN1cHBvcnQK
Cj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMjogcXhsOiBkcm9wIG1vbm8g
Y3Vyc29yIHN1cHBvcnQuLi4KQ2hlY2tpbmcgUEFUQ0ggMi8yOiBxeGw6IGFkZCBzdXBwb3J0IGZv
ciBjaHVua2VkIGN1cnNvcnMuLi4uCkVSUk9SOiBicmFjZXMge30gYXJlIG5lY2Vzc2FyeSBmb3Ig
YWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1lbnQKIzI5OiBGSUxFOiBody9kaXNwbGF5L3F4bC1yZW5k
ZXIuYzoyMTg6CisgICAgICAgIGlmIChvZmZzZXQgPT0gc2l6ZSkKWy4uLl0KCkVSUk9SOiBicmFj
ZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1lbnQKIzMyOiBG
SUxFOiBody9kaXNwbGF5L3F4bC1yZW5kZXIuYzoyMjE6CisgICAgICAgIGlmICghY2h1bmspClsu
Li5dCgp0b3RhbDogMiBlcnJvcnMsIDAgd2FybmluZ3MsIDUxIGxpbmVzIGNoZWNrZWQKCllvdXIg
cGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNl
IGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVy
LCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVz
dCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9t
YXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlv
dXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
