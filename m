Received: from eggs.gnu.org ([209.51.188.92]:57978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh08t-00060x-DZ
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:46:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh08r-0006jB-PL
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:46:39 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  9 Jan 2019 09:45:46 +1100
Message-Id: <20190108224600.23125-16-david@gibson.dropbear.id.au>
In-Reply-To: <20190108224600.23125-1-david@gibson.dropbear.id.au>
References: <20190108224600.23125-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/29] MAINTAINERS: add qemu_vga.ndrv file entry
 for Mac machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The VGA driver built from Ben's QemuMacDrivers repository is used exclusi=
vely
by the Mac machines.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 625e1c8c93..87f90721b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -990,6 +990,7 @@ F: include/hw/misc/mos6522.h
 F: include/hw/ppc/mac_dbdma.h
 F: include/hw/pci-host/uninorth.h
 F: include/hw/input/adb*
+F: pc-bios/qemu_vga.ndrv
=20
 Old World (g3beige)
 M: David Gibson <david@gibson.dropbear.id.au>
@@ -1002,6 +1003,7 @@ F: hw/intc/heathrow_pic.c
 F: hw/input/adb*
 F: include/hw/intc/heathrow_pic.h
 F: include/hw/input/adb*
+F: pc-bios/qemu_vga.ndrv
=20
 PReP
 M: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
--=20
2.20.1
