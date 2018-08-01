Received: from eggs.gnu.org ([2001:4830:134:3::10]:48358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fkvaZ-0005mF-Qo
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 14:11:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fkvaV-0000MM-Ow
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 14:11:11 -0400
Resent-Message-Id: <E1fkvaV-0000MM-Ow@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1fkvaV-0000LZ-Dk
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 14:11:07 -0400
In-Reply-To: <20180801102944.23457-1-laurent@vivier.eu>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <153314702483.10779.18366168385885686362@502c9da6d61e>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 1 Aug 2018 11:10:26 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] qemu-binfmt-conf.sh: add x86_64 target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: laurent@vivier.eu
Cc: famz@redhat.com, qemu-devel@nongnu.org, agentlecomputer@gmail.com, thuth@redhat.com, riku.voipio@iki.fi

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwODAxMTAyOTQ0LjIzNDU3LTEtbGF1cmVudEB2aXZpZXIuZXUKU3ViamVj
dDogW1FlbXUtZGV2ZWxdIFtQQVRDSF0gcWVtdS1iaW5mbXQtY29uZi5zaDogYWRkIHg4Nl82NCB0
YXJnZXQKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKCkJBU0U9YmFzZQpu
PTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAkQkFTRS4uIHwgd2MgLWwpCmZhaWxlZD0wCgpn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9n
cmFtCgpjb21taXRzPSIkKGdpdCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpm
b3IgYyBpbiAkY29tbWl0czsgZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDog
JChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAt
LWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhl
bgogICAgICAgIGZhaWxlZD0xCiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9u
ZQoKZXhpdCAkZmFpbGVkCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVh
OWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5j
aCAndGVzdCcKNTBlNmNjM2ExMiBxZW11LWJpbmZtdC1jb25mLnNoOiBhZGQgeDg2XzY0IHRhcmdl
dAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KQ2hlY2tpbmcgUEFUQ0ggMS8xOiBxZW11LWJpbmZtdC1j
b25mLnNoOiBhZGQgeDg2XzY0IHRhcmdldC4uLgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFj
dGVycwojMjg6IEZJTEU6IHNjcmlwdHMvcWVtdS1iaW5mbXQtY29uZi5zaDoxNzoKK3g4Nl82NF9t
YWdpYz0nXHg3ZkVMRlx4MDJceDAxXHgwMVx4MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDAw
XHgwMFx4MDJceDAwXHgzZVx4MDAnCgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzI5
OiBGSUxFOiBzY3JpcHRzL3FlbXUtYmluZm10LWNvbmYuc2g6MTg6Cit4ODZfNjRfbWFzaz0nXHhm
Zlx4ZmZceGZmXHhmZlx4ZmZceGZlXHhmZVx4MDBceGZmXHhmZlx4ZmZceGZmXHhmZlx4ZmZceGZm
XHhmZlx4ZmVceGZmXHhmZlx4ZmYnCgp0b3RhbDogMSBlcnJvcnMsIDEgd2FybmluZ3MsIDE4IGxp
bmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3
LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVt
IHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBP
VVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1h
aWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3Jn
L10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t
