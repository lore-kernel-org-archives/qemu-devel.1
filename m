Received: from eggs.gnu.org ([2001:4830:134:3::10]:42706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1duhkJ-00008k-1z
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 12:21:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1duhkF-00031i-PG
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 12:21:07 -0400
Resent-Message-Id: <E1duhkF-00031i-PG@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21485)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1duhkF-00030w-Hs
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 12:21:03 -0400
In-Reply-To: <f6da1ec7-4845-fe78-b6b8-29a71d481458@de.ibm.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <150592444730.27.1338735295153306404@d650bbe78fe3>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 20 Sep 2017 09:20:47 -0700 (PDT)
Subject: Re: [Qemu-devel] block ais migration for machines <= 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: borntraeger@de.ibm.com
Cc: famz@redhat.com, peter.maydell@linaro.org, thuth@redhat.com, zyimin@linux.vnet.ibm.com, mdroth@linux.vnet.ibm.com, cohuck@redhat.com, qemu-devel@nongnu.org, agraf@suse.de, pasic@linux.vnet.ibm.com, rth@twiddle.net

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIGJsb2NrIGFpcyBtaWdyYXRpb24gZm9yIG1hY2hpbmVzIDw9IDIuOQpNZXNzYWdlLWlk
OiBmNmRhMWVjNy00ODQ1LWZlNzgtYjZiOC0yOWE3MWQ0ODE0NThAZGUuaWJtLmNvbQpUeXBlOiBz
ZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKCkJBU0U9YmFzZQpu
PTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAkQkFTRS4uIHwgd2MgLWwpCmZhaWxlZD0wCgpn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZXMgVHJ1ZQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJz
ZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2luZyBQQVRD
SCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAgIGlmICEg
Z2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1h
aWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZpCiAgICBu
PSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBk
YXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0
byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmMwYjMwODNjNzEgYmxvY2sgYWlzIG1pZ3JhdGlvbiBmb3Ig
bWFjaGluZXMgPD0gMi45Cgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6
IGJsb2NrIGFpcyBtaWdyYXRpb24gZm9yIG1hY2hpbmVzIDw9IDIuOS4uLgpFUlJPUjogc3VzcGVj
dCBjb2RlIGluZGVudCBmb3IgY29uZGl0aW9uYWwgc3RhdGVtZW50cyAoNCwgNykKIzczOiBGSUxF
OiB0YXJnZXQvczM5MHgva3ZtLmM6MzE1OgorICAgIGlmIChhaXNfYWxsb3dlZCgpKSB7CisgICAg
ICAga3ZtX3ZtX2VuYWJsZV9jYXAocywgS1ZNX0NBUF9TMzkwX0FJUywgMCk7CgpFUlJPUjogTWlz
c2luZyBTaWduZWQtb2ZmLWJ5OiBsaW5lKHMpCgp0b3RhbDogMiBlcnJvcnMsIDAgd2FybmluZ3Ms
IDUwIGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2Ug
cmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9y
dCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4K
Cj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgot
LS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNo
ZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVl
bGlzdHMub3Jn
