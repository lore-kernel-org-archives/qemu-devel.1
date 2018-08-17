Received: from eggs.gnu.org ([2001:4830:134:3::10]:52956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqfMh-0004qh-1l
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:04:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqfMZ-0007dI-Cp
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:04:33 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45534 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fqfMY-0007Zt-L5
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:04:27 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 17 Aug 2018 16:03:53 +0200
Message-Id: <1534514633-13725-66-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534514633-13725-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534514633-13725-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v10 65/65] qemu-doc: Add nanoMIPS-related items
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add nanoMIPS-related items in qemu-doc.texi

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 qemu-doc.texi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index f74542a..ddac713 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2711,6 +2711,8 @@ The binary format is detected automatically.
 
 @command{qemu-mipsn32el} executes 32-bit little endian MIPS binaries (MIPS N32 ABI).
 
+@command{qemu-nanomips} executes 32-bit little endian nanoMIPS binaries (MIPS P32 ABI).
+
 @cindex user mode (NiosII)
 @command{qemu-nios2} TODO.
 
-- 
2.7.4
