Received: from eggs.gnu.org ([209.51.188.92]:46898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1glQdJ-0001Nc-Nv
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 22:52:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1glQdI-0003w2-Ij
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 22:52:21 -0500
Resent-Message-Id: <E1glQdI-0003w2-Ij@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1glQdI-0003uf-7Y
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 22:52:20 -0500
Reply-To: <qemu-devel@nongnu.org>
In-Reply-To: <20190115115047.39326-1-alex.kanavin@gmail.com>
Message-ID: <154804271034.5550.6374171533442637951@2d3111e9616b>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sun, 20 Jan 2019 19:51:51 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] egl-helpers.h: add a missing X11 include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.kanavin@gmail.com
Cc: fam@euphon.net, qemu-devel@nongnu.org

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDExNTExNTA0Ny4zOTMy
Ni0xLWFsZXgua2FuYXZpbkBnbWFpbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRo
ZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5n
IGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0
YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0Bm
ZWRvcmEgU0hPV19FTlY9MSBKPTE0Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAg
Y2hhcmRldi90ZXN0ZGV2Lm8KICBDQyAgICAgIGRpc2FzL2FybS5vCi90bXAvcWVtdS10ZXN0L3Ny
Yy9ibG9jay9zaGVlcGRvZy5jOiBJbiBmdW5jdGlvbiAnZmluZF92ZGlfbmFtZSc6Ci90bXAvcWVt
dS10ZXN0L3NyYy9ibG9jay9zaGVlcGRvZy5jOjEyMzk6NTogZXJyb3I6ICdzdHJuY3B5JyBzcGVj
aWZpZWQgYm91bmQgMjU2IGVxdWFscyBkZXN0aW5hdGlvbiBzaXplIFstV2Vycm9yPXN0cmluZ29w
LXRydW5jYXRpb25dCiAgICAgc3RybmNweShidWYgKyBTRF9NQVhfVkRJX0xFTiwgdGFnLCBTRF9N
QVhfVkRJX1RBR19MRU4pOwogICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVy
cm9ycwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xv
Z3MvMjAxOTAxMTUxMTUwNDcuMzkzMjYtMS1hbGV4LmthbmF2aW5AZ21haWwuY29tL3Rlc3Rpbmcu
ZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1
dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5k
IHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t
