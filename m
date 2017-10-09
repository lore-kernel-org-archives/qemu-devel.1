Received: from eggs.gnu.org ([2001:4830:134:3::10]:34916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1e1azq-0004K1-Kc
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 12:33:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1e1azY-00008p-4G
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 12:33:38 -0400
Resent-Message-Id: <E1e1azY-00008p-4G@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1e1azX-0008PG-Rm
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 12:33:20 -0400
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <150756673596.261.13431247368132967890@b58463cdfd5f>
In-Reply-To: <20171009151926.1708-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 9 Oct 2017 09:32:16 -0700 (PDT)
Subject: Re: [Qemu-devel] [RFC PATCH] linux-user/main: support dfilter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, riku.voipio@iki.fi, laurent@vivier.eu

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTcxMDA5MTUxOTI2LjE3MDgtMS1hbGV4LmJlbm5lZUBsaW5hcm8ub3JnClN1
YmplY3Q6IFtRZW11LWRldmVsXSBbUkZDIFBBVENIXSBsaW51eC11c2VyL21haW46IHN1cHBvcnQg
ZGZpbHRlcgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNl
Cm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAK
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIkKGdpdCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZl
cnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsgZG8KICAgIGVjaG8gIkNoZWNraW5nIFBB
VENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMpLi4uIgogICAgaWYg
ISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0t
bWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0xCiAgICAgICAgZWNobwogICAgZmkKICAg
IG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpV
cGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0
cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAg
ICAgICAgIHBhdGNoZXcvMTUwNzU2NDkwMi05MDAwLTEtZ2l0LXNlbmQtZW1haWwtaWFuLmphY2tz
b25AZXUuY2l0cml4LmNvbSAtPiBwYXRjaGV3LzE1MDc1NjQ5MDItOTAwMC0xLWdpdC1zZW5kLWVt
YWlsLWlhbi5qYWNrc29uQGV1LmNpdHJpeC5jb20KIHQgW3RhZyB1cGRhdGVdICAgICAgICAgICAg
cGF0Y2hldy8yMDE3MTAwOTE1MTkyNi4xNzA4LTEtYWxleC5iZW5uZWVAbGluYXJvLm9yZyAtPiBw
YXRjaGV3LzIwMTcxMDA5MTUxOTI2LjE3MDgtMS1hbGV4LmJlbm5lZUBsaW5hcm8ub3JnCiAqIFtu
ZXcgdGFnXSAgICAgICAgICAgICAgIHBhdGNoZXcvMjAxNzEwMDkxNTU0MzEuMTQwOTMtMS1tcmVp
dHpAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMTcxMDA5MTU1NDMxLjE0MDkzLTEtbXJlaXR6QHJl
ZGhhdC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwowNTE1OGIwZTZhIGxpbnV4
LXVzZXIvbWFpbjogc3VwcG9ydCBkZmlsdGVyCgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2lu
ZyBQQVRDSCAxLzE6IGxpbnV4LXVzZXIvbWFpbjogc3VwcG9ydCBkZmlsdGVyLi4uCkVSUk9SOiBz
cGFjZSByZXF1aXJlZCBhZnRlciB0aGF0ICcsJyAoY3R4OlZ4VikKIzM0OiBGSUxFOiBsaW51eC11
c2VyL21haW4uYzo0MDYzOgorICAgICAicmFuZ2VbLC4uLl0iLCJmaWx0ZXIgbG9nZ2luZyBiYXNl
ZCBvbiBhZGRyZXNzIHJhbmdlIn0sCiAgICAgICAgICAgICAgICAgICBeCgp0b3RhbDogMSBlcnJv
cnMsIDAgd2FybmluZ3MsIDE5IGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHBy
b2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2Ug
cG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBp
biBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3
aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hl
dyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0
Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
