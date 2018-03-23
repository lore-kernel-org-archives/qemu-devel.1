Received: from eggs.gnu.org ([2001:4830:134:3::10]:33660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ezUYQ-0000jU-06
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:48:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ezUYL-0003IT-Q8
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:48:54 -0400
Resent-Message-Id: <E1ezUYL-0003IT-Q8@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21141)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1ezUYL-0003Ho-IT
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:48:49 -0400
In-Reply-To: <20180323125808.4479-1-rkagan@virtuozzo.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152181374331.282.8579832736723367877@71c20359a636>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 23 Mar 2018 07:02:24 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH for-2.12 0/2] i386/hyperv: fully control
 Hyper-V features in CPUID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: rkagan@virtuozzo.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, ehabkost@redhat.com, vkuznets@redhat.com, qemu-stable@nongnu.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwMzIzMTI1ODA4LjQ0NzktMS1ya2FnYW5AdmlydHVvenpvLmNvbQpTdWJq
ZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIGZvci0yLjEyIDAvMl0gaTM4Ni9oeXBlcnY6IGZ1bGx5
IGNvbnRyb2wgSHlwZXItViBmZWF0dXJlcyBpbiBDUFVJRAoKPT09IFRFU1QgU0NSSVBUIEJFR0lO
ID09PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5l
ICRCQVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFt
ZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcg
LS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KCmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZv
cm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBkbwogICAgZWNo
byAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAk
YykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9zY3JpcHRzL2No
ZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEKICAgICAgICBl
Y2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09IFRFU1QgU0NS
SVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3
MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwoyZWZiYjE4ZmUyIGkzODYvaHlw
ZXJ2OiBlcnJvciBvdXQgaWYgZmVhdHVyZXMgcmVxdWVzdGVkIGJ1dCB1bnN1cHBvcnRlZAozMWU3
NDY3ZjRlIGkzODYvaHlwZXJ2OiBhZGQgaHYtZnJlcXVlbmNpZXMgY3B1IHByb3BlcnR5Cgo9PT0g
T1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzI6IGkzODYvaHlwZXJ2OiBhZGQgaHYt
ZnJlcXVlbmNpZXMgY3B1IHByb3BlcnR5Li4uCkNoZWNraW5nIFBBVENIIDIvMjogaTM4Ni9oeXBl
cnY6IGVycm9yIG91dCBpZiBmZWF0dXJlcyByZXF1ZXN0ZWQgYnV0IHVuc3VwcG9ydGVkLi4uCkVS
Uk9SOiBzdXNwZWN0IGNvZGUgaW5kZW50IGZvciBjb25kaXRpb25hbCBzdGF0ZW1lbnRzICg0LCA3
KQojMzk6IEZJTEU6IHRhcmdldC9pMzg2L2t2bS5jOjY3MDoKKyAgICBpZiAoY3B1LT5oeXBlcnZf
cmVzZXQpIHsKKyAgICAgICBpZiAoIWhhc19tc3JfaHZfcmVzZXQpIHsKCnRvdGFsOiAxIGVycm9y
cywgMCB3YXJuaW5ncywgMzggbGluZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUgcHJv
YmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBw
b3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGlu
IE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdp
dGggY29kZTogMQoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3
IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRj
aGV3LWRldmVsQGZyZWVsaXN0cy5vcmc=
