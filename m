Received: from eggs.gnu.org ([2001:4830:134:3::10]:42630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1d3pSE-0004Sl-FI
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 15:51:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1d3pSC-0001T1-Tm
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 15:51:54 -0400
Resent-Message-Id: <E1d3pSC-0001T1-Tm@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1d3pSC-0001RN-KJ
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 15:51:52 -0400
In-Reply-To: <20170427192211.30640-1-eblake@redhat.com>
Message-ID: <149332270057.114.17250566972242208074@c05f1edc8ed1>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 27 Apr 2017 12:51:41 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v3 0/4] event: Add source information to
 SHUTDOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eblake@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, alistair.francis@xilinx.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSCB2MyAwLzRdIGV2ZW50OiBBZGQgc291cmNlIGluZm9ybWF0aW9uIHRvIFNI
VVRET1dOCk1lc3NhZ2UtaWQ6IDIwMTcwNDI3MTkyMjExLjMwNjQwLTEtZWJsYWtlQHJlZGhhdC5j
b20KVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpC
QVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpm
YWlsZWQ9MAoKIyBVc2VmdWwgZ2l0IG9wdGlvbnMKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVu
YW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKCmNvbW1pdHM9
IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRjb21t
aXRzOyBkbwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4g
MSAtLWZvcm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWls
IHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFp
bGVkPTEKICAgICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWls
ZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0
ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwozZDI3
ZGJhIFJGQzogc2h1dGRvd246IEV4cG9zZSBmdWxsIFNodXRkb3duVHlwZSBhY3Jvc3MgUU1QCmY3
NzE2MTYgc2h1dGRvd246IEFkZCBzb3VyY2UgaW5mb3JtYXRpb24gdG8gU0hVVERPV04gYW5kIFJF
U0VUCjNkNzc0N2Qgc2h1dGRvd246IFByZXBhcmUgZm9yIHVzZSBvZiBhbiBlbnVtIGluIHJlc2V0
L3NodXRkb3duX3JlcXVlc3QKMWRkNmM3MCBzaHV0ZG93bjogU2ltcGxpZnkgc2h1dGRvd25fc2ln
bmFsCgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzQ6IHNodXRkb3duOiBT
aW1wbGlmeSBzaHV0ZG93bl9zaWduYWwuLi4KQ2hlY2tpbmcgUEFUQ0ggMi80OiBzaHV0ZG93bjog
UHJlcGFyZSBmb3IgdXNlIG9mIGFuIGVudW0gaW4gcmVzZXQvc2h1dGRvd25fcmVxdWVzdC4uLgpD
aGVja2luZyBQQVRDSCAzLzQ6IHNodXRkb3duOiBBZGQgc291cmNlIGluZm9ybWF0aW9uIHRvIFNI
VVRET1dOIGFuZCBSRVNFVC4uLgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzE0NDog
RklMRTogaHcvYXJtL29tYXAxLmM6MTU0OToKKyAgICAgICAgcWVtdV9zeXN0ZW1fc2h1dGRvd25f
cmVxdWVzdChTSFVURE9XTl9UWVBFX0dVRVNUX1NIVVRET1dOKTsgLyogWFhYOiBkaXNhYmxlIHdh
a2V1cCBmcm9tIElSUSAqLwoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA4ODIgbGluZXMg
Y2hlY2tlZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJ
ZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8g
dGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKQ2hlY2tpbmcg
UEFUQ0ggNC80OiBSRkM6IHNodXRkb3duOiBFeHBvc2UgZnVsbCBTaHV0ZG93blR5cGUgYWNyb3Nz
IFFNUC4uLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2Rl
OiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAZnJlZWxpc3RzLm9yZw==
