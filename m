Received: from eggs.gnu.org ([2001:4830:134:3::10]:48633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dlHPj-0003rJ-R4
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 12:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dlHPg-0004hE-Li
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 12:24:55 -0400
Resent-Message-Id: <E1dlHPg-0004hE-Li@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21377)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1dlHPg-0004gn-EY
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 12:24:52 -0400
Message-ID: <150367827575.135.18312492625326080794@205a2245145f>
Reply-To: <qemu-devel@nongnu.org>
In-Reply-To: <20170825155732.15665-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 25 Aug 2017 09:24:36 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH 0/3] scripts: add argparse module for
 Python 2.6 compatibility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, chugh.ishani@research.iiit.ac.in

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTcwODI1MTU1NzMyLjE1NjY1LTEtc3RlZmFuaGFAcmVkaGF0LmNvbQpTdWJq
ZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIDAvM10gc2NyaXB0czogYWRkIGFyZ3BhcnNlIG1vZHVs
ZSBmb3IgUHl0aG9uIDIuNiBjb21wYXRpYmlsaXR5Cgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09
CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJB
U0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGlt
aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKCmNvbW1pdHM9IiQoZ2l0
IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBk
bwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZv
cm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9z
Y3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEK
ICAgICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09
IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3
ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwpiMGY3NWJiZWUx
IHRlc3RzOiBtaWdyYXRpb24vZ3Vlc3RwZXJmIFB5dGhvbiAyLjYgYXJncGFyc2UgY29tcGF0aWJp
bGl0eQphMDk3NmQ4OGFlIGRvY2tlci5weTogUHl0aG9uIDIuNiBhcmdwYXJzZSBjb21wYXRpYmls
aXR5CjNmOWRmYzQ0NWEgc2NyaXB0czogYWRkIGFyZ3BhcnNlIG1vZHVsZSBmb3IgUHl0aG9uIDIu
NiBjb21wYXRpYmlsaXR5Cgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzM6
IHNjcmlwdHM6IGFkZCBhcmdwYXJzZSBtb2R1bGUgZm9yIFB5dGhvbiAyLjYgY29tcGF0aWJpbGl0
eS4uLgpFUlJPUjogdHJhaWxpbmcgd2hpdGVzcGFjZQojMTE1OiBGSUxFOiBDT1BZSU5HLlBZVEhP
Tjo5MzoKK1Jlc2VydmVkIiBhcmUgcmV0YWluZWQgaW4gUHl0aG9uIGFsb25lIG9yIGluIGFueSBk
ZXJpdmF0aXZlIHZlcnNpb24gJAoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAyNjc2IGxp
bmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3
LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVt
IHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCkNoZWNr
aW5nIFBBVENIIDIvMzogZG9ja2VyLnB5OiBQeXRob24gMi42IGFyZ3BhcnNlIGNvbXBhdGliaWxp
dHkuLi4KQ2hlY2tpbmcgUEFUQ0ggMy8zOiB0ZXN0czogbWlncmF0aW9uL2d1ZXN0cGVyZiBQeXRo
b24gMi42IGFyZ3BhcnNlIGNvbXBhdGliaWxpdHkuLi4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0
IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21h
dGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91
ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQGZyZWVsaXN0cy5vcmc=
