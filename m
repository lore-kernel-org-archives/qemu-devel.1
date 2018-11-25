Received: from eggs.gnu.org ([2001:4830:134:3::10]:39687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1Nw-0000bo-NY
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 15:52:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1Ns-0005yN-Hg
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 15:52:08 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sun, 25 Nov 2018 21:49:45 +0100
Message-Id: <20181125205000.10324-11-philmd@redhat.com>
In-Reply-To: <20181125205000.10324-1-philmd@redhat.com>
References: <20181125205000.10324-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.1 10/25] MAINTAINERS: Add missing entries
 for the sun4u machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ba9cd9ac2b..d9cddb0cc8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1019,6 +1019,10 @@ Sun4u
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
 S: Maintained
 F: hw/sparc64/sun4u.c
+F: hw/sparc64/sun4u_iommu.c
+F: include/hw/sparc/sun4u_iommu.h
+F: hw/pci-host/sabre.c
+F: include/hw/pci-host/sabre.h
 F: pc-bios/openbios-sparc64
=20
 Sun4v
--=20
2.17.2
