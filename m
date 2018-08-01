Received: from eggs.gnu.org ([2001:4830:134:3::10]:34470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fktHP-0007lW-79
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 11:43:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fktHM-0007GL-1r
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 11:43:15 -0400
Resent-Message-Id: <E1fktHM-0007GL-1r@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1fktHL-0007EI-Ou
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 11:43:11 -0400
In-Reply-To: <20180801110952.5590-13-quintela@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <153313726008.9254.6953190167214654239@502c9da6d61e>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 1 Aug 2018 08:27:41 -0700 (PDT)
Subject: Re: [Qemu-devel] [[PATH for 3.1] v2 12/18] check: Only test sdhci
 when it is compiled in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

SGksCgpUaGlzIHNlcmllcyBmYWlsZWQgZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4g
UGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4g
SWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2Ug
aXQKbG9jYWxseS4KClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE4MDgwMTExMDk1Mi41NTkw
LTEzLXF1aW50ZWxhQHJlZGhhdC5jb20KU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtbUEFUSCBmb3Ig
My4xXSB2MiAxMi8xOF0gY2hlY2s6IE9ubHkgdGVzdCBzZGhjaSB3aGVuIGl0IGlzIGNvbXBpbGVk
IGluCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCnRpbWUgbWFrZSBkb2Nr
ZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj04Cj09PSBURVNUIFNDUklQVCBFTkQg
PT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CmVy
cm9yOiBSUEMgZmFpbGVkOyBjdXJsIDE4IHRyYW5zZmVyIGNsb3NlZCB3aXRoIG91dHN0YW5kaW5n
IHJlYWQgZGF0YSByZW1haW5pbmcKZmF0YWw6IFRoZSByZW1vdGUgZW5kIGh1bmcgdXAgdW5leHBl
Y3RlZGx5CmVycm9yOiBDb3VsZCBub3QgZmV0Y2ggM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdm
NDRiZDg4ODcxMzM4NApUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAi
cGF0Y2hldy10ZXN0ZXIvc3JjL3BhdGNoZXctY2xpIiwgbGluZSA1MTksIGluIHRlc3Rfb25lCiAg
ICBnaXRfY2xvbmVfcmVwbyhjbG9uZSwgclsicmVwbyJdLCByWyJoZWFkIl0sIGxvZ2YsIFRydWUp
CiAgRmlsZSAicGF0Y2hldy10ZXN0ZXIvc3JjL3BhdGNoZXctY2xpIiwgbGluZSA0OCwgaW4gZ2l0
X2Nsb25lX3JlcG8KICAgIHN0ZG91dD1sb2dmLCBzdGRlcnI9bG9nZikKICBGaWxlICIvdXNyL2xp
YjY0L3B5dGhvbjMuNi9zdWJwcm9jZXNzLnB5IiwgbGluZSAyOTEsIGluIGNoZWNrX2NhbGwKICAg
IHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVk
UHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ2dpdCcsICdyZW1vdGUnLCAnYWRkJywgJy1mJywgJy0t
bWlycm9yPWZldGNoJywgJzNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQn
LCAnaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11J10nIHJldHVybmVkIG5v
bi16ZXJvIGV4aXQgc3RhdHVzIDEuCgoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxs
eSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVk
YmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
