Received: from eggs.gnu.org ([209.51.188.92]:37958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hDU2j-0003SG-Sr
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 09:10:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hDU2h-0002Wc-2w
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 09:10:33 -0400
Resent-Message-Id: <E1hDU2h-0002Wc-2w@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hDU2g-0002Sj-Bm
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 09:10:30 -0400
Message-ID: <155472899779.12882.1060697470938678321@76452e4e88f2>
In-Reply-To: <20190408130450.12233-1-ghorges@xiyoulinux.org>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 8 Apr 2019 06:09:59 -0700 (PDT)
Subject: Re: [Qemu-devel] Wshadow in qemu/linux-user/syscall.c:Changed some
 variable names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ghorges@xiyoulinux.org
Cc: fam@euphon.net, qemu-devel@nongnu.org, riku.voipio@iki.fi, laurent@vivier.eu

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQwODEzMDQ1MC4xMjIz
My0xLWdob3JnZXNAeGl5b3VsaW51eC5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMTkwNDA4MTMwNDUwLjEyMjMzLTEtZ2hvcmdl
c0B4aXlvdWxpbnV4Lm9yZwpUeXBlOiBzZXJpZXMKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFdzaGFk
b3cgaW4gcWVtdS9saW51eC11c2VyL3N5c2NhbGwuYzpDaGFuZ2VkIHNvbWUgdmFyaWFibGUgbmFt
ZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBi
YXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVs
aW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0t
bWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVh
OWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29t
L3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAxOTA0
MDgxMzA0NTAuMTIyMzMtMS1naG9yZ2VzQHhpeW91bGludXgub3JnIC0+IHBhdGNoZXcvMjAxOTA0
MDgxMzA0NTAuMTIyMzMtMS1naG9yZ2VzQHhpeW91bGludXgub3JnClN3aXRjaGVkIHRvIGEgbmV3
IGJyYW5jaCAndGVzdCcKODg2NGE1NSBXc2hhZG93IGluIHFlbXUvbGludXgtdXNlci9zeXNjYWxs
LmM6Q2hhbmdlZCBzb21lIHZhcmlhYmxlIG5hbWVzCgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJP
UjogTWlzc2luZyBTaWduZWQtb2ZmLWJ5OiBsaW5lKHMpCgp0b3RhbDogMSBlcnJvcnMsIDAgd2Fy
bmluZ3MsIDE2MCBsaW5lcyBjaGVja2VkCgpDb21taXQgODg2NGE1NTIwZTljIChXc2hhZG93IGlu
IHFlbXUvbGludXgtdXNlci9zeXNjYWxsLmM6Q2hhbmdlZCBzb21lIHZhcmlhYmxlIG5hbWVzKSBo
YXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3Jz
CmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpD
SEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFu
ZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRw
Oi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDQwODEzMDQ1MC4xMjIzMy0xLWdob3JnZXNAeGl5b3Vs
aW51eC5vcmcvdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5l
cmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBs
ZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t
