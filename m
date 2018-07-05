Received: from eggs.gnu.org ([2001:4830:134:3::10]:48895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fb2o7-00060c-Vn
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:52:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fb2o4-0003rS-3S
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:52:20 -0400
Resent-Message-Id: <E1fb2o4-0003rS-3S@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21015)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1fb2o3-0003oS-Qe
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:52:16 -0400
In-Reply-To: <20180705080017.31123-1-bala24@linux.vnet.ibm.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <153077799264.1209.10409652147339493418@946cad8fd14e>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 5 Jul 2018 01:06:33 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH 0/2] tests: multifd migration test scenarios
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: bala24@linux.vnet.ibm.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, peterx@redhat.com, quintela@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwNzA1MDgwMDE3LjMxMTIzLTEtYmFsYTI0QGxpbnV4LnZuZXQuaWJtLmNv
bQpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gIFtQQVRDSCAwLzJdIHRlc3RzOiBtdWx0aWZkIG1pZ3Jh
dGlvbiB0ZXN0IHNjZW5hcmlvcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFz
aAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3YyAt
bCkKZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFs
Z29yaXRobSBoaXN0b2dyYW0KCmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVy
c2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tpbmcgUEFU
Q0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAgICBpZiAh
IGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1t
YWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBmaQogICAg
bj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVw
ZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQg
dG8gYSBuZXcgYnJhbmNoICd0ZXN0JwoxMmU3ZTg5MTgzIHRlc3RzOiBhZGQgcHJlY29weSBtdWx0
aWZkIG1pZ3JhdGlvbiB3aXRoIGZkIHByb3RvY29sCjcyZjJjYWE2NGIgdGVzdHM6IGFkZCBwcmVj
b3B5IG11bHRpZmQgbWlncmF0aW9uIHRlc3Qgd2l0aCB1bml4Cgo9PT0gT1VUUFVUIEJFR0lOID09
PQpDaGVja2luZyBQQVRDSCAxLzI6IHRlc3RzOiBhZGQgcHJlY29weSBtdWx0aWZkIG1pZ3JhdGlv
biB0ZXN0IHdpdGggdW5peC4uLgpDaGVja2luZyBQQVRDSCAyLzI6IHRlc3RzOiBhZGQgcHJlY29w
eSBtdWx0aWZkIG1pZ3JhdGlvbiB3aXRoIGZkIHByb3RvY29sLi4uCkVSUk9SOiBicmFjZXMge30g
YXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1lbnQKIzUwOiBGSUxFOiB0
ZXN0cy9taWdyYXRpb24tdGVzdC5jOjYzOToKKyAgICBpZiAocGlwZShmZCkgPT0gLTEpClsuLi5d
Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDgxIGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0
Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVy
cm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBz
ZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBj
b21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRp
Y2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIg
ZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t
