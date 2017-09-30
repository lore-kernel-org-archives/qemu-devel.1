Received: from eggs.gnu.org ([2001:4830:134:3::10]:50320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dyDjA-00048T-R4
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 05:06:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dyDj7-0005uD-Lp
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 05:06:28 -0400
Resent-Message-Id: <E1dyDj7-0005uD-Lp@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21305)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1dyDj7-0005qu-Dz
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 05:06:25 -0400
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <150676232379.93.15627116010984840420@b58463cdfd5f>
In-Reply-To: <1506762042-32145-1-git-send-email-jiang.biao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sat, 30 Sep 2017 02:05:24 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] tcg/mips: delete commented out extern
 keyword.
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: jiang.biao2@zte.com.cn
Cc: famz@redhat.com, aurelien@aurel32.net, rth@twiddle.net, zhong.weidong@zte.com.cn, qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDE1MDY3NjIwNDItMzIxNDUtMS1naXQtc2VuZC1lbWFpbC1qaWFuZy5iaWFvMkB6
dGUuY29tLmNuClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hdIHRjZy9taXBzOiBkZWxldGUg
Y29tbWVudGVkIG91dCBleHRlcm4ga2V5d29yZC4KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0K
IyEvYmluL2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAkQkFT
RS4uIHwgd2MgLWwpCmZhaWxlZD0wCgpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1p
dCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQoKY29tbWl0cz0iJChnaXQg
bG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRv
CiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9y
bWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3Nj
cmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQog
ICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0g
VEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdm
NDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmFhZTRkN2UzNDkg
dGNnL21pcHM6IGRlbGV0ZSBjb21tZW50ZWQgb3V0IGV4dGVybiBrZXl3b3JkLgoKPT09IE9VVFBV
VCBCRUdJTiA9PT0KQ2hlY2tpbmcgUEFUQ0ggMS8xOiB0Y2cvbWlwczogZGVsZXRlIGNvbW1lbnRl
ZCBvdXQgZXh0ZXJuIGtleXdvcmQuLi4uCkVSUk9SOiBleHRlcm5zIHNob3VsZCBiZSBhdm9pZGVk
IGluIC5jIGZpbGVzCiMyMDogRklMRTogdGNnL21pcHMvdGNnLXRhcmdldC5pbmMuYzozOToKK2lu
dCBsaW5rX2Vycm9yKHZvaWQpOwoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA4IGxpbmVz
IGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAg
SWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRv
IHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQ
VVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwg
Z2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
