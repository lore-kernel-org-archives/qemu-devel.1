Received: from eggs.gnu.org ([209.51.188.92]:54836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLuG7-0007x7-T4
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLuG6-0003WD-NS
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:47:11 -0400
Resent-Message-Id: <E1hLuG6-0003WD-NS@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hLuG5-0003U8-JY
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:47:10 -0400
In-Reply-To: <20190501184306.15208-1-richard.henderson@linaro.org>
Message-ID: <155673641354.10667.5985564310999267637@c2072b67cc0c>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 1 May 2019 11:46:54 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] tests/tcg/alpha: add system boot.S
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: fam@euphon.net, qemu-devel@nongnu.org, alex.bennee@linaro.org

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDUwMTE4NDMwNi4xNTIw
OC0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5MDUwMTE4
NDMwNi4xNTIwOC0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSF0gdGVzdHMvdGNnL2FscGhhOiBhZGQgc3lzdGVtIGJvb3QuUwoKPT09IFRF
U1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2
L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBi
YXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4Nzgy
MTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1w
cm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0Y2hldy8yMDE5MDUwMTE4
NDMwNi4xNTIwOC0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcgLT4gcGF0Y2hldy8yMDE5
MDUwMTE4NDMwNi4xNTIwOC0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcKU3dpdGNoZWQg
dG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo5NjE4ZDgzYjc2IHRlc3RzL3RjZy9hbHBoYTogYWRkIHN5
c3RlbSBib290LlMKCj09PSBPVVRQVVQgQkVHSU4gPT09CldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBv
ciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzE1OiAK
bmV3IGZpbGUgbW9kZSAxMDA2NDQKCkVSUk9SOiB0cmFpbGluZyB3aGl0ZXNwYWNlCiMyMDg6IEZJ
TEU6IHRlc3RzL3RjZy9hbHBoYS9zeXN0ZW0vYm9vdC5TOjE1MToKK15JLyogJAoKRVJST1I6IHRy
YWlsaW5nIHdoaXRlc3BhY2UKIzIzMzogRklMRTogdGVzdHMvdGNnL2FscGhhL3N5c3RlbS9ib290
LlM6MTc2OgorXkkvKiAkCgp0b3RhbDogMiBlcnJvcnMsIDEgd2FybmluZ3MsIDU3MyBsaW5lcyBj
aGVja2VkCgpDb21taXQgOTYxOGQ4M2I3NjRmICh0ZXN0cy90Y2cvYWxwaGE6IGFkZCBzeXN0ZW0g
Ym9vdC5TKSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhl
c2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWlu
ZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRl
c3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJs
ZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDUwMTE4NDMwNi4xNTIwOC0xLXJpY2hh
cmQuaGVuZGVyc29uQGxpbmFyby5vcmcvdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2Uu
Ci0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3Bh
dGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBy
ZWRoYXQuY29t
