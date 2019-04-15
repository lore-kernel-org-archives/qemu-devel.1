Received: from eggs.gnu.org ([209.51.188.92]:56268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hG0P9-0006Q5-7q
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hG0P8-0006VO-5H
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:08:07 -0400
Resent-Message-Id: <E1hG0P8-0006VO-5H@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hG0P7-0006VC-TW
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:08:06 -0400
Message-ID: <155533004608.29694.13253782465233935680@76452e4e88f2>
In-Reply-To: <20190415120205.2221-1-dgilbert@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 15 Apr 2019 05:07:27 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2] slirp: Gcc 9 -O3 fix
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQxNTEyMDIwNS4yMjIx
LTEtZGdpbGJlcnRAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAxOTA0MTUxMjAyMDUuMjIyMS0xLWRnaWxiZXJ0QHJl
ZGhhdC5jb20KU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCB2Ml0gc2xpcnA6IEdjYyA5IC1P
MyBmaXgKVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNo
CmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRy
dWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMv
Y2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoK
VXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0
dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAg
ICAgICAgICBwYXRjaGV3LzIwMTkwNDE1MTIwMjA1LjIyMjEtMS1kZ2lsYmVydEByZWRoYXQuY29t
IC0+IHBhdGNoZXcvMjAxOTA0MTUxMjAyMDUuMjIyMS0xLWRnaWxiZXJ0QHJlZGhhdC5jb20KU3dp
dGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo4MWU0ZDlkZDgzIHNsaXJwOiBHY2MgOSAtTzMg
Zml4Cgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVy
IHVzZSB0YWJzCiMyMzogRklMRTogc2xpcnAvc3JjL3NvY2tldC5jOjE4NDoKK15JYXNzZXJ0KHNv
cHJlcHJidWYoc28sIGlvdiwgJm4pICE9IDApOyQKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQg
bmV2ZXIgdXNlIHRhYnMKIzMxOiBGSUxFOiBzbGlycC9zcmMvc29ja2V0LmM6MjYwOgorXklhc3Nl
cnQoc2l6ZSA+IDApOyQKCnRvdGFsOiAyIGVycm9ycywgMCB3YXJuaW5ncywgMTUgbGluZXMgY2hl
Y2tlZAoKQ29tbWl0IDgxZTRkOWRkODNlMCAoc2xpcnA6IEdjYyA5IC1PMyBmaXgpIGhhcyBzdHls
ZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZh
bHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFU
Q0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRl
ZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRj
aGV3Lm9yZy9sb2dzLzIwMTkwNDE1MTIwMjA1LjIyMjEtMS1kZ2lsYmVydEByZWRoYXQuY29tL3Rl
c3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9t
YXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5
b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==
