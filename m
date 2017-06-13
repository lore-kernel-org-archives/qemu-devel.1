Received: from eggs.gnu.org ([2001:4830:134:3::10]:45410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dKv1q-0000wK-Qu
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 19:15:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dKv1n-00040x-Ka
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 19:15:18 -0400
Resent-Message-Id: <E1dKv1n-00040x-Ka@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1dKv1n-00040j-Bp
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 19:15:15 -0400
In-Reply-To: <20170613225900.1641-1-sam.brian@accelerated.com>
Message-ID: <149739570651.360.14952020309543710273@4a9a010726c0>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 13 Jun 2017 16:15:07 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2] usb-host: support devices with
 sparse/non-sequential USB interfaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sam.brian@accelerated.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAx
NzA2MTMyMjU5MDAuMTY0MS0xLXNhbS5icmlhbkBhY2NlbGVyYXRlZC5jb20KVHlwZTogc2VyaWVz
ClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggdjJdIHVzYi1ob3N0OiBzdXBwb3J0IGRldmlj
ZXMgd2l0aCBzcGFyc2Uvbm9uLXNlcXVlbnRpYWwgVVNCIGludGVyZmFjZXMKCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9n
IC0tb25lbGluZSAkQkFTRS4uIHwgd2MgLWwpCmZhaWxlZD0wCgpnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQoK
Y29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMg
aW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0
IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3Jt
YXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAg
ICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4
aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFm
Zjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRj
aGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMTcwNjEzMjMw
NjI3LjE3OTQyLTEtZWhhYmtvc3RAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMTcwNjEzMjMwNjI3
LjE3OTQyLTEtZWhhYmtvc3RAcmVkaGF0LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rl
c3QnCjA2NWFhZDggdXNiLWhvc3Q6IHN1cHBvcnQgZGV2aWNlcyB3aXRoIHNwYXJzZS9ub24tc2Vx
dWVudGlhbCBVU0IgaW50ZXJmYWNlcwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KQ2hlY2tpbmcgUEFU
Q0ggMS8xOiB1c2ItaG9zdDogc3VwcG9ydCBkZXZpY2VzIHdpdGggc3BhcnNlL25vbi1zZXF1ZW50
aWFsIFVTQiBpbnRlcmZhY2VzLi4uCkVSUk9SOiBzdXNwZWN0IGNvZGUgaW5kZW50IGZvciBjb25k
aXRpb25hbCBzdGF0ZW1lbnRzICg4LCAxMykKIzc4OiBGSUxFOiBody91c2IvaG9zdC1saWJ1c2Iu
YzoxMTcxOgorICAgICAgICBpZiAocmMgPT0gMCkgeworICAgICAgICAgICAgIHMtPmlmc1tpXS5j
bGFpbWVkID0gdHJ1ZTsKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgNTkgbGluZXMgY2hl
Y2tlZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBh
bnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhl
IG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBF
TkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKCi0tLQpFbWFpbCBnZW5l
cmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxl
YXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQGZyZWVsaXN0cy5vcmc=
