Received: from eggs.gnu.org ([2001:4830:134:3::10]:36020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1d4RV2-0002g1-Vk
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 08:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1d4RV1-0007dK-RI
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 08:29:20 -0400
Resent-Message-Id: <E1d4RV1-0007dK-RI@eggs.gnu.org>
In-Reply-To: <20170429115509.27551-1-aik@ozlabs.ru>
Message-ID: <149346893378.132.3063923710149667629@c05f1edc8ed1>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sat, 29 Apr 2017 05:28:54 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH qemu v4] memory/iommu: QOM'fy IOMMU
 MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: aik@ozlabs.ru
Cc: famz@redhat.com, qemu-devel@nongnu.org, f4bug@amsat.org, peterx@redhat.com, borntraeger@de.ibm.com, alex.williamson@redhat.com, qemu-ppc@nongnu.org, cornelia.huck@de.ibm.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSCBxZW11IHY0XSBtZW1vcnkvaW9tbXU6IFFPTSdmeSBJT01NVSBNZW1vcnlS
ZWdpb24KTWVzc2FnZS1pZDogMjAxNzA0MjkxMTU1MDkuMjc1NTEtMS1haWtAb3psYWJzLnJ1ClR5
cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAoKQkFTRT1i
YXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3YyAtbCkKZmFpbGVk
PTAKCiMgVXNlZnVsIGdpdCBvcHRpb25zCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxp
bWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIkKGdp
dCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsg
ZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1m
b3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4v
c2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0x
CiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09
PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVm
N2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNzIxODdiNCBt
ZW1vcnkvaW9tbXU6IFFPTSdmeSBJT01NVSBNZW1vcnlSZWdpb24KCj09PSBPVVRQVVQgQkVHSU4g
PT09CkNoZWNraW5nIFBBVENIIDEvMTogbWVtb3J5L2lvbW11OiBRT00nZnkgSU9NTVUgTWVtb3J5
UmVnaW9uLi4uCkVSUk9SOiBzcGFjZXMgcmVxdWlyZWQgYXJvdW5kIHRoYXQgJyonIChjdHg6V3hP
KQojMTU2OiBGSUxFOiBody9kbWEvcmM0MDMwLmM6NzIwOgorRGV2aWNlU3RhdGUgKnJjNDAzMF9p
bml0KHJjNDAzMF9kbWEgKipkbWFzLCBJT01NVU1lbW9yeVJlZ2lvbiAqKmRtYV9tcikKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJu
aW5ncywgODI4IGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBw
bGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVz
IHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJ
TkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6
IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDov
L3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZl
bEBmcmVlbGlzdHMub3Jn
