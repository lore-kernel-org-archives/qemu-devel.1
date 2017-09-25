Received: from eggs.gnu.org ([2001:4830:134:3::10]:49308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dwUVS-00081y-F6
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 10:37:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dwUVP-0001Sf-5o
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 10:37:10 -0400
Resent-Message-Id: <E1dwUVP-0001Sf-5o@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1dwUVO-0001Rn-TV
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 10:37:07 -0400
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <150633656091.33.862531980128168681@b58463cdfd5f>
In-Reply-To: <20170925102302.60587-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 25 Sep 2017 03:49:21 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH 0/2] s390/z14: extended TOD-clock support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: borntraeger@de.ibm.com
Cc: famz@redhat.com, cohuck@redhat.com, thuth@redhat.com, david@redhat.com, qemu-devel@nongnu.org, agraf@suse.de, rth@twiddle.net

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTcwOTI1MTAyMzAyLjYwNTg3LTEtYm9ybnRyYWVnZXJAZGUuaWJtLmNvbQpT
dWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIDAvMl0gczM5MC96MTQ6IGV4dGVuZGVkIFRPRC1j
bG9jayBzdXBwb3J0Cgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNF
PWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWls
ZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKCmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAt
LXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tp
bmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAg
ICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gu
cGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBm
aQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9
PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dp
dGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo5NmM2OTA2YzkzIHMzOTAva3ZtOiBTdXBwb3J0
IGZvciBnZXQvc2V0IG9mIGV4dGVuZGVkIFRPRC1DbG9jayBmb3IgZ3Vlc3QKZjRlY2YxNDNmMCBs
aW51eC1oZWFkZXJzOiBVcGRhdGUgbGludXggaGVhZGVycyBmb3IgZXh0ZW5kZWQgVE9ELUNsb2Nr
Cgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzI6IGxpbnV4LWhlYWRlcnM6
IFVwZGF0ZSBsaW51eCBoZWFkZXJzIGZvciBleHRlbmRlZCBUT0QtQ2xvY2suLi4KQ2hlY2tpbmcg
UEFUQ0ggMi8yOiBzMzkwL2t2bTogU3VwcG9ydCBmb3IgZ2V0L3NldCBvZiBleHRlbmRlZCBUT0Qt
Q2xvY2sgZm9yIGd1ZXN0Li4uCkVSUk9SOiBFcnJvciBtZXNzYWdlcyBzaG91bGQgbm90IGNvbnRh
aW4gbmV3bGluZXMKIzM0OiBGSUxFOiBody9zMzkweC9zMzkwLXZpcnRpby1jY3cuYzoyMTc6Cisg
ICAgICAgICAgICAgICAgICAgICAiczM5MF9nZXRfY2xvY2sgcmV0dXJuZWQgZXJyb3IgJWQuXG4i
LCByKTsKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMTM0IGxpbmVzIGNoZWNrZWQKCllv
dXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRo
ZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFp
bmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoK
VGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1
dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5k
IHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
