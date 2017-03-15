Received: from eggs.gnu.org ([2001:4830:134:3::10]:35914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1co9n7-00062f-3M
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:20:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1co9n3-0008HO-VA
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:20:41 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:36818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1co9n3-0008G9-Qc
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:20:37 -0400
Received: by mail-pg0-x242.google.com with SMTP id m5so2448974pgk.3
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 07:20:37 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Wed, 15 Mar 2017 23:20:32 +0900
Message-Id: <20170315142032.6788-1-shorne@gmail.com>
Subject: [Qemu-devel] [PATCH v2] MAINTAINERS: Add myself as openrisc
 maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, peter.maydell@linaro.org, Stafford Horne <shorne@gmail.com>

Jia has claimed he is no longer able to maintain.  I have fixing bugs here
and there and getting familiar with the code base. Orignal thread from Jia:

 https://lists.librecores.org/pipermail/openrisc/2017-January/000321.html

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Changes in v2
 - fix typo Off/Odd

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4714df8..b359089 100644
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
