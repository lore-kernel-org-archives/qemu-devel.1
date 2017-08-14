Received: from eggs.gnu.org ([2001:4830:134:3::10]:38178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dhIUg-00065r-5z
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 12:45:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dhIUb-0005lr-Ss
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 12:45:34 -0400
Resent-Message-Id: <E1dhIUb-0005lr-Ss@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1dhIUb-0005ka-LJ
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 12:45:29 -0400
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <150272911898.78.981462169854023805@dd743fd916bd>
In-Reply-To: <20170814162142.29666-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 14 Aug 2017 09:45:19 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/2] trace: fix simpletrace.stp
 flight recorder mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAx
NzA4MTQxNjIxNDIuMjk2NjYtMS1zdGVmYW5oYUByZWRoYXQuY29tClN1YmplY3Q6IFtRZW11LWRl
dmVsXSBbUEFUQ0ggZm9yLTIuMTAgMC8yXSB0cmFjZTogZml4IHNpbXBsZXRyYWNlLnN0cCBmbGln
aHQgcmVjb3JkZXIgbW9kZQpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0K
IyEvYmluL2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAkQkFT
RS4uIHwgd2MgLWwpCmZhaWxlZD0wCgpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1p
dCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQoKY29tbWl0cz0iJChnaXQg
bG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRv
CiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9y
bWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3Nj
cmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQog
ICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0g
VEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdm
NDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVt
dQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3LzIwMTcwODE0MTY0MDAyLjIzOTgy
LTEtYnJpamVzaC5zaW5naEBhbWQuY29tIC0+IHBhdGNoZXcvMjAxNzA4MTQxNjQwMDIuMjM5ODIt
MS1icmlqZXNoLnNpbmdoQGFtZC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo0
NWU5YzU2YTRmIHNpbXBsZXRyYWNlOiBmaXggZmxpZ2h0IHJlY29yZGVyIC0tbm8taGVhZGVyIG9w
dGlvbgoxOTJkNGZjMmJjIHRyYWNlOiB1c2Ugc3RhdGljIGV2ZW50IElEIG1hcHBpbmcgaW4gc2lt
cGxldHJhY2Uuc3RwCgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzI6IHRy
YWNlOiB1c2Ugc3RhdGljIGV2ZW50IElEIG1hcHBpbmcgaW4gc2ltcGxldHJhY2Uuc3RwLi4uCkNo
ZWNraW5nIFBBVENIIDIvMjogc2ltcGxldHJhY2U6IGZpeCBmbGlnaHQgcmVjb3JkZXIgLS1uby1o
ZWFkZXIgb3B0aW9uLi4uCkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwojMzk6IEZJTEU6
IHNjcmlwdHMvc2ltcGxldHJhY2UucHk6MTAxOgorICAgICIiIkRlc2VyaWFsaXplIHRyYWNlIHJl
Y29yZHMgZnJvbSBhIGZpbGUsIHlpZWxkaW5nIHJlY29yZCB0dXBsZXMgKGV2ZW50X251bSwgdGlt
ZXN0YW1wLCBwaWQsIGFyZzEsIC4uLiwgYXJnNikuCgp0b3RhbDogMSBlcnJvcnMsIDAgd2Fybmlu
Z3MsIDQ2IGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVh
c2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJl
cG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVS
Uy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEK
CgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3Bh
dGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBm
cmVlbGlzdHMub3Jn
