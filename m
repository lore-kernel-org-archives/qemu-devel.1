Received: from eggs.gnu.org ([209.51.188.92]:54874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gpKfT-0001he-Qs
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:18:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gpKfS-0004Or-Fz
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:18:43 -0500
Resent-Message-Id: <E1gpKfS-0004Or-Fz@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gpKfQ-0004LT-RK
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:18:41 -0500
Message-ID: <154896676366.23946.2614766302885826651@ebba9967afc0>
In-Reply-To: <20190131202637.4062-1-jusual@mail.ru>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 31 Jan 2019 12:32:45 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] monitor: Add whitelist support for QMP
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, jim@groklearning.com, contrib@steffen-goertz.de, armbru@redhat.com, joel@jms.id.au, stefanha@redhat.com, pbonzini@redhat.com, jusual@mail.ru

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDEzMTIwMjYzNy40MDYy
LTEtanVzdWFsQG1haWwucnUvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBzb21l
IGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZvcm1h
dGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5MDEzMTIwMjYzNy40MDYyLTEtanVz
dWFsQG1haWwucnUKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSF0gbW9uaXRvcjogQWRkIHdo
aXRlbGlzdCBzdXBwb3J0IGZvciBRTVAgY29tbWFuZHMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9
PT0KIyEvYmluL2Jhc2gKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQg
Y29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
YWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJh
c2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIx
NjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXBy
b2plY3QvcWVtdQogLSBbdGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3LzIwMTkwMTMwMTU1NzMzLjMy
NzQyLTEtZGF2aWRAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMTkwMTMwMTU1NzMzLjMyNzQyLTEt
ZGF2aWRAcmVkaGF0LmNvbQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMTkwMTMxMjAy
NjM3LjQwNjItMS1qdXN1YWxAbWFpbC5ydSAtPiBwYXRjaGV3LzIwMTkwMTMxMjAyNjM3LjQwNjIt
MS1qdXN1YWxAbWFpbC5ydQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjViN2Y5YmUg
bW9uaXRvcjogQWRkIHdoaXRlbGlzdCBzdXBwb3J0IGZvciBRTVAgY29tbWFuZHMKCj09PSBPVVRQ
VVQgQkVHSU4gPT09CkVSUk9SOiBBdXRob3IgZW1haWwgYWRkcmVzcyBpcyBtYW5nbGVkIGJ5IHRo
ZSBtYWlsaW5nIGxpc3QKIzI6IApBdXRob3I6IEp1bGlhIFN1dm9yb3ZhIHZpYSBRZW11LWRldmVs
IDxxZW11LWRldmVsQG5vbmdudS5vcmc+Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDIw
NiBsaW5lcyBjaGVja2VkCgpDb21taXQgNWI3ZjliZTBiYmQ2IChtb25pdG9yOiBBZGQgd2hpdGVs
aXN0IHN1cHBvcnQgZm9yIFFNUCBjb21tYW5kcykgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2Ug
cmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9y
dCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4K
PT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRo
ZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTAx
MzEyMDI2MzcuNDA2Mi0xLWp1c3VhbEBtYWlsLnJ1L3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1t
ZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0
cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1k
ZXZlbEByZWRoYXQuY29t
