Received: from eggs.gnu.org ([2001:4830:134:3::10]:40271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1Ou-0001XG-50
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 15:53:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1Ot-0006iZ-Ib
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 15:53:08 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sun, 25 Nov 2018 21:49:58 +0100
Message-Id: <20181125205000.10324-24-philmd@redhat.com>
In-Reply-To: <20181125205000.10324-1-philmd@redhat.com>
References: <20181125205000.10324-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.1 23/25] MAINTAINERS: Add an entry for
 the Dino machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Helge Deller <deller@gmx.de>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a248c8c564..ad82c0377c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -879,6 +879,15 @@ F: hw/core/loader-fit.c
 F: hw/mips/boston.c
 F: hw/pci-host/xilinx-pcie.c
=20
+HP-PARISC Machines
+------------------
+
+Dino
+M: Richard Henderson <rth@twiddle.net>
+S: Maintained
+F: hw/hppa/
+F: pc-bios/hppa-firmware.img
+
 OpenRISC Machines
 -----------------
 or1k-sim
--=20
2.17.2
