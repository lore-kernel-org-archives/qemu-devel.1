Received: from eggs.gnu.org ([2001:4830:134:3::10]:60333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d4y3L-0001od-84
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 19:14:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d4y3K-0006Rq-8x
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 19:14:55 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1d4y3K-0006RJ-31
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 19:14:54 -0400
Received: by mail-pg0-x241.google.com with SMTP id t7so13879547pgt.1
	for <qemu-devel@nongnu.org>; Sun, 30 Apr 2017 16:14:54 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Mon,  1 May 2017 08:14:15 +0900
Message-Id: <1d7cf18d79c85031998cc8e628414eac292ca694.1493593744.git.shorne@gmail.com>
In-Reply-To: <cover.1493593744.git.shorne@gmail.com>
References: <cover.1493593744.git.shorne@gmail.com>
In-Reply-To: <cover.1493593744.git.shorne@gmail.com>
References: <cover.1493593744.git.shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/11] MAINTAINERS: Add myself as openrisc
 maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: QEMU Development <qemu-devel@nongnu.org>, Stafford Horne <shorne@gmail.com>

Jia has claimed he is no longer able to maintain.  I have fixing bugs here
and there and getting familiar with the code base. Orignal thread from Jia:

 https://lists.librecores.org/pipermail/openrisc/2017-January/000321.html

Signed-off-by: Stafford Horne <shorne@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c60235e..21803ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -196,8 +196,8 @@ F: hw/nios2/
 F: disas/nios2.c
 
 OpenRISC
-M: Jia Liu <proljc@gmail.com>
-S: Maintained
+M: Stafford Horne <shorne@gmail.com>
+S: Odd Fixes
 F: target/openrisc/
 F: hw/openrisc/
 F: tests/tcg/openrisc/
-- 
2.9.3
