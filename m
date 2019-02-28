Received: from eggs.gnu.org ([209.51.188.92]:51369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzKnR-0001RK-Nz
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzKnR-0007WI-3j
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gzKnQ-0007Vn-Tt
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:17 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 28 Feb 2019 13:27:47 +0100
Message-Id: <1551356875-30676-6-git-send-email-thuth@redhat.com>
In-Reply-To: <1551356875-30676-1-git-send-email-thuth@redhat.com>
References: <1551356875-30676-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/13] MAINTAINERS: Add an entry for the Dino
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Richard Henderson <rth@twiddle.net>, Helge Deller <deller@gmx.de>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Add Richard as maintainer, and Helge as reviewer.

Cc: Richard Henderson <rth@twiddle.net>
Cc: Helge Deller <deller@gmx.de>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
[thuth: Add the machine entry alphabetically]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d81f9c4..892d2c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -851,6 +851,15 @@ S: Maintained
 F: hw/cris/axis_dev88.c
 F: hw/*/etraxfs_*.c
=20
+HP-PARISC Machines
+------------------
+Dino
+M: Richard Henderson <rth@twiddle.net>
+R: Helge Deller <deller@gmx.de>
+S: Odd Fixes
+F: hw/hppa/
+F: pc-bios/hppa-firmware.img
+
 LM32 Machines
 -------------
 EVR32 and uclinux BSP
--=20
1.8.3.1
