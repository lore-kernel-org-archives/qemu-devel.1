Received: from eggs.gnu.org ([209.51.188.92]:59624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzEBg-0005g3-8R
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 00:24:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzEBe-0003mT-7K
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 00:24:52 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:37247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzEBc-0003he-7B
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 00:24:50 -0500
Received: by mail-pf1-x42f.google.com with SMTP id s22so9148952pfh.4
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 21:24:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 27 Feb 2019 21:24:25 -0800
Message-Id: <20190228052432.32571-2-richard.henderson@linaro.org>
In-Reply-To: <20190228052432.32571-1-richard.henderson@linaro.org>
References: <20190228052432.32571-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/8] MAINTAINERS: Add scripts/decodetree.py
 to the TCG section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de, f4bug@amsat.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20181110211313.6922-2-f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7be8c578ea..34364a77ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -117,6 +117,7 @@ F: cpus.c
 F: exec.c
 F: accel/tcg/
 F: accel/stubs/tcg-stub.c
+F: scripts/decodetree.py
 F: include/exec/cpu*.h
 F: include/exec/exec-all.h
 F: include/exec/helper*.h
-- 
2.17.2
