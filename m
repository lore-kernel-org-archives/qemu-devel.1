Received: from eggs.gnu.org ([208.118.235.92]:38072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gf6Tz-0004Oe-8e
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:08:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gf6Tv-0007O4-VS
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:08:35 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:46044 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gf6Tv-0007Fm-MV
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:08:31 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu,  3 Jan 2019 18:07:37 +0100
Message-Id: <1546535297-11040-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1546535297-11040-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1546535297-11040-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v3 04/44] MAINTAINERS: Add Aleksandar Rikalo as
 a reviewer for MIPS content
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add Aleksandar Rikalo as a reviewer for MIPS content. Aleksandar
brings to us more than six years of experience in working on a variety
of development tools for MIPS architectures, and will greatly help
QEMU community understand and support intricacies of MIPS better.

Acked-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b3b60c3..f6f0505 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -205,6 +205,7 @@ F: disas/microblaze.c
 MIPS
 M: Aurelien Jarno <aurelien@aurel32.net>
 M: Aleksandar Markovic <amarkovic@wavecomp.com>
+R: Aleksandar Rikalo <arikalo@wavecomp.com>
 R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Maintained
 F: target/mips/
@@ -363,6 +364,7 @@ F: target/arm/kvm.c
=20
 MIPS
 M: James Hogan <jhogan@kernel.org>
+R: Aleksandar Rikalo <arikalo@wavecomp.com>
 R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Maintained
 F: target/mips/kvm.c
@@ -872,6 +874,7 @@ MIPS Machines
 -------------
 Jazz
 M: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
+R: Aleksandar Rikalo <arikalo@wavecomp.com>
 R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Maintained
 F: hw/mips/mips_jazz.c
@@ -880,12 +883,14 @@ F: hw/dma/rc4030.c
=20
 Malta
 M: Aurelien Jarno <aurelien@aurel32.net>
+R: Aleksandar Rikalo <arikalo@wavecomp.com>
 R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Maintained
 F: hw/mips/mips_malta.c
=20
 Mipssim
 M: Aleksandar Markovic <amarkovic@wavecomp.com>
+R: Aleksandar Rikalo <arikalo@wavecomp.com>
 R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Odd Fixes
 F: hw/mips/mips_mipssim.c
@@ -893,12 +898,14 @@ F: hw/net/mipsnet.c
=20
 R4000
 M: Aurelien Jarno <aurelien@aurel32.net>
+R: Aleksandar Rikalo <arikalo@wavecomp.com>
 R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Maintained
 F: hw/mips/mips_r4k.c
=20
 Fulong 2E
 M: Aleksandar Markovic <amarkovic@wavecomp.com>
+R: Aleksandar Rikalo <arikalo@wavecomp.com>
 R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Odd Fixes
 F: hw/mips/mips_fulong2e.c
@@ -908,6 +915,7 @@ F: include/hw/isa/vt82c686.h
=20
 Boston
 M: Paul Burton <pburton@wavecomp.com>
+R: Aleksandar Rikalo <arikalo@wavecomp.com>
 R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Maintained
 F: hw/core/loader-fit.c
@@ -2164,6 +2172,7 @@ F: disas/i386.c
=20
 MIPS target
 M: Aurelien Jarno <aurelien@aurel32.net>
+R: Aleksandar Rikalo <arikalo@wavecomp.com>
 R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Maintained
 F: tcg/mips/
--=20
2.7.4
