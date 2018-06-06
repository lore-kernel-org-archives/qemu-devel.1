Received: from eggs.gnu.org ([2001:4830:134:3::10]:47854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fQVk4-0003gU-Uj
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 06:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fQVk0-0008Kk-CD
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 06:32:36 -0400
Resent-Message-Id: <E1fQVk0-0008Kk-CD@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1fQVk0-0008Jw-5w
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 06:32:32 -0400
In-Reply-To: <1528233505-25842-1-git-send-email-thuth@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152828111997.435.2720941435101125836@d39dc562802a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 6 Jun 2018 03:32:00 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] hw/arm: Remove the deprecated xlnx-ep108
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: thuth@redhat.com
Cc: famz@redhat.com, alistair@alistair23.me, edgar.iglesias@gmail.com, qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org, alistair.francis@xilinx.com

SGksCgpUaGlzIHNlcmllcyBmYWlsZWQgZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQ
bGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJ
ZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBp
dApsb2NhbGx5LgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDE1MjgyMzM1MDUtMjU4NDItMS1n
aXQtc2VuZC1lbWFpbC10aHV0aEByZWRoYXQuY29tClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFU
Q0hdIGh3L2FybTogUmVtb3ZlIHRoZSBkZXByZWNhdGVkIHhsbngtZXAxMDggbWFjaGluZQoKPT09
IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApzZXQgLWUKZ2l0IHN1Ym1vZHVsZSB1
cGRhdGUgLS1pbml0IGR0YwojIExldCBkb2NrZXIgdGVzdHMgZHVtcCBlbnZpcm9ubWVudCBpbmZv
CmV4cG9ydCBTSE9XX0VOVj0xCmV4cG9ydCBKPTgKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3
QGZlZG9yYQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3
ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApmYXRhbDogdW5hYmxlIHRvIGFjY2VzcyAnaHR0cHM6
Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11Lyc6IEVuY291bnRlcmVkIGVuZCBvZiBm
aWxlCmVycm9yOiBDb3VsZCBub3QgZmV0Y2ggM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRi
ZDg4ODcxMzM4NApUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiL3Vz
ci9iaW4vcGF0Y2hldyIsIGxpbmUgNDQyLCBpbiB0ZXN0X29uZQogICAgZ2l0X2Nsb25lX3JlcG8o
Y2xvbmUsIHJbInJlcG8iXSwgclsiaGVhZCJdLCBsb2dmKQogIEZpbGUgIi91c3IvYmluL3BhdGNo
ZXciLCBsaW5lIDQ4LCBpbiBnaXRfY2xvbmVfcmVwbwogICAgc3Rkb3V0PWxvZ2YsIHN0ZGVycj1s
b2dmKQogIEZpbGUgIi91c3IvbGliNjQvcHl0aG9uMy42L3N1YnByb2Nlc3MucHkiLCBsaW5lIDI5
MSwgaW4gY2hlY2tfY2FsbAogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNt
ZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snZ2l0JywgJ3JlbW90
ZScsICdhZGQnLCAnLWYnLCAnLS1taXJyb3I9ZmV0Y2gnLCAnM2M4Y2Y1YTljMjFmZjg3ODIxNjRk
MWRlZjdmNDRiZDg4ODcxMzM4NCcsICdodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0
L3FlbXUnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMS4KCgoKLS0tCkVtYWlsIGdl
bmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQ
bGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==
