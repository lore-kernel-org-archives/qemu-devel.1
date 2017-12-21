Received: from eggs.gnu.org ([2001:4830:134:3::10]:53270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eS4G6-0000oh-I3
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 12:03:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eS4G2-0005qF-7k
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 12:03:50 -0500
Resent-Message-Id: <E1eS4G2-0005qF-7k@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1eS4G1-0005m6-TB
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 12:03:46 -0500
In-Reply-To: <20171221155905.3793-1-berrange@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151387305838.99.508098824580499746@5adcb62bf0d6>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 21 Dec 2017 08:17:39 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Enable passing pre-opened chardev
 socket FDs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, armbru@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTcxMjIxMTU1OTA1LjM3OTMtMS1iZXJyYW5nZUByZWRoYXQuY29tClN1Ympl
Y3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggdjIgMC8yXSBFbmFibGUgcGFzc2luZyBwcmUtb3BlbmVk
IGNoYXJkZXYgc29ja2V0IEZEcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFz
aAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3YyAt
bCkKZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIkKGdpdCBsb2cgLS1mb3Jt
YXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsgZG8KICAgIGVjaG8g
IkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMp
Li4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVj
a3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0xCiAgICAgICAgZWNo
bwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBURVNUIFNDUklQ
VCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEz
Mzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcg
dGFnXSAgICAgICAgICAgICAgIHBhdGNoZXcvMjAxNzEyMjExNjA1NTguMTQxNTEtMS1sYXVyZW50
QHZpdmllci5ldSAtPiBwYXRjaGV3LzIwMTcxMjIxMTYwNTU4LjE0MTUxLTEtbGF1cmVudEB2aXZp
ZXIuZXUKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo2MTE2ZGUyMjIyIGNoYXI6IGFs
bG93IHBhc3NpbmcgcHJlLW9wZW5lZCBzb2NrZXQgZmlsZSBkZXNjcmlwdG9yIGF0IHN0YXJ0dXAK
ODlkODliNzQ5YyBpbzogbW92ZSBmZF9pc19zb2NrZXQoKSBpbnRvIGNvbW1vbiBzb2NrZXRzIGNv
ZGUKCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMjogaW86IG1vdmUgZmRf
aXNfc29ja2V0KCkgaW50byBjb21tb24gc29ja2V0cyBjb2RlLi4uCkNoZWNraW5nIFBBVENIIDIv
MjogY2hhcjogYWxsb3cgcGFzc2luZyBwcmUtb3BlbmVkIHNvY2tldCBmaWxlIGRlc2NyaXB0b3Ig
YXQgc3RhcnR1cC4uLgpFUlJPUjogZG8gbm90IGluaXRpYWxpc2UgZ2xvYmFscyB0byAwIG9yIE5V
TEwKIzI1NTogRklMRTogdGVzdHMvdGVzdC1jaGFyLmM6NDE0OgorTW9uaXRvciAqY3VyX21vbiA9
IE5VTEw7Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDMzMCBsaW5lcyBjaGVja2VkCgpZ
b3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0
aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRh
aW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0K
ClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBh
dXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2Vu
ZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
