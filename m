Received: from eggs.gnu.org ([209.51.188.92]:38392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8i-0000cQ-L4
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8g-0007jZ-Ot
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:04 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  4 Feb 2019 20:01:11 +1100
Message-Id: <20190204090124.26191-25-david@gibson.dropbear.id.au>
In-Reply-To: <20190204090124.26191-1-david@gibson.dropbear.id.au>
References: <20190204090124.26191-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 24/37] MAINTAINERS: add myself as maintainer for
 Mac Old World and New World machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

I've unofficially been doing most of the work on the Mac machines for a w=
hile
now, so update MAINTAINERS to reflect this. David is still happy to be li=
sted
as a reviewer as per our discussion at KVM forum.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 MAINTAINERS | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 646e289df4..9a76845581 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -976,7 +976,8 @@ F: hw/ppc/mpc8544ds.c
 F: hw/ppc/mpc8544_guts.c
=20
 New World (mac99)
-M: David Gibson <david@gibson.dropbear.id.au>
+M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
+R: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: hw/ppc/mac_newworld.c
@@ -994,7 +995,8 @@ F: include/hw/input/adb*
 F: pc-bios/qemu_vga.ndrv
=20
 Old World (g3beige)
-M: David Gibson <david@gibson.dropbear.id.au>
+M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
+R: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: hw/ppc/mac_oldworld.c
--=20
2.20.1
