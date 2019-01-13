Received: from eggs.gnu.org ([209.51.188.92]:60540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1givrY-0008SV-JY
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 01:36:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1givrX-0001fa-18
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 01:36:44 -0500
Resent-Message-Id: <E1givrX-0001fa-18@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1givrW-0001eb-Oy
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 01:36:42 -0500
Message-ID: <154741983413.25737.5072309071395952742@2d170d368aaa>
Reply-To: <qemu-devel@nongnu.org>
In-Reply-To: <20190110191901.5082-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sun, 13 Jan 2019 14:50:35 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v3 0/6] include: Auto-generate the sizes
 lookup table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eblake@redhat.com
Cc: fam@euphon.net, qemu-devel@nongnu.org, kwolf@redhat.com, lbloch@janustech.com, armbru@redhat.com, qemu-block@nongnu.org

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDExMDE5MTkwMS41MDgy
LTEtZWJsYWtlQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMTkwMTEwMTkxOTAxLjUwODItMS1lYmxha2VAcmVkaGF0
LmNvbQpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHYzIDAvNl0gaW5jbHVkZTogQXV0by1n
ZW5lcmF0ZSB0aGUgc2l6ZXMgbG9va3VwIHRhYmxlClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVs
aW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0t
bWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVh
OWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5j
aCAndGVzdCcKNWUxYTY2NyBSZXZlcnQgImluY2x1ZGU6IEFkZCBhIGxvb2t1cCB0YWJsZSBvZiBz
aXplcyIKZDRjNDVkYiBSZXZlcnQgImluY2x1ZGU6IEFkZCBhIGNvbW1lbnQgdG8gZXhwbGFpbiB0
aGUgb3JpZ2luIG9mIHNpemVzJyBsb29rdXAgdGFibGUiCmYxZjIyMDggcWVtdTogUHJlZmVyICco
eCAqIE1pQiknIG92ZXIgJ1NfeGlCJwo3OWU1MDIzIFJldmVydCAidmRpOiBVc2UgYSBsaXRlcmFs
IG51bWJlciBvZiBieXRlcyBmb3IgREVGQVVMVF9DTFVTVEVSX1NJWkUiCmIwNzMyOWQgYmxvY2s6
IFRha2UgYWR2YW50YWdlIG9mIFFlbXVPcHQgZGVmYXVsdCBpbnRlZ2VycwpiMGExODZjIHFlbXUt
b3B0aW9uOiBBbGxvdyBpbnRlZ2VyIGRlZmF1bHRzCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzYg
Q2hlY2tpbmcgY29tbWl0IGIwYTE4NmNiOWZjNCAocWVtdS1vcHRpb246IEFsbG93IGludGVnZXIg
ZGVmYXVsdHMpCjIvNiBDaGVja2luZyBjb21taXQgYjA3MzI5ZDczZWQxIChibG9jazogVGFrZSBh
ZHZhbnRhZ2Ugb2YgUWVtdU9wdCBkZWZhdWx0IGludGVnZXJzKQozLzYgQ2hlY2tpbmcgY29tbWl0
IDc5ZTUwMjNlMmExZiAoUmV2ZXJ0ICJ2ZGk6IFVzZSBhIGxpdGVyYWwgbnVtYmVyIG9mIGJ5dGVz
IGZvciBERUZBVUxUX0NMVVNURVJfU0laRSIpCkVSUk9SOiBNaXNzaW5nIFNpZ25lZC1vZmYtYnk6
IGxpbmUocykKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMTYgbGluZXMgY2hlY2tlZAoK
UGF0Y2ggMy82IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0
aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRh
aW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo0LzYgQ2hlY2tpbmcgY29tbWl0
IGYxZjIyMDgxZDBjMCAocWVtdTogUHJlZmVyICcoeCAqIE1pQiknIG92ZXIgJ1NfeGlCJykKNS82
IENoZWNraW5nIGNvbW1pdCBkNGM0NWRiOTAyZjUgKFJldmVydCAiaW5jbHVkZTogQWRkIGEgY29t
bWVudCB0byBleHBsYWluIHRoZSBvcmlnaW4gb2Ygc2l6ZXMnIGxvb2t1cCB0YWJsZSIpCjYvNiBD
aGVja2luZyBjb21taXQgNWUxYTY2N2E0ZTA2IChSZXZlcnQgImluY2x1ZGU6IEFkZCBhIGxvb2t1
cCB0YWJsZSBvZiBzaXplcyIpCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRl
ZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRj
aGV3Lm9yZy9sb2dzLzIwMTkwMTEwMTkxOTAxLjUwODItMS1lYmxha2VAcmVkaGF0LmNvbS90ZXN0
aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0
aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3Vy
IGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==
