Received: from eggs.gnu.org ([2001:4830:134:3::10]:38531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dqND9-0006Lh-C5
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 13:37:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dqND8-0006rY-Mt
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 13:36:59 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  8 Sep 2017 14:36:19 -0300
Message-Id: <20170908173632.6711-1-f4bug@amsat.org>
In-Reply-To: <20170908173146.6446-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 02/15] MAINTAINERS: add missing STM32 entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alistair Francis <alistair@alistair23.me>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 35c8c9c752..fb93e4b554 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -552,6 +552,7 @@ F: hw/char/stm32f2xx_usart.c
 F: hw/timer/stm32f2xx_timer.c
 F: hw/adc/*
 F: hw/ssi/stm32f2xx_spi.c
+F: include/hw/*/stm32*.h
 
 Netduino 2
 M: Alistair Francis <alistair@alistair23.me>
-- 
2.14.1
