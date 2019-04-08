Received: from eggs.gnu.org ([209.51.188.92]:40481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hDXrF-0006CJ-US
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 13:14:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hDXrC-00017G-81
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 13:14:57 -0400
Resent-Message-Id: <E1hDXrC-00017G-81@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hDXrB-00016X-Tv
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 13:14:54 -0400
Message-ID: <155474277106.12882.8346453217758632698@76452e4e88f2>
In-Reply-To: <20190408145721.15881-1-sohailalvi2236@gmail.com>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 8 Apr 2019 09:59:32 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] qemu_system_reset_request() in hw/
 corresponding to watchdog that has triggered replaced by
 watchdog_perform_action().
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sohailalvi2236@gmail.com
Cc: fam@euphon.net, qemu-devel@nongnu.org

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQwODE0NTcyMS4xNTg4
MS0xLXNvaGFpbGFsdmkyMjM2QGdtYWlsLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0
byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgpt
b3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAxOTA0MDgxNDU3MjEuMTU4ODEtMS1zb2hh
aWxhbHZpMjIzNkBnbWFpbC5jb20KU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSF0gcWVtdV9z
eXN0ZW1fcmVzZXRfcmVxdWVzdCgpIGluIGh3LyBjb3JyZXNwb25kaW5nIHRvIHdhdGNoZG9nIHRo
YXQgaGFzIHRyaWdnZXJlZCByZXBsYWNlZCBieSB3YXRjaGRvZ19wZXJmb3JtX2FjdGlvbigpLgpU
eXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJl
di1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQg
Y29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3Bh
dGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGlu
ZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9n
aXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAgIGY1NWE1ODVkMTAuLjJjNTczMTA2Mjcg
IG1hc3RlciAgICAgLT4gbWFzdGVyCiAqIFtuZXcgdGFnXSAgICAgICAgICAgICAgIHBhdGNoZXcv
MjAxOTA0MDgxNDU3MjEuMTU4ODEtMS1zb2hhaWxhbHZpMjIzNkBnbWFpbC5jb20gLT4gcGF0Y2hl
dy8yMDE5MDQwODE0NTcyMS4xNTg4MS0xLXNvaGFpbGFsdmkyMjM2QGdtYWlsLmNvbQpTd2l0Y2hl
ZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjA1Njg2ZjliOTEgcWVtdV9zeXN0ZW1fcmVzZXRfcmVx
dWVzdCgpIGluIGh3LyBjb3JyZXNwb25kaW5nIHRvIHdhdGNoZG9nIHRoYXQgaGFzIHRyaWdnZXJl
ZCByZXBsYWNlZCBieSB3YXRjaGRvZ19wZXJmb3JtX2FjdGlvbigpLgoKPT09IE9VVFBVVCBCRUdJ
TiA9PT0KRVJST1I6IE1pc3NpbmcgU2lnbmVkLW9mZi1ieTogbGluZShzKQoKdG90YWw6IDEgZXJy
b3JzLCAwIHdhcm5pbmdzLCA5MCBsaW5lcyBjaGVja2VkCgpDb21taXQgMDU2ODZmOWI5MTBkIChx
ZW11X3N5c3RlbV9yZXNldF9yZXF1ZXN0KCkgaW4gaHcvIGNvcnJlc3BvbmRpbmcgdG8gd2F0Y2hk
b2cgdGhhdCBoYXMgdHJpZ2dlcmVkIHJlcGxhY2VkIGJ5IHdhdGNoZG9nX3BlcmZvcm1fYWN0aW9u
KCkuKSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2Ug
ZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIs
IHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3Qg
Y29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBh
dApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDQwODE0NTcyMS4xNTg4MS0xLXNvaGFpbGFs
dmkyMjM2QGdtYWlsLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVt
YWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5v
cmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5j
b20=
