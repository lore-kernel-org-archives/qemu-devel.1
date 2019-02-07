Received: from eggs.gnu.org ([209.51.188.92]:33882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1groBx-00072j-Ky
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:14:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1groBw-0004Nl-Gp
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:14:29 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1groBw-0004Le-0l
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:14:28 -0500
Received: by mail-wr1-x444.google.com with SMTP id q1so866746wrp.7
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 10:14:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  7 Feb 2019 18:14:22 +0000
Message-Id: <20190207181422.4907-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Remove Peter Crosthwaite from
 various entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>

Peter Crosthwaite hasn't had the bandwidth to do code review or
other QEMU work for some time now -- remove his email address
from MAINTAINERS file entries so we don't bombard him with
patch emails.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Peter C asked me to remove him from MAINTAINERS for now,
hence this patch.

Peter: Thanks for all your work in the past; if you ever
find yourself doing QEMU work again in the future we'll
be happy to welcome you back.
---
 MAINTAINERS | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a76845581b..7e3b69b528a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -110,7 +110,6 @@ Guest CPU cores (TCG):
 ----------------------
 Overall
 L: qemu-devel@nongnu.org
-M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
 M: Richard Henderson <rth@twiddle.net>
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
@@ -1346,7 +1345,6 @@ F: tests/virtio-scsi-test.c
 T: git https://github.com/bonzini/qemu.git scsi-next
 
 SSI
-M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
 M: Alistair Francis <alistair@alistair23.me>
 S: Maintained
 F: hw/ssi/*
@@ -1357,7 +1355,6 @@ F: tests/m25p80-test.c
 
 Xilinx SPI
 M: Alistair Francis <alistair@alistair23.me>
-M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
 S: Maintained
 F: hw/ssi/xilinx_*
 
@@ -1767,7 +1764,6 @@ F: qom/cpu.c
 F: include/qom/cpu.h
 
 Device Tree
-M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
 M: Alexander Graf <agraf@suse.de>
 S: Maintained
 F: device_tree.c
-- 
2.20.1
