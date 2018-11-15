Received: from eggs.gnu.org ([2001:4830:134:3::10]:59761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gNK50-00038P-3E
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:01:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gNK4s-0000yF-TD
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:01:15 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:35879 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gNK4m-0000GQ-24
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:01:06 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 15 Nov 2018 16:59:43 +0100
Message-Id: <1542297583-6494-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Add Stefan Markovic as a MIPS
 reviewer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add Stefan Markovic as a MIPS reviewer. He had several key
contributions to QEMU for MIPS this year. He is a meticulous
person with the ability to think and act on many levels.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b8db61..f718264 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -190,6 +190,7 @@ F: disas/microblaze.c
 MIPS
 M: Aurelien Jarno <aurelien@aurel32.net>
 M: Aleksandar Markovic <amarkovic@wavecomp.com>
+R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Maintained
 F: target/mips/
 F: hw/mips/
@@ -336,6 +337,7 @@ F: target/arm/kvm.c
=20
 MIPS
 M: James Hogan <jhogan@kernel.org>
+R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Maintained
 F: target/mips/kvm.c
=20
@@ -741,27 +743,32 @@ MIPS Machines
 -------------
 Jazz
 M: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
+R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Maintained
 F: hw/mips/mips_jazz.c
=20
 Malta
 M: Aurelien Jarno <aurelien@aurel32.net>
+R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Maintained
 F: hw/mips/mips_malta.c
=20
 Mipssim
 M: Aleksandar Markovic <amarkovic@wavecomp.com>
+R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Odd Fixes
 F: hw/mips/mips_mipssim.c
 F: hw/net/mipsnet.c
=20
 R4000
 M: Aurelien Jarno <aurelien@aurel32.net>
+R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Maintained
 F: hw/mips/mips_r4k.c
=20
 Fulong 2E
 M: Aleksandar Markovic <amarkovic@wavecomp.com>
+R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Odd Fixes
 F: hw/mips/mips_fulong2e.c
 F: hw/isa/vt82c686.c
@@ -770,6 +777,7 @@ F: include/hw/isa/vt82c686.h
=20
 Boston
 M: Paul Burton <pburton@wavecomp.com>
+R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Maintained
 F: hw/core/loader-fit.c
 F: hw/mips/boston.c
@@ -1992,6 +2000,7 @@ F: disas/i386.c
=20
 MIPS target
 M: Aurelien Jarno <aurelien@aurel32.net>
+R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Maintained
 F: tcg/mips/
 F: disas/mips.c
--=20
2.7.4
