Received: from eggs.gnu.org ([2001:4830:134:3::10]:45619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ePyQo-0004xF-66
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 17:26:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ePyQj-00063c-RT
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 17:26:14 -0500
Resent-Message-Id: <E1ePyQj-00063c-RT@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1ePyQj-00061T-Is
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 17:26:09 -0500
In-Reply-To: <20171215181810.4122-1-marcandre.lureau@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151336315972.42.2726263757573198795@5adcb62bf0d6>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 15 Dec 2017 10:39:21 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] checkpatch: warn when using volatile with
 a comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.comfamz@redhat.com, lersek@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTcxMjE1MTgxODEwLjQxMjItMS1tYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5j
b20KU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSF0gY2hlY2twYXRjaDogd2FybiB3aGVuIHVz
aW5nIHZvbGF0aWxlIHdpdGggYSBjb21tZW50Cgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMh
L2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0Uu
LiB8IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQg
MApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKCmNvbW1pdHM9IiQoZ2l0IGxv
ZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBkbwog
ICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1h
dD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9zY3Jp
cHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEKICAg
ICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09IFRF
U1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0
YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUK
IHQgW3RhZyB1cGRhdGVdICAgICAgICAgICAgcGF0Y2hldy8yMDE3MTIxNTE1MDY1OS4xODExLTEt
bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tIC0+IHBhdGNoZXcvMjAxNzEyMTUxNTA2NTkuMTgx
MS0xLW1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbQogdCBbdGFnIHVwZGF0ZV0gICAgICAgICAg
ICBwYXRjaGV3LzIwMTcxMjE1MTgxODEwLjQxMjItMS1tYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5j
b20gLT4gcGF0Y2hldy8yMDE3MTIxNTE4MTgxMC40MTIyLTEtbWFyY2FuZHJlLmx1cmVhdUByZWRo
YXQuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKODA4MjhlZDFiNSBjaGVja3Bh
dGNoOiB3YXJuIHdoZW4gdXNpbmcgdm9sYXRpbGUgd2l0aCBhIGNvbW1lbnQKCj09PSBPVVRQVVQg
QkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMTogY2hlY2twYXRjaDogd2FybiB3aGVuIHVzaW5n
IHZvbGF0aWxlIHdpdGggYSBjb21tZW50Li4uCkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVy
cwojMjg6IEZJTEU6IHNjcmlwdHMvY2hlY2twYXRjaC5wbDoyNDc5OgorCQkJbXkgJG1zZyA9ICJV
c2Ugb2Ygdm9sYXRpbGUgaXMgdXN1YWxseSB3cm9uZzogc2VlIERvY3VtZW50YXRpb24vdm9sYXRp
bGUtY29uc2lkZXJlZC1oYXJtZnVsLnR4dFxuIiAuICRoZXJlY3VycjsKCnRvdGFsOiAxIGVycm9y
cywgMCB3YXJuaW5ncywgMTMgbGluZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUgcHJv
YmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBw
b3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGlu
IE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdp
dGggY29kZTogMQoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3
IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRj
aGV3LWRldmVsQGZyZWVsaXN0cy5vcmc=
