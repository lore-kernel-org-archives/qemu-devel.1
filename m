Received: from eggs.gnu.org ([2001:4830:134:3::10]:39660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1Nr-0000a6-SH
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 15:52:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1Nm-0005vU-Ob
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 15:52:03 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sun, 25 Nov 2018 21:49:44 +0100
Message-Id: <20181125205000.10324-10-philmd@redhat.com>
In-Reply-To: <20181125205000.10324-1-philmd@redhat.com>
References: <20181125205000.10324-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.1 09/25] MAINTAINERS: Add a missing entry
 for the sun4m machines
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
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa51ae813b..ba9cd9ac2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1013,6 +1013,7 @@ F: hw/misc/eccmemctl.c
 F: hw/misc/slavio_misc.c
 F: include/hw/sparc/sparc32_dma.h
 F: pc-bios/openbios-sparc32
+F: include/hw/sparc/sun4m_iommu.h
=20
 Sun4u
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
--=20
2.17.2
