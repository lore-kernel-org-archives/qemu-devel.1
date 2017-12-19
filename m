Received: from eggs.gnu.org ([2001:4830:134:3::10]:39639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eRRF5-0006gW-VM
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 18:24:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eRRF2-00032I-Q2
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 18:24:11 -0500
Resent-Message-Id: <E1eRRF2-00032I-Q2@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1eRRF2-000316-Gl
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 18:24:08 -0500
In-Reply-To: <1513724822-25232-1-git-send-email-nutarojj@ornl.gov>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151372583496.81.4087757779829737900@5adcb62bf0d6>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 19 Dec 2017 15:23:56 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH V10] qqq: module for synchronizing with a
 simulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: nutarojj@ornl.gov
Cc: famz@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, cota@braap.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDE1MTM3MjQ4MjItMjUyMzItMS1naXQtc2VuZC1lbWFpbC1udXRhcm9qakBvcm5s
LmdvdgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIFYxMF0gcXFxOiBtb2R1bGUgZm9yIHN5
bmNocm9uaXppbmcgd2l0aCBhIHNpbXVsYXRpb24KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0K
IyEvYmluL2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAkQkFT
RS4uIHwgd2MgLWwpCmZhaWxlZD0wCgpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1p
dCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQoKY29tbWl0cz0iJChnaXQg
bG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRv
CiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9y
bWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3Nj
cmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQog
ICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0g
VEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdm
NDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjkxYjA2NGYwYWEg
cXFxOiBtb2R1bGUgZm9yIHN5bmNocm9uaXppbmcgd2l0aCBhIHNpbXVsYXRpb24KCj09PSBPVVRQ
VVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMTogcXFxOiBtb2R1bGUgZm9yIHN5bmNocm9u
aXppbmcgd2l0aCBhIHNpbXVsYXRpb24uLi4KRVJST1I6IHNwYWNlIHJlcXVpcmVkIGFmdGVyIHRo
YXQgJywnIChjdHg6VnhWKQojNDQ0OiBGSUxFOiB2bC5jOjQwMzE6CisgICAgICAgICAgICAgICAg
ICAgICAgICBxZW11X2ZpbmRfb3B0cygiZXh0ZXJuYWxfc2ltIiksb3B0YXJnLHRydWUpOwogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoKRVJS
T1I6IHNwYWNlIHJlcXVpcmVkIGFmdGVyIHRoYXQgJywnIChjdHg6VnhWKQojNDQ0OiBGSUxFOiB2
bC5jOjQwMzE6CisgICAgICAgICAgICAgICAgICAgICAgICBxZW11X2ZpbmRfb3B0cygiZXh0ZXJu
YWxfc2ltIiksb3B0YXJnLHRydWUpOwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KCnRvdGFsOiAyIGVycm9ycywgMCB3YXJuaW5n
cywgNDAwIGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVh
c2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJl
cG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVS
Uy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEK
CgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3Bh
dGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBm
cmVlbGlzdHMub3Jn
