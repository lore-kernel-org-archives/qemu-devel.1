Received: from eggs.gnu.org ([209.51.188.92]:55977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hCUE2-00071p-Uu
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 15:10:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hCUDs-0008RH-PT
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 15:10:00 -0400
Resent-Message-Id: <E1hCUDs-0008RH-PT@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hCUDR-0005zl-Ew
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 15:09:56 -0400
Message-ID: <155449131270.12882.4943932009756547608@76452e4e88f2>
In-Reply-To: <20190405184648.17029-1-dgilbert@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 5 Apr 2019 12:08:33 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] slirp: Gcc 9 -O3 fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com
Cc: fam@euphon.net, qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQwNTE4NDY0OC4xNzAy
OS0xLWRnaWxiZXJ0QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2
ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBp
bmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMTkwNDA1MTg0NjQ4LjE3MDI5LTEtZGdpbGJlcnRA
cmVkaGF0LmNvbQpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSBzbGlycDogR2NjIDkgLU8z
IGZpeApUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gK
Z2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1
ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9j
aGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpV
cGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0
cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAg
ICAgICAgIHBhdGNoZXcvMjAxOTA0MDUxODQ2NDguMTcwMjktMS1kZ2lsYmVydEByZWRoYXQuY29t
IC0+IHBhdGNoZXcvMjAxOTA0MDUxODQ2NDguMTcwMjktMS1kZ2lsYmVydEByZWRoYXQuY29tClN3
aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKYzAyZWNjZGViMyBzbGlycDogR2NjIDkgLU8z
IGZpeAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZl
ciB1c2UgdGFicwojMjI6IEZJTEU6IHNsaXJwL3NyYy9zb2NrZXQuYzoxMTY6CiteSWlvdlswXS5p
b3ZfYmFzZSA9IHNiLT5zYl93cHRyOyQKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMTcg
bGluZXMgY2hlY2tlZAoKQ29tbWl0IGMwMmVjY2RlYjNlNiAoc2xpcnA6IEdjYyA5IC1PMyBmaXgp
IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJv
cnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2Vl
CkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21t
YW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0
dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwNDA1MTg0NjQ4LjE3MDI5LTEtZGdpbGJlcnRAcmVk
aGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVy
YXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxl
YXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
