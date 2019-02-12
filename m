Received: from eggs.gnu.org ([209.51.188.92]:39321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gte8i-0006yS-Vy
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:54:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gte8g-00082f-VW
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:54:44 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:44858 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gte8f-0006gf-2X
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:54:41 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 12 Feb 2019 20:53:21 +0100
Message-Id: <1550001205-7883-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550001205-7883-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1550001205-7883-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 1/5] tests/tcg: target/mips: Remove an
 unnecessary file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com, alex.bennee@linaro.org

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Remove a file that was added long time ago by mistake.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/tcg/mips/mips64-dspr2/.directory | 2 --
 1 file changed, 2 deletions(-)
 delete mode 100644 tests/tcg/mips/mips64-dspr2/.directory

diff --git a/tests/tcg/mips/mips64-dspr2/.directory b/tests/tcg/mips/mips64-dspr2/.directory
deleted file mode 100644
index c75a914..0000000
--- a/tests/tcg/mips/mips64-dspr2/.directory
+++ /dev/null
@@ -1,2 +0,0 @@
-[Dolphin]
-Timestamp=2012,8,3,16,41,52
-- 
2.7.4
