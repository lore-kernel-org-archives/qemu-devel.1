Received: from eggs.gnu.org ([2001:4830:134:3::10]:58759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3k-0002gK-41
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3j-0001po-Cz
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:40 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 12 Jun 2018 16:44:43 +1000
Message-Id: <20180612064503.14282-14-david@gibson.dropbear.id.au>
In-Reply-To: <20180612064503.14282-1-david@gibson.dropbear.id.au>
References: <20180612064503.14282-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/33] MAINTAINERS: Add entries for the MOS6522
 VIA device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, clg@kaod.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, David Gibson <david@gibson.dropbear.id.au>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Introduced in 51f233ec92c.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5286a1519c..8a94517e9e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -766,8 +766,10 @@ F: hw/ppc/mac_newworld.c
 F: hw/pci-host/uninorth.c
 F: hw/pci-bridge/dec.[hc]
 F: hw/misc/macio/
+F: hw/misc/mos6522.c
 F: hw/nvram/mac_nvram.c
 F: include/hw/misc/macio/
+F: include/hw/misc/mos6522.h
 F: include/hw/ppc/mac_dbdma.h
=20
 Old World
--=20
2.17.1
