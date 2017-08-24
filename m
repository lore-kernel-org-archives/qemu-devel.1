Received: from eggs.gnu.org ([2001:4830:134:3::10]:39109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dks0D-0006Zn-4k
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dks09-00073T-5H
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:16:53 -0400
Resent-Message-Id: <E1dks09-00073T-5H@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1dks08-00072n-TC
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:16:49 -0400
Message-ID: <150358058217.105.4685389509065985883@205a2245145f>
Reply-To: <qemu-devel@nongnu.org>
In-Reply-To: <20170824121919.78678-3-roger.pau@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 24 Aug 2017 06:16:23 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH QEMU v2] xen/pt: allow QEMU to request MSI
 unmasking at bind time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: roger.pau@citrix.com
Cc: famz@redhat.com, xen-devel@lists.xenproject.org, anthony.perard@citrix.com, sstabellini@kernel.org, qemu-devel@nongnu.org, JBeulich@suse.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTcwODI0MTIxOTE5Ljc4Njc4LTMtcm9nZXIucGF1QGNpdHJpeC5jb20KU3Vi
amVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCBRRU1VIHYyXSB4ZW4vcHQ6IGFsbG93IFFFTVUgdG8g
cmVxdWVzdCBNU0kgdW5tYXNraW5nIGF0IGJpbmQgdGltZQoKPT09IFRFU1QgU0NSSVBUIEJFR0lO
ID09PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5l
ICRCQVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFt
ZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIk
KGdpdCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0
czsgZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEg
LS1mb3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8
IC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxl
ZD0xCiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVk
Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQx
ZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVj
dC9xZW11CiB0IFt0YWcgdXBkYXRlXSAgICAgICAgICAgIHBhdGNoZXcvMjAxNzA4MjQxMjE5MTku
Nzg2NzgtMy1yb2dlci5wYXVAY2l0cml4LmNvbSAtPiBwYXRjaGV3LzIwMTcwODI0MTIxOTE5Ljc4
Njc4LTMtcm9nZXIucGF1QGNpdHJpeC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0
JwoyYjdkNDgzMDQ0IHhlbi9wdDogYWxsb3cgUUVNVSB0byByZXF1ZXN0IE1TSSB1bm1hc2tpbmcg
YXQgYmluZCB0aW1lCgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6IHhl
bi9wdDogYWxsb3cgUUVNVSB0byByZXF1ZXN0IE1TSSB1bm1hc2tpbmcgYXQgYmluZCB0aW1lLi4u
CkVSUk9SOiBicmFjZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0
ZW1lbnQKIzU5OiBGSUxFOiBody94ZW4veGVuX3B0X2NvbmZpZ19pbml0LmM6MTMyNToKKyAgICBp
ZiAocmMpClsuLi5dCgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDg4IGxpbmVzIGNoZWNr
ZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55
IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBt
YWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5E
ID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJh
dGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFz
ZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
