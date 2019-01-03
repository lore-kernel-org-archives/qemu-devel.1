Received: from eggs.gnu.org ([208.118.235.92]:38036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gf6Ty-0004Ob-OO
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:08:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gf6Tv-0007NK-Kk
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:08:34 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:46039 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gf6Tv-0007Fc-9j
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:08:31 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu,  3 Jan 2019 18:07:36 +0100
Message-Id: <1546535297-11040-4-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1546535297-11040-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1546535297-11040-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v3 03/44] MAINTAINERS: target/mips: Reorder
 items alphabetically
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

Reorder items alphabetically for better visibility.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 MAINTAINERS | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0543bbe..b3b60c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -209,18 +209,18 @@ R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Maintained
 F: target/mips/
 F: default-configs/*mips*
+F: disas/mips.c
+F: disas/nanomips.cpp
+F: disas/nanomips.h
+F: hw/intc/mips_gic.c
 F: hw/mips/
 F: hw/misc/mips_*
-F: hw/intc/mips_gic.c
 F: hw/timer/mips_gictimer.c
+F: include/hw/intc/mips_gic.h
 F: include/hw/mips/
 F: include/hw/misc/mips_*
-F: include/hw/intc/mips_gic.h
 F: include/hw/timer/mips_gictimer.h
 F: tests/tcg/mips/
-F: disas/mips.c
-F: disas/nanomips.h
-F: disas/nanomips.cpp
 K: ^Subject:.*(?i)mips
=20
 Moxie
--=20
2.7.4
