Received: from eggs.gnu.org ([209.51.188.92]:56931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpckT-0007lq-PO
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:37:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpckP-0004wt-Ld
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:37:03 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpckN-0004v7-N4
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:37:01 -0500
Received: by mail-wr1-x443.google.com with SMTP id u4so7986801wrp.3
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 09:36:59 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 17:36:55 +0000
Message-Id: <20190201173655.4567-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] qemu-common.h: Update copyright string for 2019
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Update the copyright string we use in version/help output,
since we're well into the new year now.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Better than last year, where we didn't get round to doing
the year bump until September :-)
---
 include/qemu-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu-common.h b/include/qemu-common.h
index ed60ba251d8..a1022455199 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -17,7 +17,7 @@
 #define TFR(expr) do { if ((expr) != -1) break; } while (errno == EINTR)
 
 /* Copyright string for -version arguments, About dialogs, etc */
-#define QEMU_COPYRIGHT "Copyright (c) 2003-2018 " \
+#define QEMU_COPYRIGHT "Copyright (c) 2003-2019 " \
     "Fabrice Bellard and the QEMU Project developers"
 
 /* Bug reporting information for --help arguments, About dialogs, etc */
-- 
2.20.1
