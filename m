Received: from eggs.gnu.org ([209.51.188.92]:52919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1grxLe-0001M8-GL
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 23:01:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1grxLd-00017y-BA
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 23:01:06 -0500
Resent-Message-Id: <E1grxLd-00017y-BA@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1grxLd-00015t-3K
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 23:01:05 -0500
Message-ID: <154959844954.29184.7443590448859351019@ebba9967afc0>
In-Reply-To: <20190208035551.3036-1-richard.henderson@linaro.org>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 7 Feb 2019 20:00:50 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] tcg: Diagnose referenced labels that have
 not been emitted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: fam@euphon.net, qemu-devel@nongnu.org

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDIwODAzNTU1MS4zMDM2
LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVt
cyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZv
cgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSF0gdGNnOiBE
aWFnbm9zZSByZWZlcmVuY2VkIGxhYmVscyB0aGF0IGhhdmUgbm90IGJlZW4gZW1pdHRlZApUeXBl
OiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxOTAyMDgwMzU1NTEuMzAzNi0xLXJpY2hhcmQuaGVuZGVy
c29uQGxpbmFyby5vcmcKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3Jh
bQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJ
UFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcx
MzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3
IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3LzIwMTkwMjA4MDM1NTUxLjMwMzYtMS1yaWNoYXJk
LmhlbmRlcnNvbkBsaW5hcm8ub3JnIC0+IHBhdGNoZXcvMjAxOTAyMDgwMzU1NTEuMzAzNi0xLXJp
Y2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0
Jwo3MDJhMTUyZjdkIHRjZzogRGlhZ25vc2UgcmVmZXJlbmNlZCBsYWJlbHMgdGhhdCBoYXZlIG5v
dCBiZWVuIGVtaXR0ZWQKCj09PSBPVVRQVVQgQkVHSU4gPT09CkVSUk9SOiBzcGFjZXMgcHJvaGli
aXRlZCBhcm91bmQgdGhhdCAnOicgKGN0eDpXeFcpCiM5MDogRklMRTogdGNnL3RjZy5oOjI0OToK
KyAgICB1bnNpZ25lZCBwcmVzZW50IDogMTsKICAgICAgICAgICAgICAgICAgICAgIF4KCkVSUk9S
OiBzcGFjZXMgcHJvaGliaXRlZCBhcm91bmQgdGhhdCAnOicgKGN0eDpXeFcpCiM5MzogRklMRTog
dGNnL3RjZy5oOjI1MToKKyAgICB1bnNpZ25lZCBpZCA6IDE0OwogICAgICAgICAgICAgICAgIF4K
CnRvdGFsOiAyIGVycm9ycywgMCB3YXJuaW5ncywgNzkgbGluZXMgY2hlY2tlZAoKQ29tbWl0IDcw
MmExNTJmN2QwNiAodGNnOiBEaWFnbm9zZSByZWZlcmVuY2VkIGxhYmVscyB0aGF0IGhhdmUgbm90
IGJlZW4gZW1pdHRlZCkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55
IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBt
YWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQg
PT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBh
dmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTAyMDgwMzU1NTEuMzAzNi0x
LXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1l
c3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRw
Oi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRl
dmVsQHJlZGhhdC5jb20=
