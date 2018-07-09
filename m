Received: from eggs.gnu.org ([2001:4830:134:3::10]:40811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fcc9v-0007UM-6Q
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 15:49:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fcc9s-0001Sd-3o
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 15:49:19 -0400
Resent-Message-Id: <E1fcc9s-0001Sd-3o@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1fcc9r-0001Rt-UW
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 15:49:16 -0400
In-Reply-To: <20180709174154.9470-1-ehabkost@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <153115852067.1482.5805823591216680658@946cad8fd14e>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 9 Jul 2018 10:48:42 -0700 (PDT)
Subject: Re: [Qemu-devel] [PULL 0/2] Machine/NUMA fixes for -rc0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com
Cc: famz@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, imammedo@redhat.com, mst@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwNzA5MTc0MTU0Ljk0NzAtMS1laGFia29zdEByZWRoYXQuY29tClN1Ympl
Y3Q6IFtRZW11LWRldmVsXSBbUFVMTCAwLzJdIE1hY2hpbmUvTlVNQSBmaXhlcyBmb3IgLXJjMAoK
PT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3Rh
bD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAKCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVu
YW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KCmNv
bW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGlu
ICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBs
b2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0
PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAg
ICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0
ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4
NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hl
dy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0Y2hldy8yMDE4MDcw
OTE3NDE1NC45NDcwLTEtZWhhYmtvc3RAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMTgwNzA5MTc0
MTU0Ljk0NzAtMS1laGFia29zdEByZWRoYXQuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAn
dGVzdCcKNDk1NmFiNDdiZSBody9tYWNoaW5lOiBSZW1vdmUgdGhlIFplcm8gY2hlY2sgb2YgbmJf
bnVtYV9ub2RlcyBmb3IgbnVtYV9jb21wbGV0ZV9jb25maWd1cmF0aW9uKCkKZGFhYWNkZmQ0YiBt
YWNoaW5lOiBwcm9wZXJseSBmcmVlIGRldmljZV9tZW1vcnkKCj09PSBPVVRQVVQgQkVHSU4gPT09
CkNoZWNraW5nIFBBVENIIDEvMjogbWFjaGluZTogcHJvcGVybHkgZnJlZSBkZXZpY2VfbWVtb3J5
Li4uCkNoZWNraW5nIFBBVENIIDIvMjogaHcvbWFjaGluZTogUmVtb3ZlIHRoZSBaZXJvIGNoZWNr
IG9mIG5iX251bWFfbm9kZXMgZm9yIG51bWFfY29tcGxldGVfY29uZmlndXJhdGlvbigpLi4uCkVS
Uk9SOiBicmFjZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1l
bnQKIzM0OiBGSUxFOiBody9jb3JlL21hY2hpbmUuYzo3OTY6CisgICAgaWYgKG5iX251bWFfbm9k
ZXMpClsuLi5dCgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDEyIGxpbmVzIGNoZWNrZWQK
CllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9m
IHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWlu
dGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09
PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVk
IGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBz
ZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t
