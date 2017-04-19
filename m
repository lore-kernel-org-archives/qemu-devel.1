Received: from eggs.gnu.org ([2001:4830:134:3::10]:50227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1d0toU-0002Nv-Bg
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 13:54:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1d0toQ-0001ne-51
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 13:54:46 -0400
Resent-Message-Id: <E1d0toQ-0001ne-51@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21301)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1d0toP-0001n2-SS
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 13:54:42 -0400
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <149262445943.10521.1033629137396592739@6c512846dbc7>
In-Reply-To: <1492620502-71509-1-git-send-email-bernhard.kaindl@thalesgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 19 Apr 2017 10:54:20 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] e500,
 book3s: mfspr 259: Register mapped/aliased SPRG3 user read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: bernhard.kaindl@thalesgroup.com
Cc: famz@redhat.com, david@gibson.dropbear.id.au, qemu-devel@nongnu.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDE0OTI2MjA1MDItNzE1MDktMS1naXQtc2VuZC1lbWFpbC1iZXJuaGFyZC5rYWlu
ZGxAdGhhbGVzZ3JvdXAuY29tClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hdIGU1MDAsIGJv
b2szczogbWZzcHIgMjU5OiBSZWdpc3RlciBtYXBwZWQvYWxpYXNlZCBTUFJHMyB1c2VyIHJlYWQK
Cj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90
YWw9JChnaXQgbG9nIC0tb25lbGluZSAkQkFTRS4uIHwgd2MgLWwpCmZhaWxlZD0wCgojIFVzZWZ1
bCBnaXQgb3B0aW9ucwpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9y
bWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hv
ICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRj
KS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hl
Y2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVj
aG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJ
UFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcx
MzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogLSBbdGFn
IHVwZGF0ZV0gICAgICBwYXRjaGV3LzE0OTEyNzc2ODktMjQ5NDktMS1naXQtc2VuZC1lbWFpbC1B
c2hpc2guTWl0dGFsQHZlcml0YXMuY29tIC0+IHBhdGNoZXcvMTQ5MTI3NzY4OS0yNDk0OS0xLWdp
dC1zZW5kLWVtYWlsLUFzaGlzaC5NaXR0YWxAdmVyaXRhcy5jb20KICogW25ldyB0YWddICAgICAg
ICAgcGF0Y2hldy8xNDkyNjIwNTAyLTcxNTA5LTEtZ2l0LXNlbmQtZW1haWwtYmVybmhhcmQua2Fp
bmRsQHRoYWxlc2dyb3VwLmNvbSAtPiBwYXRjaGV3LzE0OTI2MjA1MDItNzE1MDktMS1naXQtc2Vu
ZC1lbWFpbC1iZXJuaGFyZC5rYWluZGxAdGhhbGVzZ3JvdXAuY29tClN3aXRjaGVkIHRvIGEgbmV3
IGJyYW5jaCAndGVzdCcKNjdiNjIwMyBlNTAwLCBib29rM3M6IG1mc3ByIDI1OTogUmVnaXN0ZXIg
bWFwcGVkL2FsaWFzZWQgU1BSRzMgdXNlciByZWFkCgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVj
a2luZyBQQVRDSCAxLzE6IGU1MDAsIGJvb2szczogbWZzcHIgMjU5OiBSZWdpc3RlciBtYXBwZWQv
YWxpYXNlZCBTUFJHMyB1c2VyIHJlYWQuLi4KRVJST1I6IHNwYWNlIHByb2hpYml0ZWQgYmV0d2Vl
biBmdW5jdGlvbiBuYW1lIGFuZCBvcGVuIHBhcmVudGhlc2lzICcoJwojNTA6IEZJTEU6IHRhcmdl
dC9wcGMvdHJhbnNsYXRlX2luaXQuYzoxNjM3Ogorc3RhdGljIHZvaWQgZ2VuX3Nwcl91c3ByZzMg
KENQVVBQQ1N0YXRlICplbnYpCgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDI4IGxpbmVz
IGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAg
SWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRv
IHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQ
VVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwg
Z2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
