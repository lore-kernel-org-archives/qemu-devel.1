Received: from eggs.gnu.org ([2001:4830:134:3::10]:51514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeUS6-0005FS-U5
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeUS6-0002Me-5y
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:34 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:34038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eeUS6-0002Ld-01
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:34 -0500
Received: by mail-pg0-x243.google.com with SMTP id r19so3822164pgn.1
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 15:27:33 -0800 (PST)
Received: from cloudburst.twiddle.net (174-21-6-47.tukw.qwest.net.
	[174.21.6.47]) by smtp.gmail.com with ESMTPSA id
	z19sm9760028pfh.185.2018.01.24.15.27.31 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Jan 2018 15:27:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 24 Jan 2018 15:26:23 -0800
Message-Id: <20180124232625.30105-44-richard.henderson@linaro.org>
In-Reply-To: <20180124232625.30105-1-richard.henderson@linaro.org>
References: <20180124232625.30105-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 43/45] hw/hppa: Add MAINTAINERS entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
