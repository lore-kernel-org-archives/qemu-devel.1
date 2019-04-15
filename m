Received: from eggs.gnu.org ([209.51.188.92]:59774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hG0i8-00045q-VV
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hG0i7-0005mU-TD
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:27:44 -0400
Resent-Message-Id: <E1hG0i7-0005mU-TD@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hG0i7-0005mK-Lk
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:27:43 -0400
Message-ID: <155533122467.29694.15903663744275078359@76452e4e88f2>
In-Reply-To: <20190415121740.9881-1-dgilbert@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 15 Apr 2019 05:27:05 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v3] slirp: Gcc 9 -O3 fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com
Cc: fam@euphon.net, qemu-devel@nongnu.org, samuel.thibault@gnu.org, jan.kiszka@siemens.com

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQxNTEyMTc0MC45ODgx
LTEtZGdpbGJlcnRAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAxOTA0MTUxMjE3NDAuOTg4MS0xLWRnaWxiZXJ0QHJl
ZGhhdC5jb20KU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCB2M10gc2xpcnA6IEdjYyA5IC1P
MyBmaXgKVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNo
CmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRy
dWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMv
Y2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoK
VXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0
dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAg
ICAgICAgICBwYXRjaGV3LzIwMTkwNDE1MTIxNzQwLjk4ODEtMS1kZ2lsYmVydEByZWRoYXQuY29t
IC0+IHBhdGNoZXcvMjAxOTA0MTUxMjE3NDAuOTg4MS0xLWRnaWxiZXJ0QHJlZGhhdC5jb20KU3dp
dGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwpkZDY3ZmJhYTQwIHNsaXJwOiBHY2MgOSAtTzMg
Zml4Cgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVy
IHVzZSB0YWJzCiMyMjogRklMRTogc2xpcnAvc3JjL3NvY2tldC5jOjE3NDoKK15Jc2l6ZV90IGJ1
Zl9sZW47JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMzE6IEZJ
TEU6IHNsaXJwL3NyYy9zb2NrZXQuYzoxODU6CiteSWJ1Zl9sZW4gPSBzb3ByZXByYnVmKHNvLCBp
b3YsICZuKTskCgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiMzMjog
RklMRTogc2xpcnAvc3JjL3NvY2tldC5jOjE4NjoKK15JYXNzZXJ0KGJ1Zl9sZW4gIT0gMCk7JAoK
RVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojNDA6IEZJTEU6IHNsaXJw
L3NyYy9zb2NrZXQuYzoyNjI6CiteSWFzc2VydChzaXplID4gMCk7JAoKdG90YWw6IDQgZXJyb3Jz
LCAwIHdhcm5pbmdzLCAyMyBsaW5lcyBjaGVja2VkCgpDb21taXQgZGQ2N2ZiYWE0MDAzIChzbGly
cDogR2NjIDkgLU8zIGZpeCkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYg
YW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRo
ZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBF
TkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBp
cyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA0MTUxMjE3NDAuOTg4
MS0xLWRnaWxiZXJ0QHJlZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2Uu
Ci0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3Bh
dGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBy
ZWRoYXQuY29t
