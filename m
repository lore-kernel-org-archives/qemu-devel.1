Received: from eggs.gnu.org ([2001:4830:134:3::10]:45684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwEVQ-0004sI-J1
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 17:32:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwEVN-0000IZ-DV
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 17:32:04 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 25 Sep 2017 00:22:28 +0300
Message-Id: <3ed1cb1f92636733ef69654729384fa669c82bf9.1506288070.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
References: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
References: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/31] MAINTAINERS: add missing SSI entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Alistair Francis volunteered :)

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dcd07505b0..041605ce13 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -990,10 +990,13 @@ F: hw/scsi/lsi53c895a.c
=20
 SSI
 M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
+M: Alistair Francis <alistair.francis@xilinx.com>
 S: Maintained
 F: hw/ssi/*
 F: hw/block/m25p80.c
+F: include/hw/ssi/ssi.h
 X: hw/ssi/xilinx_*
+F: tests/m25p80-test.c
=20
 Xilinx SPI
 M: Alistair Francis <alistair.francis@xilinx.com>
--=20
2.11.0
