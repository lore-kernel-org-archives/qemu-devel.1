Received: from eggs.gnu.org ([2001:4830:134:3::10]:51585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cRb2v-0005Ml-OU
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 03:47:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cRb2q-0007Jr-3O
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 03:47:45 -0500
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Thu, 12 Jan 2017 09:47:29 +0100
Message-Id: <1484210849-27697-1-git-send-email-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] ppc/prep: update MAINTAINERS file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
---
 MAINTAINERS | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1444b26..f4b02ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -657,10 +657,13 @@ F: hw/misc/macio/
 F: hw/intc/heathrow_pic.c
=20
 PReP
+M: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
 L: qemu-devel@nongnu.org
 L: qemu-ppc@nongnu.org
-S: Odd Fixes
+S: Maintained
 F: hw/ppc/prep.c
+F: hw/ppc/prep_systemio.c
+F: hw/ppc/rs6000_mc.c
 F: hw/pci-host/prep.[hc]
 F: hw/isa/pc87312.[hc]
 F: pc-bios/ppc_rom.bin
--=20
2.1.4
