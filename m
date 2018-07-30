Received: from eggs.gnu.org ([2001:4830:134:3::10]:34261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fkAnp-00008V-Go
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:13:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fkAnm-00043A-Lv
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:13:45 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:48317 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fkAnm-0003xH-EM
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:13:42 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 30 Jul 2018 18:11:34 +0200
Message-Id: <1532967169-22265-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 01/76] target/mips: Update maintainer's
 email addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Update email addresses of Aleksandar Markovic and Paul Burton in the
MAINTAINERS file. Also, add corresponding items in the .mailmap file.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 .mailmap    | 7 +++++--
 MAINTAINERS | 9 +++++----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/.mailmap b/.mailmap
index 778a4d4..2c2b9b1 100644
--- a/.mailmap
+++ b/.mailmap
@@ -12,8 +12,11 @@ Fabrice Bellard <fabrice@bellard.org> bellard <bellard=
@c046a42c-6fe2-441c-8c8c-7
 James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
 Jocelyn Mayer <l_indien@magic.fr> j_mayer <j_mayer@c046a42c-6fe2-441c-8c=
8c-71466251a162>
 Paul Brook <paul@codesourcery.com> pbrook <pbrook@c046a42c-6fe2-441c-8c8=
c-71466251a162>
-Paul Burton <paul.burton@mips.com> <paul.burton@imgtec.com>
-Paul Burton <paul.burton@mips.com> <paul@archlinuxmips.org>
+Aleksandar Markovic <amarkovic@wavecomp.com> <aleksandar.markovic@mips.c=
om>
+Aleksandar Markovic <amarkovic@wavecomp.com> <aleksandar.markovic@imgtec=
.com>
+Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
+Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
+Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
 Thiemo Seufer <ths@networkno.de> ths <ths@c046a42c-6fe2-441c-8c8c-714662=
51a162>
 malc <av1474@comtv.ru> malc <malc@c046a42c-6fe2-441c-8c8c-71466251a162>
=20
diff --git a/MAINTAINERS b/MAINTAINERS
index 666e936..7130807 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -187,7 +187,7 @@ F: disas/microblaze.c
=20
 MIPS
 M: Aurelien Jarno <aurelien@aurel32.net>
-M: Aleksandar Markovic <aleksandar.markovic@mips.com>
+M: Aleksandar Markovic <amarkovic@wavecomp.com>
 S: Maintained
 F: target/mips/
 F: hw/mips/
@@ -718,7 +718,7 @@ S: Maintained
 F: hw/mips/mips_malta.c
=20
 Mipssim
-M: Aleksandar Markovic <aleksandar.markovic@mips.com>
+M: Aleksandar Markovic <amarkovic@wavecomp.com>
 S: Odd Fixes
 F: hw/mips/mips_mipssim.c
 F: hw/net/mipsnet.c
@@ -729,14 +729,15 @@ S: Maintained
 F: hw/mips/mips_r4k.c
=20
 Fulong 2E
-M: Aleksandar Markovic <aleksandar.markovic@mips.com>
+M: Aleksandar Markovic <amarkovic@wavecomp.com>
 S: Odd Fixes
 F: hw/mips/mips_fulong2e.c
 F: hw/isa/vt82c686.c
+
 F: include/hw/isa/vt82c686.h
=20
 Boston
-M: Paul Burton <paul.burton@mips.com>
+M: Paul Burton <pburton@wavecomp.com>
 S: Maintained
 F: hw/core/loader-fit.c
 F: hw/mips/boston.c
--=20
2.7.4
