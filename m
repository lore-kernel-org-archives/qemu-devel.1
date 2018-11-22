Received: from eggs.gnu.org ([2001:4830:134:3::10]:49178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gPy5z-0002Vn-Gj
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 18:09:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gPy5y-00071X-QM
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 18:09:15 -0500
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:40559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gPy5y-00071I-JH
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 18:09:14 -0500
Received: by mail-lf1-x141.google.com with SMTP id v5so7473097lfe.7
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 15:09:14 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 22 Nov 2018 15:08:58 -0800
Message-Id: <20181122230858.23345-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] MAINTAINERS: add missing xtensa patterns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1032406c5607..f4a7e453c06f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -311,6 +311,8 @@ F: target/xtensa/
 F: hw/xtensa/
 F: tests/tcg/xtensa/
 F: disas/xtensa.c
+F: include/hw/xtensa/xtensa-isa.h
+F: default-configs/xtensa*.mak
 
 TriCore
 M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
-- 
2.11.0
