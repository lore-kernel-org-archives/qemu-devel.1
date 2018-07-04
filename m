Received: from eggs.gnu.org ([2001:4830:134:3::10]:37525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1famD7-00072t-3n
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 14:09:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1famD3-0003c6-1W
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 14:09:01 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:54529 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1famD2-0003Nl-QN
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 14:08:56 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed,  4 Jul 2018 20:08:21 +0200
Message-Id: <1530727708-5416-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1530727708-5416-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1530727708-5416-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 1/8] target/mips: Update maintainer's email
 addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, aleksandar.markovic@wavecomp.com, petar.jovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Update email addresses of Aleksandar Markovic and Paul Burton in the
MAINTAINERS file. Also, add corresponding items in the .mailmap file.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 .mailmap    | 7 +++++--
 MAINTAINERS | 9 +++++----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/.mailmap b/.mailmap
index 778a4d4..2c2b9b1 100644
--- a/.mailmap
+++ b/.mailmap
@@ -12,8 +12,11 @@ Fabrice Bellard <fabrice@bellard.org> bellard <bellard@c046a42c-6fe2-441c-8c8c-7
 James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
 Jocelyn Mayer <l_indien@magic.fr> j_mayer <j_mayer@c046a42c-6fe2-441c-8c8c-71466251a162>
 Paul Brook <paul@codesourcery.com> pbrook <pbrook@c046a42c-6fe2-441c-8c8c-71466251a162>
-Paul Burton <paul.burton@mips.com> <paul.burton@imgtec.com>
-Paul Burton <paul.burton@mips.com> <paul@archlinuxmips.org>
+Aleksandar Markovic <amarkovic@wavecomp.com> <aleksandar.markovic@mips.com>
+Aleksandar Markovic <amarkovic@wavecomp.com> <aleksandar.markovic@imgtec.com>
+Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
+Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
+Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
 Thiemo Seufer <ths@networkno.de> ths <ths@c046a42c-6fe2-441c-8c8c-71466251a162>
 malc <av1474@comtv.ru> malc <malc@c046a42c-6fe2-441c-8c8c-71466251a162>
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 6630d69..f3863b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -187,7 +187,7 @@ F: disas/microblaze.c
 
 MIPS
 M: Aurelien Jarno <aurelien@aurel32.net>
-M: Aleksandar Markovic <aleksandar.markovic@mips.com>
+M: Aleksandar Markovic <amarkovic@wavecomp.com>
 S: Maintained
 F: target/mips/
 F: hw/mips/
@@ -718,7 +718,7 @@ S: Maintained
 F: hw/mips/mips_malta.c
 
 Mipssim
-M: Aleksandar Markovic <aleksandar.markovic@mips.com>
+M: Aleksandar Markovic <amarkovic@wavecomp.com>
 S: Odd Fixes
 F: hw/mips/mips_mipssim.c
 F: hw/net/mipsnet.c
@@ -729,14 +729,15 @@ S: Maintained
 F: hw/mips/mips_r4k.c
 
 Fulong 2E
-M: Aleksandar Markovic <aleksandar.markovic@mips.com>
+M: Aleksandar Markovic <amarkovic@wavecomp.com>
 S: Odd Fixes
 F: hw/mips/mips_fulong2e.c
 F: hw/isa/vt82c686.c
+
 F: include/hw/isa/vt82c686.h
 
 Boston
-M: Paul Burton <paul.burton@mips.com>
+M: Paul Burton <pburton@wavecomp.com>
 S: Maintained
 F: hw/core/loader-fit.c
 F: hw/mips/boston.c
-- 
2.7.4
