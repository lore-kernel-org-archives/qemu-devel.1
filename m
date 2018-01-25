Received: from eggs.gnu.org ([2001:4830:134:3::10]:41518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eegsq-000476-8c
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 07:44:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eegsn-0007tX-Ig
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 07:44:00 -0500
Resent-Message-Id: <E1eegsn-0007tX-Ig@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21141)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1eegsn-0007rL-BG
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 07:43:57 -0500
In-Reply-To: <20180125123955.4919-1-klim.kireev@virtuozzo.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151688421393.743.5931865258283324652@5adcb62bf0d6>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 25 Jan 2018 04:43:34 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v4] chardev/char-socket: add POLLHUP handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: klim.kireev@virtuozzo.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, marcandre.lureau@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwMTI1MTIzOTU1LjQ5MTktMS1rbGltLmtpcmVldkB2aXJ0dW96em8uY29t
ClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggdjRdIGNoYXJkZXYvY2hhci1zb2NrZXQ6IGFk
ZCBQT0xMSFVQIGhhbmRsZXIKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gK
CkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAkQkFTRS4uIHwgd2MgLWwp
CmZhaWxlZD0wCgpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0
PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJD
aGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4u
LiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2tw
YXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8K
ICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQg
RU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4
NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogICBmNzhiNmY5
YjExLi4wZjc5YmZlMzhhICBtYXN0ZXIgICAgIC0+IG1hc3RlcgogdCBbdGFnIHVwZGF0ZV0gICAg
ICAgICAgICBwYXRjaGV3LzE1MTY3MzIwMTMtMTgyNzItMS1naXQtc2VuZC1lbWFpbC13YWxsaW5n
QGxpbnV4LnZuZXQuaWJtLmNvbSAtPiBwYXRjaGV3LzE1MTY3MzIwMTMtMTgyNzItMS1naXQtc2Vu
ZC1lbWFpbC13YWxsaW5nQGxpbnV4LnZuZXQuaWJtLmNvbQogdCBbdGFnIHVwZGF0ZV0gICAgICAg
ICAgICBwYXRjaGV3LzIwMTgwMTE3MTc0MDQ3LjYzODItMS1kYXZpZEByZWRoYXQuY29tIC0+IHBh
dGNoZXcvMjAxODAxMTcxNzQwNDcuNjM4Mi0xLWRhdmlkQHJlZGhhdC5jb20KICogW25ldyB0YWdd
ICAgICAgICAgICAgICAgcGF0Y2hldy8yMDE4MDEyNTEyMzk1NS40OTE5LTEta2xpbS5raXJlZXZA
dmlydHVvenpvLmNvbSAtPiBwYXRjaGV3LzIwMTgwMTI1MTIzOTU1LjQ5MTktMS1rbGltLmtpcmVl
dkB2aXJ0dW96em8uY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNDdmY2IwZjcy
MCBjaGFyZGV2L2NoYXItc29ja2V0OiBhZGQgUE9MTEhVUCBoYW5kbGVyCgo9PT0gT1VUUFVUIEJF
R0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6IGNoYXJkZXYvY2hhci1zb2NrZXQ6IGFkZCBQT0xM
SFVQIGhhbmRsZXIuLi4KRVJST1I6IHRyYWlsaW5nIHdoaXRlc3BhY2UKIzk4OiBGSUxFOiBjaGFy
ZGV2L2NoYXItc29ja2V0LmM6NTUyOgorICAgICQKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5n
cywgNDggbGluZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFz
ZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVw
b3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJT
LgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoK
Ci0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0
Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQGZy
ZWVsaXN0cy5vcmc=
