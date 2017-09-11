Received: from eggs.gnu.org ([2001:4830:134:3::10]:51130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1drQcw-00014K-9D
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:27:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1drQcs-0002Hs-3J
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:27:58 -0400
Resent-Message-Id: <E1drQcs-0002Hs-3J@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1drQcr-0002Gf-Qk
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:27:54 -0400
In-Reply-To: <1505143227-14324-1-git-send-email-arei.gonglei@huawei.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <150514364838.243.1872442164608937092@6d89bd104fc3>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 11 Sep 2017 08:27:29 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] i386/cpu/hyperv: support over 64 vcpus for
 windows guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: arei.gonglei@huawei.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, weidong.huang@huawei.com, ehabkost@redhat.com, mst@redhat.com, mtosatti@redhat.com, vrozenfe@redhat.com, pbonzini@redhat.com, rth@twiddle.net

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSF0gaTM4Ni9jcHUvaHlwZXJ2OiBzdXBwb3J0IG92ZXIgNjQgdmNwdXMgZm9y
IHdpbmRvd3MgZ3Vlc3RzCk1lc3NhZ2UtaWQ6IDE1MDUxNDMyMjctMTQzMjQtMS1naXQtc2VuZC1l
bWFpbC1hcmVpLmdvbmdsZWlAaHVhd2VpLmNvbQpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0t
b25lbGluZSAkQkFTRS4uIHwgd2MgLWwpCmZhaWxlZD0wCgpnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQoKY29t
bWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4g
JGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxv
ZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9
ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAg
ICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQg
JGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3
ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3
LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3LzE1MDUxNDMy
MjctMTQzMjQtMS1naXQtc2VuZC1lbWFpbC1hcmVpLmdvbmdsZWlAaHVhd2VpLmNvbSAtPiBwYXRj
aGV3LzE1MDUxNDMyMjctMTQzMjQtMS1naXQtc2VuZC1lbWFpbC1hcmVpLmdvbmdsZWlAaHVhd2Vp
LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmExZGYwMzljMGMgaTM4Ni9jcHUv
aHlwZXJ2OiBzdXBwb3J0IG92ZXIgNjQgdmNwdXMgZm9yIHdpbmRvd3MgZ3Vlc3RzCgo9PT0gT1VU
UFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6IGkzODYvY3B1L2h5cGVydjogc3VwcG9y
dCBvdmVyIDY0IHZjcHVzIGZvciB3aW5kb3dzIGd1ZXN0cy4uLgpFUlJPUjogbGluZSBvdmVyIDkw
IGNoYXJhY3RlcnMKIzc5OiBGSUxFOiB0YXJnZXQvaTM4Ni9rdm0uYzo3NTg6CisgICAgICAgICAq
IGh0dHBzOi8vZG9jcy5taWNyb3NvZnQuY29tL2VuLXVzL3ZpcnR1YWxpemF0aW9uL2h5cGVyLXYt
b24td2luZG93cy9yZWZlcmVuY2UvdGxmcwoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA0
NyBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJl
dmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQg
dGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9
PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0t
CkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3
Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJlZWxp
c3RzLm9yZw==
