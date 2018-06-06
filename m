Received: from eggs.gnu.org ([2001:4830:134:3::10]:60603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQZuQ-0006wk-FO
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:59:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQZuO-00079c-La
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:59:34 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  6 Jun 2018 11:59:19 -0300
Message-Id: <20180606145921.30606-2-f4bug@amsat.org>
In-Reply-To: <20180606145921.30606-1-f4bug@amsat.org>
References: <20180606145921.30606-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/3] MAINTAINERS: Add an entry for the MacIO
 device headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-ppc@nongnu.org

Missed while moved in 7092e84d42b.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 41cd3736a9..2423b248fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -766,8 +766,9 @@ F: hw/ppc/mac_newworld.c
 F: hw/pci-host/uninorth.c
 F: hw/pci-bridge/dec.[hc]
 F: hw/misc/macio/
-F: include/hw/ppc/mac_dbdma.h
 F: hw/nvram/mac_nvram.c
+F: include/hw/misc/macio/
+F: include/hw/ppc/mac_dbdma.h
 
 Old World
 M: Alexander Graf <agraf@suse.de>
-- 
2.17.1
