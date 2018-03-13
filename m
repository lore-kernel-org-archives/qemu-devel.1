Received: from eggs.gnu.org ([2001:4830:134:3::10]:58432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiU-00069R-Fo
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiT-0003yL-HW
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:22 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:38148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsiT-0003xq-BK
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:21 -0400
Received: by mail-wm0-x243.google.com with SMTP id z9so879810wmb.3
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:48:21 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:57 +0100
Message-Id: <20180313224719.4954-48-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 47/69] MAINTAINERS: Split the Alpha TCG/machine
 section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180308223946.26784-22-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 07684a1f2d..b17324107f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -127,7 +127,6 @@ Alpha
 M: Richard Henderson <rth@twiddle.net>
 S: Maintained
 F: target/alpha/
-F: hw/alpha/
 F: tests/tcg/alpha/
 F: disas/alpha.c
 
@@ -413,6 +412,11 @@ F: include/*/*win32*
 X: qga/*win32*
 F: qemu.nsi
 
+Alpha Machines
+M: Richard Henderson <rth@twiddle.net>
+S: Maintained
+F: hw/alpha/
+
 ARM Machines
 ------------
 Allwinner-a10
-- 
2.14.3
