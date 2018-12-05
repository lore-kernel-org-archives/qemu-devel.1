Received: from eggs.gnu.org ([2001:4830:134:3::10]:59862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gUWbR-0006PI-6N
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:48:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gUWbO-00020N-0D
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:48:33 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gUWbN-0001zC-PY
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:48:29 -0500
Received: by mail-wm1-x343.google.com with SMTP id s14so13162624wmh.1
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 04:48:28 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed,  5 Dec 2018 12:48:12 +0000
Message-Id: <20181205124812.10552-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] MAINTAINERS: update status of FPU emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, aurelien@aurel32.net, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Given I've spent a fair amount of time around this code now I'm
putting myself forward as a maintainer. Also given that the code has
been extensively re-written and has testing and new incoming features
it's probably more than just Odd Fixes.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 63effdc473..aeee83ba0e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -127,9 +127,11 @@ F: include/sysemu/cpus.h
 FPU emulation
 M: Aurelien Jarno <aurelien@aurel32.net>
 M: Peter Maydell <peter.maydell@linaro.org>
-S: Odd Fixes
+M: Alex Bennée <alex.bennee@linaro.org>
+S: Maintained
 F: fpu/
 F: include/fpu/
+F: tests/fp/
 
 Alpha
 M: Richard Henderson <rth@twiddle.net>
-- 
2.17.1
