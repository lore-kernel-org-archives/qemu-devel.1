Received: from eggs.gnu.org ([2001:4830:134:3::10]:48203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ePUhu-000643-PU
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:42:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ePUhq-00052t-Q8
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:41:54 -0500
Resent-Message-Id: <E1ePUhq-00052t-Q8@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21391)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1ePUhq-000523-IQ
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:41:50 -0500
In-Reply-To: <20171214143713.3795-1-programmingkidx@gmail.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151326249360.96.14397956400396078226@449822a21bf0>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 14 Dec 2017 06:41:34 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v2] Add ability for user to specify mouse
 ungrab key
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: programmingkidx@gmail.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org, kraxel@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAx
NzEyMTQxNDM3MTMuMzc5NS0xLXByb2dyYW1taW5na2lkeEBnbWFpbC5jb20KU3ViamVjdDogW1Fl
bXUtZGV2ZWxdIFtQQVRDSCB2Ml0gQWRkIGFiaWxpdHkgZm9yIHVzZXIgdG8gc3BlY2lmeSBtb3Vz
ZSB1bmdyYWIga2V5ClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9i
aW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4g
fCB3YyAtbCkKZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIkKGdpdCBsb2cg
LS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsgZG8KICAg
IGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9
JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0
cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0xCiAgICAg
ICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBURVNU
IFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJk
ODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiB0
IFt0YWcgdXBkYXRlXSAgICAgICAgICAgIHBhdGNoZXcvMjAxNzEyMDUwNTUyMDAuMTYzMDUtMS1w
ZXRlcnhAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMTcxMjA1MDU1MjAwLjE2MzA1LTEtcGV0ZXJ4
QHJlZGhhdC5jb20KIHQgW3RhZyB1cGRhdGVdICAgICAgICAgICAgcGF0Y2hldy8yMDE3MTIwNTA2
NTMwNy4yMTg1My0xLXBldGVyeEByZWRoYXQuY29tIC0+IHBhdGNoZXcvMjAxNzEyMDUwNjUzMDcu
MjE4NTMtMS1wZXRlcnhAcmVkaGF0LmNvbQogdCBbdGFnIHVwZGF0ZV0gICAgICAgICAgICBwYXRj
aGV3LzIwMTcxMjE0MTI0ODE3LjI1NjctMS1kZ2lsYmVydEByZWRoYXQuY29tIC0+IHBhdGNoZXcv
MjAxNzEyMTQxMjQ4MTcuMjU2Ny0xLWRnaWxiZXJ0QHJlZGhhdC5jb20KICogW25ldyB0YWddICAg
ICAgICAgICAgICAgcGF0Y2hldy8yMDE3MTIxNDE0MzcxMy4zNzk1LTEtcHJvZ3JhbW1pbmdraWR4
QGdtYWlsLmNvbSAtPiBwYXRjaGV3LzIwMTcxMjE0MTQzNzEzLjM3OTUtMS1wcm9ncmFtbWluZ2tp
ZHhAZ21haWwuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKODI5MzU2ZGYwYiBB
ZGQgYWJpbGl0eSBmb3IgdXNlciB0byBzcGVjaWZ5IG1vdXNlIHVuZ3JhYiBrZXkKCj09PSBPVVRQ
VVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMTogQWRkIGFiaWxpdHkgZm9yIHVzZXIgdG8g
c3BlY2lmeSBtb3VzZSB1bmdyYWIga2V5Li4uCkVSUk9SOiBleHRlcm5zIHNob3VsZCBiZSBhdm9p
ZGVkIGluIC5jIGZpbGVzCiMxNDU6IEZJTEU6IHZsLmM6MzE0MzoKK2ludCBnZXRfdW5ncmFiX2tl
eV92YWx1ZSh2b2lkKTsKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMTM5IGxpbmVzIGNo
ZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYg
YW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRo
ZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQg
RU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2Vu
ZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBs
ZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
