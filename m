Received: from eggs.gnu.org ([2001:4830:134:3::10]:60593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edT14-00069Y-63
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:43:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edT13-0006yh-3C
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:43:26 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:39808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1edT12-0006yI-UH
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:43:25 -0500
Received: by mail-pf0-x243.google.com with SMTP id e11so6082832pff.6
	for <qemu-devel@nongnu.org>; Sun, 21 Jan 2018 19:43:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 21 Jan 2018 19:42:17 -0800
Message-Id: <20180122034217.19593-44-richard.henderson@linaro.org>
In-Reply-To: <20180122034217.19593-1-richard.henderson@linaro.org>
References: <20180122034217.19593-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 43/43] hw/hppa: Add MAINTAINERS entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 753e7996ce..bee6b2bec7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -133,6 +133,7 @@ HPPA (PA-RISC)
 M: Richard Henderson <rth@twiddle.net>
 S: Maintained
 F: target/hppa/
+F: hw/hppa/
 F: disas/hppa.c
 
 LM32
-- 
2.14.3
