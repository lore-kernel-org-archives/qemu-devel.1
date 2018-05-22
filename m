Received: from eggs.gnu.org ([2001:4830:134:3::10]:60734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fLCvc-0004lH-EI
	for qemu-devel@nongnu.org; Tue, 22 May 2018 15:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fLCvZ-0006Tc-9h
	for qemu-devel@nongnu.org; Tue, 22 May 2018 15:26:36 -0400
Resent-Message-Id: <E1fLCvZ-0006Tc-9h@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1fLCvY-0006T5-Vs
	for qemu-devel@nongnu.org; Tue, 22 May 2018 15:26:33 -0400
In-Reply-To: <20180522192034.13318-1-pbonzini@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152701717017.99.22442532720140258@d39dc562802a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 22 May 2018 12:26:11 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] tcg: remove softfloat from --disable-tcg
 builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, thuth@redhat.com, david@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwNTIyMTkyMDM0LjEzMzE4LTEtcGJvbnppbmlAcmVkaGF0LmNvbQpTdWJq
ZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSB0Y2c6IHJlbW92ZSBzb2Z0ZmxvYXQgZnJvbSAtLWRp
c2FibGUtdGNnIGJ1aWxkcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAoK
QkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3YyAtbCkK
ZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29y
aXRobSBoaXN0b2dyYW0KCmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2Ug
JEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0gg
JG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdp
dCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWls
YmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBmaQogICAgbj0k
KChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0
aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczov
L2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgICAg
ICAgcGF0Y2hldy8yMDE4MDUyMjE5MjAzNC4xMzMxOC0xLXBib256aW5pQHJlZGhhdC5jb20gLT4g
cGF0Y2hldy8yMDE4MDUyMjE5MjAzNC4xMzMxOC0xLXBib256aW5pQHJlZGhhdC5jb20KU3dpdGNo
ZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwoyYjM3NGI0YTlkIHRjZzogcmVtb3ZlIHNvZnRmbG9h
dCBmcm9tIC0tZGlzYWJsZS10Y2cgYnVpbGRzCgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2lu
ZyBQQVRDSCAxLzE6IHRjZzogcmVtb3ZlIHNvZnRmbG9hdCBmcm9tIC0tZGlzYWJsZS10Y2cgYnVp
bGRzLi4uCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJ
TlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzI2OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCkVSUk9S
OiBkbyBub3QgaW5pdGlhbGlzZSBzdGF0aWNzIHRvIDAgb3IgTlVMTAojODY6IEZJTEU6IGh3L2kz
ODYveDg2LWlvbW11LXN0dWIuYzo1NjoKK3N0YXRpYyBYODZJT01NVVN0YXRlICp4ODZfaW9tbXVf
ZGVmYXVsdCA9IE5VTEw7Cgp0b3RhbDogMSBlcnJvcnMsIDEgd2FybmluZ3MsIDE0MCBsaW5lcyBj
aGVja2VkCgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElm
IGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0
aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVU
IEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdl
bmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQ
bGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==
