Received: from eggs.gnu.org ([2001:4830:134:3::10]:52444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1efwBg-0003Es-QN
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 18:16:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1efwBf-0000hf-Qw
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 18:16:36 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:43763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1efwBf-0000gG-LE
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 18:16:35 -0500
Received: by mail-pf0-x244.google.com with SMTP id y26so3253447pfi.10
	for <qemu-devel@nongnu.org>; Sun, 28 Jan 2018 15:16:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 28 Jan 2018 15:15:26 -0800
Message-Id: <20180128231528.22719-42-richard.henderson@linaro.org>
In-Reply-To: <20180128231528.22719-1-richard.henderson@linaro.org>
References: <20180128231528.22719-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL v4 41/43] hw/hppa: Add MAINTAINERS entry
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
