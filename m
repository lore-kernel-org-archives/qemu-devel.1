Received: from eggs.gnu.org ([2001:4830:134:3::10]:58132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLaZI-0005lC-NP
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 16:13:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLaZF-0002A2-Ca
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 16:13:24 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLaZF-00029E-6Z
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 16:13:21 -0500
Received: by mail-wr1-x442.google.com with SMTP id z16-v6so5395267wrv.2
	for <qemu-devel@nongnu.org>; Sat, 10 Nov 2018 13:13:21 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 10 Nov 2018 22:13:12 +0100
Message-Id: <20181110211313.6922-2-f4bug@amsat.org>
In-Reply-To: <20181110211313.6922-1-f4bug@amsat.org>
References: <20181110211313.6922-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/2] MAINTAINERS: Add scripts/decodetree.py to
 the TCG section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 126fe0be7e..45e4bfcd87 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -112,6 +112,7 @@ S: Maintained
 F: cpus.c
 F: exec.c
 F: accel/tcg/
+F: scripts/decodetree.py
 F: include/exec/cpu*.h
 F: include/exec/exec-all.h
 F: include/exec/helper*.h
-- 
2.19.1
