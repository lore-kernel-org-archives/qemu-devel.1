Received: from eggs.gnu.org ([2001:4830:134:3::10]:35370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dTGXC-0002Su-JU
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:50:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dTGX8-0007wp-AP
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:50:10 -0400
Resent-Message-Id: <E1dTGX8-0007wp-AP@eggs.gnu.org>
In-Reply-To: <1498733831-15254-1-git-send-email-pl@kamp.de>
Message-ID: <149938499324.27.18405371128773967269@7a482c8a7db2>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 6 Jul 2017 16:49:53 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH V2 0/8] add Qcow2 compress format extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pl@kamp.de
Cc: famz@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, lersek@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSCBWMiAwLzhdIGFkZCBRY293MiBjb21wcmVzcyBmb3JtYXQgZXh0ZW5zaW9u
Ck1lc3NhZ2UtaWQ6IDE0OTg3MzM4MzEtMTUyNTQtMS1naXQtc2VuZC1lbWFpbC1wbEBrYW1wLmRl
ClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAoKQkFT
RT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3YyAtbCkKZmFp
bGVkPTAKCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAt
LWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIkKGdpdCBsb2cgLS1mb3JtYXQ9JUgg
LS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsgZG8KICAgIGVjaG8gIkNoZWNr
aW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMpLi4uIgog
ICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVja3BhdGNo
LnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0xCiAgICAgICAgZWNobwogICAg
ZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBURVNUIFNDUklQVCBFTkQg
PT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CmZh
dGFsOiBDYW5ub3QgdXBkYXRlIHBhdGhzIGFuZCBzd2l0Y2ggdG8gYnJhbmNoICd0ZXN0JyBhdCB0
aGUgc2FtZSB0aW1lLgpEaWQgeW91IGludGVuZCB0byBjaGVja291dCAnb3JpZ2luL3BhdGNoZXcv
MTQ5ODczMzgzMS0xNTI1NC0xLWdpdC1zZW5kLWVtYWlsLXBsQGthbXAuZGUnIHdoaWNoIGNhbiBu
b3QgYmUgcmVzb2x2ZWQgYXMgY29tbWl0PwpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFz
dCk6CiAgRmlsZSAiL2hvbWUvZmFtL2Jpbi9wYXRjaGV3IiwgbGluZSA0NDAsIGluIHRlc3Rfb25l
CiAgICBnaXRfY2xvbmVfcmVwbyhjbG9uZSwgclsicmVwbyJdLCByWyJoZWFkIl0sIGxvZ2YpCiAg
RmlsZSAiL2hvbWUvZmFtL2Jpbi9wYXRjaGV3IiwgbGluZSA1MywgaW4gZ2l0X2Nsb25lX3JlcG8K
ICAgIGN3ZD1jbG9uZSkKICBGaWxlICIvdXNyL2xpYjY0L3B5dGhvbjMuNS9zdWJwcm9jZXNzLnB5
IiwgbGluZSAyNzEsIGluIGNoZWNrX2NhbGwKICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihy
ZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ2dp
dCcsICdjaGVja291dCcsICdvcmlnaW4vcGF0Y2hldy8xNDk4NzMzODMxLTE1MjU0LTEtZ2l0LXNl
bmQtZW1haWwtcGxAa2FtcC5kZScsICctYicsICd0ZXN0J10nIHJldHVybmVkIG5vbi16ZXJvIGV4
aXQgc3RhdHVzIDEyOAoKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0
Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8g
cGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
