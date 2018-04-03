Received: from eggs.gnu.org ([2001:4830:134:3::10]:46718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1f3OPH-0007Nr-Gq
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 12:03:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1f3OPD-0007qH-C5
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 12:03:35 -0400
Resent-Message-Id: <E1f3OPD-0007qH-C5@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1f3OPD-0007pO-51
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 12:03:31 -0400
In-Reply-To: <cover.1522769774.git.jan.kiszka@web.de>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152277048466.1425.6513970458037124507@71c20359a636>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 3 Apr 2018 08:48:05 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2 0/4] target-i386: Enhance SVM support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jan.kiszka@web.de
Cc: famz@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, valentine.sinitsyn@gmail.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IGNvdmVyLjE1MjI3Njk3NzQuZ2l0Lmphbi5raXN6a2FAd2ViLmRlClN1YmplY3Q6
IFtRZW11LWRldmVsXSBbUEFUQ0ggdjIgMC80XSB0YXJnZXQtaTM4NjogRW5oYW5jZSBTVk0gc3Vw
cG9ydAoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNlCm49
MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAKCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dy
YW0KCmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZv
ciBjIGluICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAk
KGdpdCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0t
Zm9ybWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVu
CiAgICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpkb25l
CgpleGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5
YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20v
cGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0Y2hldy9j
b3Zlci4xNTIyNzY5Nzc0LmdpdC5qYW4ua2lzemthQHdlYi5kZSAtPiBwYXRjaGV3L2NvdmVyLjE1
MjI3Njk3NzQuZ2l0Lmphbi5raXN6a2FAd2ViLmRlClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAn
dGVzdCcKOWNiZTk1MjUxZSB0YXJnZXQtaTM4NjogQWRkIE5QVCBzdXBwb3J0Cjg4ODBiOWJlNWQg
dGFyZ2V0LWkzODY6IE1hcmsgY3B1X3ZtZXhpdCBub3JldHVybgoyOTEzZmM5MGJmIHRhcmdldC1p
Mzg2OiBBbGxvdyBpbnRlcnJ1cHQgaW5qZWN0aW9uIGFmdGVyIFNUR0kKN2M1OWYwOTUxOCB0YXJn
ZXQtaTM4NjogQWRkIE5NSSBpbnRlcmNlcHRpb24gdG8gU1ZNCgo9PT0gT1VUUFVUIEJFR0lOID09
PQpDaGVja2luZyBQQVRDSCAxLzQ6IHRhcmdldC1pMzg2OiBBZGQgTk1JIGludGVyY2VwdGlvbiB0
byBTVk0uLi4KQ2hlY2tpbmcgUEFUQ0ggMi80OiB0YXJnZXQtaTM4NjogQWxsb3cgaW50ZXJydXB0
IGluamVjdGlvbiBhZnRlciBTVEdJLi4uCkNoZWNraW5nIFBBVENIIDMvNDogdGFyZ2V0LWkzODY6
IE1hcmsgY3B1X3ZtZXhpdCBub3JldHVybi4uLgpDaGVja2luZyBQQVRDSCA0LzQ6IHRhcmdldC1p
Mzg2OiBBZGQgTlBUIHN1cHBvcnQuLi4KRVJST1I6IGJyYWNlcyB7fSBhcmUgbmVjZXNzYXJ5IGZv
ciBhbGwgYXJtcyBvZiB0aGlzIHN0YXRlbWVudAojMTA0OiBGSUxFOiB0YXJnZXQvaTM4Ni9leGNw
X2hlbHBlci5jOjE4NDoKKyAgICAgICAgaWYgKGVudi0+bmVzdGVkX3BnX21vZGUgJiBTVk1fTlBU
X0xNQSkgewpbLi4uXQorICAgICAgICB9IGVsc2UKWy4uLl0KCnRvdGFsOiAxIGVycm9ycywgMCB3
YXJuaW5ncywgMzk0IGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1z
LCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRp
dmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlO
VEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNv
ZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0
cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1k
ZXZlbEByZWRoYXQuY29t
