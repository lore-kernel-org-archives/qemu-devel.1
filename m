Received: from eggs.gnu.org ([209.51.188.92]:53920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMLD-0007zC-9N
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guML4-0004mf-U9
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:28 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:37976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guMKz-0004jy-PZ
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:23 -0500
Received: by mail-wm1-x332.google.com with SMTP id v26so7193062wmh.3
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 11:06:21 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	n184sm7798471wmf.5.2019.02.14.11.06.18 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 14 Feb 2019 11:06:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 19:05:48 +0000
Message-Id: <20190214190603.25030-13-peter.maydell@linaro.org>
In-Reply-To: <20190214190603.25030-1-peter.maydell@linaro.org>
References: <20190214190603.25030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/27] MAINTAINERS: Remove Peter Crosthwaite
 from various entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Peter Crosthwaite hasn't had the bandwidth to do code review or
other QEMU work for some time now -- remove his email address
from MAINTAINERS file entries so we don't bombard him with
patch emails.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20190207181422.4907-1-peter.maydell@linaro.org
---
 MAINTAINERS | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e170a4c7337..ffb029f63ac 100644
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
@@ -1345,7 +1344,6 @@ F: tests/virtio-scsi-test.c
 T: git https://github.com/bonzini/qemu.git scsi-next
 
 SSI
-M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
 M: Alistair Francis <alistair@alistair23.me>
 S: Maintained
 F: hw/ssi/*
@@ -1356,7 +1354,6 @@ F: tests/m25p80-test.c
 
 Xilinx SPI
 M: Alistair Francis <alistair@alistair23.me>
-M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
 S: Maintained
 F: hw/ssi/xilinx_*
 
@@ -1766,7 +1763,6 @@ F: qom/cpu.c
 F: include/qom/cpu.h
 
 Device Tree
-M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
 M: Alexander Graf <agraf@suse.de>
 S: Maintained
 F: device_tree.c
-- 
2.20.1
