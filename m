Received: from eggs.gnu.org ([2001:4830:134:3::10]:39821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gVIg4-0002I2-OB
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:08:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gVIfw-0001rD-Hv
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:08:32 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri,  7 Dec 2018 16:08:04 +0000
Message-Id: <20181207160806.13569-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20181207160806.13569-1-mark.cave-ayland@ilande.co.uk>
References: <20181207160806.13569-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 1/3] MAINTAINERS: add myself as maintainer for
 Mac Old World and New World machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

I've unofficially been doing most of the work on the Mac machines for a while
now, so update MAINTAINERS to reflect this. David is still happy to be listed
as a reviewer as per our discussion at KVM forum.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 MAINTAINERS | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 63effdc473..64bffaecca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -935,7 +935,8 @@ F: hw/ppc/mpc8544ds.c
 F: hw/ppc/mpc8544_guts.c
 
 New World
-M: David Gibson <david@gibson.dropbear.id.au>
+M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
+R: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: hw/ppc/mac_newworld.c
@@ -949,7 +950,8 @@ F: include/hw/misc/mos6522.h
 F: include/hw/ppc/mac_dbdma.h
 
 Old World
-M: David Gibson <david@gibson.dropbear.id.au>
+M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
+R: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: hw/ppc/mac_oldworld.c
-- 
2.11.0
