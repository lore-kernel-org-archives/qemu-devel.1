Received: from eggs.gnu.org ([2001:4830:134:3::10]:39191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fz1tW-0000EW-Nm
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 11:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fz1hn-0003Oc-9n
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 11:32:58 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:51857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1fz1hn-0003OO-4G
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 11:32:55 -0400
Received: by mail-it0-x244.google.com with SMTP id e14-v6so26461730itf.1
	for <qemu-devel@nongnu.org>; Sun, 09 Sep 2018 08:32:54 -0700 (PDT)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Sun,  9 Sep 2018 11:32:38 -0400
Message-Id: <20180909153238.4046-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH] qemu-common.h: update copyright date to 2018
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: John Arbuckle <programmingkidx@gmail.com>

Currently the copyright date is set to 2017. Update the date to say
2018.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 include/qemu-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu-common.h b/include/qemu-common.h
index 85f4749aef..ed60ba251d 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -17,7 +17,7 @@
 #define TFR(expr) do { if ((expr) != -1) break; } while (errno == EINTR)
 
 /* Copyright string for -version arguments, About dialogs, etc */
-#define QEMU_COPYRIGHT "Copyright (c) 2003-2017 " \
+#define QEMU_COPYRIGHT "Copyright (c) 2003-2018 " \
     "Fabrice Bellard and the QEMU Project developers"
 
 /* Bug reporting information for --help arguments, About dialogs, etc */
-- 
2.14.3 (Apple Git-98)
