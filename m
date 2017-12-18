Received: from eggs.gnu.org ([2001:4830:134:3::10]:56044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eR4wi-0002qq-6B
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 18:35:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eR4wf-0002jX-44
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 18:35:44 -0500
Resent-Message-Id: <E1eR4wf-0002jX-44@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1eR4we-0002iV-QI
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 18:35:41 -0500
In-Reply-To: <1513606078-728-1-git-send-email-stefanb@linux.vnet.ibm.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151361214442.51.2461913259732164138@5adcb62bf0d6>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 18 Dec 2017 07:49:05 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] tpm: Fix linker error when using
 --disable-tpm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanb@linux.vnet.ibm.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, thuth@redhat.com, peter.maydell@linaro.org, marcandre.lureau@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDE1MTM2MDYwNzgtNzI4LTEtZ2l0LXNlbmQtZW1haWwtc3RlZmFuYkBsaW51eC52
bmV0LmlibS5jb20KU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSF0gdHBtOiBGaXggbGlua2Vy
IGVycm9yIHdoZW4gdXNpbmcgLS1kaXNhYmxlLXRwbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09
PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRC
QVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxp
bWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIkKGdp
dCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsg
ZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1m
b3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4v
c2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0x
CiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09
PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVm
N2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKZmJjZjA0MjZj
ZCB0cG06IEZpeCBsaW5rZXIgZXJyb3Igd2hlbiB1c2luZyAtLWRpc2FibGUtdHBtCgo9PT0gT1VU
UFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6IHRwbTogRml4IGxpbmtlciBlcnJvciB3
aGVuIHVzaW5nIC0tZGlzYWJsZS10cG0uLi4KRVJST1I6IGFkZGluZyBhIGxpbmUgd2l0aG91dCBu
ZXdsaW5lIGF0IGVuZCBvZiBmaWxlCiM0NDogRklMRTogc3R1YnMvdHBtLmM6NDk6Cit9Cgp0b3Rh
bDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDI1IGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFz
IHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwph
cmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hF
Q0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5k
IGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkg
YnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJh
Y2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
