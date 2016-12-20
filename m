Received: from eggs.gnu.org ([2001:4830:134:3::10]:34497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cJTRT-0008GR-Ex
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 18:03:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cJTRQ-0004mR-My
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 18:03:31 -0500
Resent-Message-Id: <E1cJTRQ-0004mR-My@eggs.gnu.org>
Received: from sender163-mail.zoho.com ([74.201.84.163]:21325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1cJTRQ-0004kf-FD
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 18:03:28 -0500
In-Reply-To: <1482158486-18597-1-git-send-email-peterx@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <148227497312.73.13130379400389723612@790289a7ca88>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 20 Dec 2016 15:02:54 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] intel_iommu: allow dynamic switch of IOMMU
 region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peterx@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com, david@gibson.dropbear.id.au

SGksCgpZb3VyIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSF0gaW50ZWxfaW9tbXU6IGFsbG93IGR5bmFtaWMgc3dpdGNoIG9mIElPTU1V
IHJlZ2lvbgpNZXNzYWdlLWlkOiAxNDgyMTU4NDg2LTE4NTk3LTEtZ2l0LXNlbmQtZW1haWwtcGV0
ZXJ4QHJlZGhhdC5jb20KVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMh
L2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0Uu
LiB8IHdjIC1sKQpmYWlsZWQ9MAoKIyBVc2VmdWwgZ2l0IG9wdGlvbnMKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRy
dWUKCmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZv
ciBjIGluICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAk
KGdpdCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0t
Zm9ybWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVu
CiAgICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpkb25l
CgpleGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5
YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNo
ICd0ZXN0JwphZTczOGEzIGludGVsX2lvbW11OiBhbGxvdyBkeW5hbWljIHN3aXRjaCBvZiBJT01N
VSByZWdpb24KCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMTogaW50ZWxf
aW9tbXU6IGFsbG93IGR5bmFtaWMgc3dpdGNoIG9mIElPTU1VIHJlZ2lvbi4uLgpFUlJPUjogIihm
b28qKikiIHNob3VsZCBiZSAiKGZvbyAqKikiCiM1NTogRklMRTogaHcvaTM4Ni9pbnRlbF9pb21t
dS5jOjExOTA6CisgICAgd2hpbGUgKGdfaGFzaF90YWJsZV9pdGVyX25leHQgKCZpdGVyLCBOVUxM
LCAodm9pZCoqKSZ2dGRfYnVzKSkgewoKRVJST1I6IHNwYWNlIHByb2hpYml0ZWQgYmV0d2VlbiBm
dW5jdGlvbiBuYW1lIGFuZCBvcGVuIHBhcmVudGhlc2lzICcoJwojNTU6IEZJTEU6IGh3L2kzODYv
aW50ZWxfaW9tbXUuYzoxMTkwOgorICAgIHdoaWxlIChnX2hhc2hfdGFibGVfaXRlcl9uZXh0ICgm
aXRlciwgTlVMTCwgKHZvaWQqKikmdnRkX2J1cykpIHsKCnRvdGFsOiAyIGVycm9ycywgMCB3YXJu
aW5ncywgMTE4IGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBw
bGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVz
IHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJ
TkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6
IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDov
L3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZl
bEBmcmVlbGlzdHMub3Jn
