Received: from eggs.gnu.org ([2001:4830:134:3::10]:56197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1er6tV-0007de-IU
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:56:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1er6tS-0002MT-Gd
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:56:01 -0500
Resent-Message-Id: <E1er6tS-0002MT-Gd@eggs.gnu.org>
In-Reply-To: <20180228180507.3964-1-mreitz@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151984413109.1257.6148072391316912931@bdbb90650ae5>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 28 Feb 2018 10:55:33 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v3 00/16] block/mirror: Add active-sync
 mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mreitz@redhat.com
Cc: famz@redhat.com, qemu-block@nongnu.org, kwolf@redhat.comfamz@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, jsnow@redhat.com

SGksCgpUaGlzIHNlcmllcyBmYWlsZWQgZG9ja2VyLWJ1aWxkQG1pbi1nbGliIGJ1aWxkIHRlc3Qu
IFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cu
IElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNl
IGl0CmxvY2FsbHkuCgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxODAyMjgxODA1MDcuMzk2
NC0xLW1yZWl0ekByZWRoYXQuY29tClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggdjMgMDAv
MTZdIGJsb2NrL21pcnJvcjogQWRkIGFjdGl2ZS1zeW5jIG1pcnJvcmluZwoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApzZXQgLWUKZ2l0IHN1Ym1vZHVsZSB1cGRhdGUgLS1p
bml0IGR0YwojIExldCBkb2NrZXIgdGVzdHMgZHVtcCBlbnZpcm9ubWVudCBpbmZvCmV4cG9ydCBT
SE9XX0VOVj0xCmV4cG9ydCBKPTgKdGltZSBtYWtlIGRvY2tlci10ZXN0LWJ1aWxkQG1pbi1nbGli
Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQx
ZGVmN2Y0NGJkODg4NzEzMzg0CmVycm9yOiBSUEMgZmFpbGVkOyBjdXJsIDE4IHRyYW5zZmVyIGNs
b3NlZCB3aXRoIG91dHN0YW5kaW5nIHJlYWQgZGF0YSByZW1haW5pbmcKZmF0YWw6IFRoZSByZW1v
dGUgZW5kIGh1bmcgdXAgdW5leHBlY3RlZGx5CmVycm9yOiBDb3VsZCBub3QgZmV0Y2ggM2M4Y2Y1
YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApUcmFjZWJhY2sgKG1vc3QgcmVjZW50
IGNhbGwgbGFzdCk6CiAgRmlsZSAiL3Vzci9iaW4vcGF0Y2hldyIsIGxpbmUgNDQyLCBpbiB0ZXN0
X29uZQogICAgZ2l0X2Nsb25lX3JlcG8oY2xvbmUsIHJbInJlcG8iXSwgclsiaGVhZCJdLCBsb2dm
KQogIEZpbGUgIi91c3IvYmluL3BhdGNoZXciLCBsaW5lIDQ4LCBpbiBnaXRfY2xvbmVfcmVwbwog
ICAgc3Rkb3V0PWxvZ2YsIHN0ZGVycj1sb2dmKQogIEZpbGUgIi91c3IvbGliNjQvcHl0aG9uMy42
L3N1YnByb2Nlc3MucHkiLCBsaW5lIDI5MSwgaW4gY2hlY2tfY2FsbAogICAgcmFpc2UgQ2FsbGVk
UHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6
IENvbW1hbmQgJ1snZ2l0JywgJ3JlbW90ZScsICdhZGQnLCAnLWYnLCAnLS1taXJyb3I9ZmV0Y2gn
LCAnM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NCcsICdodHRwczovL2dp
dGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBz
dGF0dXMgMS4KCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcg
W2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNo
ZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
