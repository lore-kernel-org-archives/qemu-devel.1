Received: from eggs.gnu.org ([209.51.188.92]:50867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hG65Z-00028R-Gt
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 14:12:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hG65Y-00008N-AH
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 14:12:17 -0400
Resent-Message-Id: <E1hG65Y-00008N-AH@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hG65X-00007k-VM
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 14:12:16 -0400
Message-ID: <155535189493.14176.10363908934654471797@76452e4e88f2>
In-Reply-To: <20190415180618.1450-1-samuel.thibault@ens-lyon.org>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 15 Apr 2019 11:11:36 -0700 (PDT)
Subject: Re: [Qemu-devel] [PULL 0/1] slirp gcc9 build fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: samuel.thibault@ens-lyon.org
Cc: fam@euphon.net, qemu-devel@nongnu.org, peter.maydell@linaro.org, stefanha@redhat.com, jan.kiszka@siemens.com

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQxNTE4MDYxOC4xNDUw
LTEtc2FtdWVsLnRoaWJhdWx0QGVucy1seW9uLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVt
cyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZv
cgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAxOTA0MTUxODA2MTguMTQ1MC0xLXNh
bXVlbC50aGliYXVsdEBlbnMtbHlvbi5vcmcKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQVUxMIDAv
MV0gc2xpcnAgZ2NjOSBidWlsZCBmaXgKVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVH
SU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0
IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhp
c3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVT
VCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRi
ZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQog
dCBbdGFnIHVwZGF0ZV0gICAgICAgICAgICBwYXRjaGV3LzIwMTkwNDExMTUyNTIwLjEwMDYxLTEt
YXJtYnJ1QHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDE5MDQxMTE1MjUyMC4xMDA2MS0xLWFybWJy
dUByZWRoYXQuY29tCiAqIFtuZXcgdGFnXSAgICAgICAgICAgICAgIHBhdGNoZXcvMjAxOTA0MTUx
ODA2MTguMTQ1MC0xLXNhbXVlbC50aGliYXVsdEBlbnMtbHlvbi5vcmcgLT4gcGF0Y2hldy8yMDE5
MDQxNTE4MDYxOC4xNDUwLTEtc2FtdWVsLnRoaWJhdWx0QGVucy1seW9uLm9yZwpTd2l0Y2hlZCB0
byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjdlNDVmZDBiZjYgc2xpcnA6IEdjYyA5IC1PMyBmaXgKCj09
PSBPVVRQVVQgQkVHSU4gPT09CkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRh
YnMKIzI0OiBGSUxFOiBzbGlycC9zcmMvc29ja2V0LmM6MTc0OgorXklzaXplX3QgYnVmX2xlbjsk
CgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiMzMzogRklMRTogc2xp
cnAvc3JjL3NvY2tldC5jOjE4NToKK15JYnVmX2xlbiA9IHNvcHJlcHJidWYoc28sIGlvdiwgJm4p
OyQKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzM0OiBGSUxFOiBz
bGlycC9zcmMvc29ja2V0LmM6MTg2OgorXklhc3NlcnQoYnVmX2xlbiAhPSAwKTskCgpFUlJPUjog
Y29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiM0MjogRklMRTogc2xpcnAvc3JjL3Nv
Y2tldC5jOjI2MjoKK15JYXNzZXJ0KHNpemUgPiAwKTskCgp0b3RhbDogNCBlcnJvcnMsIDAgd2Fy
bmluZ3MsIDIzIGxpbmVzIGNoZWNrZWQKCkNvbW1pdCA3ZTQ1ZmQwYmY2OTAgKHNsaXJwOiBHY2Mg
OSAtTzMgZml4KSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2Yg
dGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50
YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0K
ClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWls
YWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDQxNTE4MDYxOC4xNDUwLTEtc2Ft
dWVsLnRoaWJhdWx0QGVucy1seW9uLm9yZy90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2Fn
ZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8v
cGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVs
QHJlZGhhdC5jb20=
