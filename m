Received: from eggs.gnu.org ([2001:4830:134:3::10]:33891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eiiy6-0006at-C5
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:46:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eiiy2-0003tY-CF
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:46:06 -0500
Resent-Message-Id: <E1eiiy2-0003tY-CF@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1eiiy2-0003rK-4Q
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:46:02 -0500
In-Reply-To: <1517842735-9011-1-git-send-email-jianfeng.tan@intel.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151784553530.66.16068374986829135875@bdbb90650ae5>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 5 Feb 2018 07:45:35 -0800 (PST)
Subject: Re: [Qemu-devel] [RFC] exec: eliminate ram naming issue as migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jianfeng.tan@intel.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, jasowang@redhat.com, maxime.coquelin@redhat.com, mst@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDE1MTc4NDI3MzUtOTAxMS0xLWdpdC1zZW5kLWVtYWlsLWppYW5mZW5nLnRhbkBp
bnRlbC5jb20KU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtSRkNdIGV4ZWM6IGVsaW1pbmF0ZSByYW0g
bmFtaW5nIGlzc3VlIGFzIG1pZ3JhdGlvbgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9i
aW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4g
fCB3YyAtbCkKZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIkKGdpdCBsb2cg
LS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsgZG8KICAg
IGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9
JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0
cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0xCiAgICAg
ICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBURVNU
IFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJk
ODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAq
IFtuZXcgdGFnXSAgICAgICAgICAgICAgIHBhdGNoZXcvMTUxNzg0MjczNS05MDExLTEtZ2l0LXNl
bmQtZW1haWwtamlhbmZlbmcudGFuQGludGVsLmNvbSAtPiBwYXRjaGV3LzE1MTc4NDI3MzUtOTAx
MS0xLWdpdC1zZW5kLWVtYWlsLWppYW5mZW5nLnRhbkBpbnRlbC5jb20KU3dpdGNoZWQgdG8gYSBu
ZXcgYnJhbmNoICd0ZXN0JwoyYTY0NWYwYmQ0IGV4ZWM6IGVsaW1pbmF0ZSByYW0gbmFtaW5nIGlz
c3VlIGFzIG1pZ3JhdGlvbgoKPT09IE9VVFBVVCBCRUdJTiA9PT0KQ2hlY2tpbmcgUEFUQ0ggMS8x
OiBleGVjOiBlbGltaW5hdGUgcmFtIG5hbWluZyBpc3N1ZSBhcyBtaWdyYXRpb24uLi4KRVJST1I6
IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojNjE6IEZJTEU6IGV4ZWMuYzoyMzc3
OgorXklpZDIgPSBiYXNlbmFtZShuYW1lMik7JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBu
ZXZlciB1c2UgdGFicwojNjQ6IEZJTEU6IGV4ZWMuYzoyMzgwOgorXkkgICAgZnJlZShuYW1lMik7
JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojNjc6IEZJTEU6IGV4
ZWMuYzoyMzgzOgorXklmcmVlKG5hbWUyKTskCgp0b3RhbDogMyBlcnJvcnMsIDAgd2FybmluZ3Ms
IDI1IGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2Ug
cmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9y
dCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4K
Cj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgot
LS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNo
ZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVl
bGlzdHMub3Jn
