Received: from eggs.gnu.org ([2001:4830:134:3::10]:39372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eqiTr-00024q-8H
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:51:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eqiTm-0001KL-Nd
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:51:55 -0500
Received: from mail-sn1nam01on0052.outbound.protection.outlook.com
	([104.47.32.52]:45346
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eqiTm-0001Iv-6i
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:51:50 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 27 Feb 2018 08:47:03 -0800
Message-ID: <7bb690382e3370aa1c1e047a84e36603c787ec0e.1519749987.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 1/1] MAINTAINERS: Update my email address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com

I am leaving Xilinx, so to avoid having an email address that bouunces
update my maintainer address to point to my personal email address.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Signed-off-by: Alistair Francis <alistair@alistair23.me>
---

 MAINTAINERS | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a334a25e5d..a76044bee2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -556,7 +556,7 @@ F: hw/misc/arm_sysctl.c
 
 Xilinx Zynq
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
-M: Alistair Francis <alistair.francis@xilinx.com>
+M: Alistair Francis <alistair@alistair23.me>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/*/xilinx_*
@@ -566,7 +566,7 @@ F: include/hw/misc/zynq*
 X: hw/ssi/xilinx_*
 
 Xilinx ZynqMP
-M: Alistair Francis <alistair.francis@xilinx.com>
+M: Alistair Francis <alistair@alistair23.me>
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 L: qemu-arm@nongnu.org
 S: Maintained
@@ -1075,7 +1075,7 @@ T: git git://github.com/bonzini/qemu.git scsi-next
 
 SSI
 M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
-M: Alistair Francis <alistair.francis@xilinx.com>
+M: Alistair Francis <alistair@alistair23.me>
 S: Maintained
 F: hw/ssi/*
 F: hw/block/m25p80.c
@@ -1084,7 +1084,7 @@ X: hw/ssi/xilinx_*
 F: tests/m25p80-test.c
 
 Xilinx SPI
-M: Alistair Francis <alistair.francis@xilinx.com>
+M: Alistair Francis <alistair@alistair23.me>
 M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
 S: Maintained
 F: hw/ssi/xilinx_*
@@ -1254,7 +1254,7 @@ S: Maintained
 F: hw/net/eepro100.c
 
 Generic Loader
-M: Alistair Francis <alistair.francis@xilinx.com>
+M: Alistair Francis <alistair@alistair23.me>
 S: Maintained
 F: hw/core/generic-loader.c
 F: include/hw/core/generic-loader.h
@@ -1600,7 +1600,7 @@ F: tests/qmp-test.c
 T: git git://repo.or.cz/qemu/armbru.git qapi-next
 
 Register API
-M: Alistair Francis <alistair.francis@xilinx.com>
+M: Alistair Francis <alistair@alistair23.me>
 S: Maintained
 F: hw/core/register.c
 F: include/hw/register.h
-- 
2.14.1
