Received: from eggs.gnu.org ([2001:4830:134:3::10]:41284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fR4z6-0001wD-19
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 20:10:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fR4z2-00043V-Rp
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 20:10:27 -0400
Resent-Message-Id: <E1fR4z2-00043V-Rp@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21099)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1fR4z2-00040r-HY
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 20:10:24 -0400
In-Reply-To: <20180608000540.276617-1-mst@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152841660997.447.17594475293234388622@d39dc562802a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 7 Jun 2018 17:10:10 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] kvm: support -realtime cpu-pm=on|off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com, ehabkost@redhat.com, kvm@vger.kernel.org, rth@twiddle.net

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwNjA4MDAwNTQwLjI3NjYxNy0xLW1zdEByZWRoYXQuY29tClN1YmplY3Q6
IFtRZW11LWRldmVsXSBbUEFUQ0hdIGt2bTogc3VwcG9ydCAtcmVhbHRpbWUgY3B1LXBtPW9ufG9m
ZgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0
b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAKCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
cmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0K
CmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBj
IGluICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdp
dCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9y
bWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAg
ICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpl
eGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIx
ZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0
Y2hldy1wcm9qZWN0L3FlbXUKIHQgW3RhZyB1cGRhdGVdICAgICAgICAgICAgcGF0Y2hldy8yMDE4
MDYwNzE1NDcwNS42MzE2LTEtZGF2aWRAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMTgwNjA3MTU0
NzA1LjYzMTYtMS1kYXZpZEByZWRoYXQuY29tCiAqIFtuZXcgdGFnXSAgICAgICAgICAgICAgIHBh
dGNoZXcvMjAxODA2MDgwMDA1NDAuMjc2NjE3LTEtbXN0QHJlZGhhdC5jb20gLT4gcGF0Y2hldy8y
MDE4MDYwODAwMDU0MC4yNzY2MTctMS1tc3RAcmVkaGF0LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBi
cmFuY2ggJ3Rlc3QnCmUzODhkNTY4NjEga3ZtOiBzdXBwb3J0IC1yZWFsdGltZSBjcHUtcG09b258
b2ZmCgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6IGt2bTogc3VwcG9y
dCAtcmVhbHRpbWUgY3B1LXBtPW9ufG9mZi4uLgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFj
dGVycwojNjg6IEZJTEU6IHRhcmdldC9pMzg2L2t2bS5jOjEwNDU6CisgICAgICAgIGludCBkaXNh
YmxlX2V4aXRzID0ga3ZtX2NoZWNrX2V4dGVuc2lvbihjcy0+a3ZtX3N0YXRlLCBLVk1fQ0FQX1g4
Nl9ESVNBQkxFX0VYSVRTKTsKCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiM4ODog
RklMRTogdGFyZ2V0L2kzODYva3ZtLmM6MTA2NToKKyAgICAgICAgICAgIGVycm9yX3JlcG9ydCgi
a3ZtOiBndWVzdCBzdG9wcGluZyBDUFUgbm90IHN1cHBvcnRlZDogJXMiLCBzdHJlcnJvcigtcmV0
KSk7CgpFUlJPUjogZG8gbm90IGluaXRpYWxpc2UgZ2xvYmFscyB0byAwIG9yIE5VTEwKIzEwNDog
RklMRTogdmwuYzoxNDU6Citib29sIGVuYWJsZV9jcHVfcG0gPSBmYWxzZTsKCnRvdGFsOiAxIGVy
cm9ycywgMiB3YXJuaW5ncywgODYgbGluZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUg
cHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxz
ZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENI
IGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVk
IHdpdGggY29kZTogMQoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRj
aGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBw
YXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
