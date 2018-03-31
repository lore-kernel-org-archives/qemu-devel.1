Received: from eggs.gnu.org ([2001:4830:134:3::10]:38842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1f2BQ1-0003mZ-ON
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 03:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1f2BPy-0005TE-Ik
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 03:59:21 -0400
Resent-Message-Id: <E1f2BPy-0005TE-Ik@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1f2BPy-0005SY-Ag
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 03:59:18 -0400
In-Reply-To: <152246970464.28900.5033274314150943057.malonedeb@chaenomeles.canonical.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152248314962.864.11748946482282342235@71c20359a636>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sat, 31 Mar 2018 00:59:10 -0700 (PDT)
Subject: Re: [Qemu-devel] [Bug 1760262] [NEW] cmsdk-apb-uart doesn't appear
 to clear interrupt flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: patrick.oppenlander@gmail.com
Cc: famz@redhat.com, qemu-devel@nongnu.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDE1MjI0Njk3MDQ2NC4yODkwMC41MDMzMjc0MzE0MTUwOTQzMDU3Lm1hbG9uZWRl
YkBjaGFlbm9tZWxlcy5jYW5vbmljYWwuY29tClN1YmplY3Q6IFtRZW11LWRldmVsXSBbQnVnIDE3
NjAyNjJdIFtORVddIGNtc2RrLWFwYi11YXJ0IGRvZXNuJ3QgYXBwZWFyIHRvIGNsZWFyIGludGVy
cnVwdCBmbGFncwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAoKQkFTRT1i
YXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3YyAtbCkKZmFpbGVk
PTAKCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBo
aXN0b2dyYW0KCmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0Uu
LikiCmZvciBjIGluICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRv
dGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93
ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAt
OyB0aGVuCiAgICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEp
KQpkb25lCgpleGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNj
OGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcg
YnJhbmNoICd0ZXN0JwoxMWU1ZTZiNDhjIGNtc2RrLWFwYi11YXJ0IGRvZXNuJ3QgYXBwZWFyIHRv
IGNsZWFyIGludGVycnVwdCBmbGFncwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KQ2hlY2tpbmcgUEFU
Q0ggMS8xOiBjbXNkay1hcGItdWFydCBkb2Vzbid0IGFwcGVhciB0byBjbGVhciBpbnRlcnJ1cHQg
ZmxhZ3MuLi4KV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzM1OiBGSUxFOiBody9j
aGFyL2Ntc2RrLWFwYi11YXJ0LmM6Mjc3OgorICAgICAgICBzLT5pbnRzdGF0dXMgJj0gfih2YWx1
ZSAmIH4oUl9JTlRTVEFUVVNfVFhPX01BU0sgfCBSX0lOVFNUQVRVU19SWE9fTUFTSykpOwoKRVJS
T1I6IE1pc3NpbmcgU2lnbmVkLW9mZi1ieTogbGluZShzKQoKdG90YWw6IDEgZXJyb3JzLCAxIHdh
cm5pbmdzLCA3IGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBw
bGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVz
IHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJ
TkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6
IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDov
L3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZl
bEByZWRoYXQuY29t
