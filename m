Received: from eggs.gnu.org ([2001:4830:134:3::10]:43440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1e3mts-00032q-4W
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 13:40:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1e3mto-0001wV-TM
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 13:40:32 -0400
Resent-Message-Id: <E1e3mto-0001wV-TM@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21493)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1e3mto-0001va-GY
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 13:40:28 -0400
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <150808920095.320.8445798126036414840@b58463cdfd5f>
In-Reply-To: <20171015165858.19937-1-martin@schrodt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sun, 15 Oct 2017 10:40:01 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v3 0/2] Improve audio output quality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: martin@schrodt.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTcxMDE1MTY1ODU4LjE5OTM3LTEtbWFydGluQHNjaHJvZHQub3JnClN1Ympl
Y3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggdjMgMC8yXSBJbXByb3ZlIGF1ZGlvIG91dHB1dCBxdWFs
aXR5Cgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0x
CnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVzIFRydWUKCmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2Ug
JEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0gg
JG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdp
dCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWls
YmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBmaQogICAgbj0k
KChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0
aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8g
YSBuZXcgYnJhbmNoICd0ZXN0JwowOTNmNWM2ZmJkIGF1ZGlvL2hkYTogY3JlYXRlIG1pbGxpc2Vj
b25kIHRpbWVycyB0aGF0IGhhbmRsZSBJTwpkNjVjNTliN2ViIGF1ZGlvL3BhYXVkaW86IHJlbW92
ZSBzZXBhcmF0ZSBQQSBmZWVkZXIgdGhyZWFkcwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KQ2hlY2tp
bmcgUEFUQ0ggMS8yOiBhdWRpby9wYWF1ZGlvOiByZW1vdmUgc2VwYXJhdGUgUEEgZmVlZGVyIHRo
cmVhZHMuLi4KRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnfCcgKGN0eDpFeFYp
CiM1Mzg6IEZJTEU6IGF1ZGlvL3BhYXVkaW8uYzozNDg6CisgICAgICAgICAgICAgICAgfFBBX1NU
UkVBTV9BVVRPX1RJTUlOR19VUERBVEUsIE5VTEwsIE5VTEwpOwogICAgICAgICAgICAgICAgIF4K
CkVSUk9SOiBzcGFjZXMgcmVxdWlyZWQgYXJvdW5kIHRoYXQgJ3wnIChjdHg6RXhWKQojNTQ5OiBG
SUxFOiBhdWRpby9wYWF1ZGlvLmM6MzUzOgorICAgICAgICAgICAgICAgIHxQQV9TVFJFQU1fQVVU
T19USU1JTkdfVVBEQVRFKTsKICAgICAgICAgICAgICAgICBeCgpFUlJPUjogc3BhY2UgcHJvaGli
aXRlZCBiZXR3ZWVuIGZ1bmN0aW9uIG5hbWUgYW5kIG9wZW4gcGFyZW50aGVzaXMgJygnCiM2MjE6
IEZJTEU6IGF1ZGlvL3BhYXVkaW8uYzo0MTc6CisgICAgcGEtPmJhLnRsZW5ndGggPSB0bGVuZ3Ro
ICogcGFfZnJhbWVfc2l6ZSAoJnBhLT5zcyk7Cgp0b3RhbDogMyBlcnJvcnMsIDAgd2FybmluZ3Ms
IDgwNyBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNl
IHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBv
cnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMu
CgpDaGVja2luZyBQQVRDSCAyLzI6IGF1ZGlvL2hkYTogY3JlYXRlIG1pbGxpc2Vjb25kIHRpbWVy
cyB0aGF0IGhhbmRsZSBJTy4uLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0
ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRv
IHBhdGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
