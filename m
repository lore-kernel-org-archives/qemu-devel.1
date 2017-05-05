Received: from eggs.gnu.org ([2001:4830:134:3::10]:40976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1d6j1n-0003Tq-Jc
	for qemu-devel@nongnu.org; Fri, 05 May 2017 15:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1d6j1j-0002j4-N3
	for qemu-devel@nongnu.org; Fri, 05 May 2017 15:36:35 -0400
Resent-Message-Id: <E1d6j1j-0002j4-N3@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1d6j1j-0002ip-Ea
	for qemu-devel@nongnu.org; Fri, 05 May 2017 15:36:31 -0400
In-Reply-To: <20170505162305.15763-1-berrange@redhat.com>
Message-ID: <149401298097.195.8271310158086528604@c05f1edc8ed1>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 5 May 2017 12:36:21 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] Revert "Change net/socket.c to use
 socket_*() functions" again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, marcandre.lureau@redhat.com, stefanha@redhat.com, ashijeetacharya@gmail.com, pbonzini@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzClN1
YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hdIFJldmVydCAiQ2hhbmdlIG5ldC9zb2NrZXQuYyB0
byB1c2Ugc29ja2V0XyooKSBmdW5jdGlvbnMiIGFnYWluCk1lc3NhZ2UtaWQ6IDIwMTcwNTA1MTYy
MzA1LjE1NzYzLTEtYmVycmFuZ2VAcmVkaGF0LmNvbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09
PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRC
QVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxp
bWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIkKGdp
dCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsg
ZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1m
b3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4v
c2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0x
CiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09
PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVm
N2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9x
ZW11CiAtIFt0YWcgdXBkYXRlXSAgICAgIHBhdGNoZXcvMjAxNzA1MDQxNzM3NDUuMjc0MTQtMS1l
Ymxha2VAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMTcwNTA0MTczNzQ1LjI3NDE0LTEtZWJsYWtl
QHJlZGhhdC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo4OWY2YjlkIFJldmVy
dCAiQ2hhbmdlIG5ldC9zb2NrZXQuYyB0byB1c2Ugc29ja2V0XyooKSBmdW5jdGlvbnMiIGFnYWlu
Cgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6IFJldmVydCAiQ2hhbmdl
IG5ldC9zb2NrZXQuYyB0byB1c2Ugc29ja2V0XyooKSBmdW5jdGlvbnMiIGFnYWluLi4uCkVSUk9S
OiBicmFjZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1lbnQK
IzU2OiBGSUxFOiBuZXQvc29ja2V0LmM6NDk1OgorICAgIGlmIChwYXJzZV9ob3N0X3BvcnQoJnNh
ZGRyLCBob3N0X3N0cikgPCAwKQpbLi4uXQoKRVJST1I6IGJyYWNlcyB7fSBhcmUgbmVjZXNzYXJ5
IGZvciBhbGwgYXJtcyBvZiB0aGlzIHN0YXRlbWVudAojMTU5OiBGSUxFOiBuZXQvc29ja2V0LmM6
NTQwOgorICAgIGlmIChwYXJzZV9ob3N0X3BvcnQoJnNhZGRyLCBob3N0X3N0cikgPCAwKQpbLi4u
XQoKRVJST1I6IHNwYWNlIHJlcXVpcmVkIGJlZm9yZSB0aGUgb3BlbiBwYXJlbnRoZXNpcyAnKCcK
IzE3MjogRklMRTogbmV0L3NvY2tldC5jOjU1MToKKyAgICBmb3IoOzspIHsKCkVSUk9SOiBicmFj
ZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1lbnQKIzE5Mjog
RklMRTogbmV0L3NvY2tldC5jOjU3MToKKyAgICBpZiAoIXMpClsuLi5dCgp0b3RhbDogNCBlcnJv
cnMsIDAgd2FybmluZ3MsIDE2MiBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBw
cm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNl
IHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0gg
aW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQg
d2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNo
ZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBh
dGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
