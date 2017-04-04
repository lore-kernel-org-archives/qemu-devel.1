Received: from eggs.gnu.org ([2001:4830:134:3::10]:53227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cvU0v-0005H8-2F
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 15:21:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cvU0r-0004q0-SF
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 15:21:13 -0400
Resent-Message-Id: <E1cvU0r-0004q0-SF@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1cvU0r-0004pi-LC
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 15:21:09 -0400
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <149133364807.26085.1911321609090379006@6c512846dbc7>
In-Reply-To: <20170403235636.5647-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 4 Apr 2017 12:20:48 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v3 0/1] slirp: add SOCKS5 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: laurent@vivier.eu
Cc: famz@redhat.com, samuel.thibault@ens-lyon.org, jasowang@redhat.com, qemu-devel@nongnu.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSCB2MyAwLzFdIHNsaXJwOiBhZGQgU09DS1M1IHN1cHBvcnQKVHlwZTogc2Vy
aWVzCk1lc3NhZ2UtaWQ6IDIwMTcwNDAzMjM1NjM2LjU2NDctMS1sYXVyZW50QHZpdmllci5ldQoK
PT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3Rh
bD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAKCiMgVXNlZnVs
IGdpdCBvcHRpb25zCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIkKGdpdCBsb2cgLS1mb3Jt
YXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsgZG8KICAgIGVjaG8g
IkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMp
Li4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVj
a3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0xCiAgICAgICAgZWNo
bwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBURVNUIFNDUklQ
VCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEz
Mzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNTBhNTczNSBzbGlycDogYWRkIFNP
Q0tTNSBzdXBwb3J0Cgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6IHNs
aXJwOiBhZGQgU09DS1M1IHN1cHBvcnQuLi4KRVJST1I6IHN1c3BlY3QgY29kZSBpbmRlbnQgZm9y
IGNvbmRpdGlvbmFsIHN0YXRlbWVudHMgKDQsIDYpCiM3NDE6IEZJTEU6IHNsaXJwL3RjcF9zdWJy
LmM6NDI4OgorICAgIGlmIChzby0+c29fcHJveHlfc3RhdGUpIHsKKyAgICAgIHJldCA9IHNvY2tz
NV9jb25uZWN0KHMsIHNsaXJwLT5wcm94eV9zZXJ2ZXIsIHNsaXJwLT5wcm94eV9wb3J0LAoKdG90
YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA2ODcgbGluZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBo
YXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3Jz
CmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpD
SEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1h
bmQgZXhpdGVkIHdpdGggY29kZTogMQoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxs
eSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVk
YmFjayB0byBwYXRjaGV3LWRldmVsQGZyZWVsaXN0cy5vcmc=
