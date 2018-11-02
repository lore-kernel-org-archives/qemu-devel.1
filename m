Received: from eggs.gnu.org ([2001:4830:134:3::10]:56808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gIN5e-00010e-GQ
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 20:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gIN5d-00057u-Or
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 20:13:30 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  2 Nov 2018 01:13:03 +0100
Message-Id: <20181102001303.32640-8-f4bug@amsat.org>
In-Reply-To: <20181102001303.32640-1-f4bug@amsat.org>
References: <20181102001303.32640-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 3.2 v2 7/7] MAINTAINERS: Volunteer to
 review Raspi patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Guenter Roeck <linux@roeck-us.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c41ea5ed3f..a76d047659 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -684,6 +684,7 @@ F: hw/arm/microbit.c
 F: include/hw/arm/nrf51_soc.h
 
 Raspberry Pi
+R: Philippe Mathieu-Daudé <f4bug@amsat.org>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/*/bcm283*
-- 
2.17.2
