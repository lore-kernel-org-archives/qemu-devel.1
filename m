Received: from eggs.gnu.org ([2001:4830:134:3::10]:39575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1Nk-0000TM-2b
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 15:51:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1Nj-0005tx-Gf
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 15:51:56 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sun, 25 Nov 2018 21:49:43 +0100
Message-Id: <20181125205000.10324-9-philmd@redhat.com>
In-Reply-To: <20181125205000.10324-1-philmd@redhat.com>
References: <20181125205000.10324-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.1 08/25] MAINTAINERS: Add a missing entry
 for the Old World machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-ppc@nongnu.org

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 81a22b2ccf..aa51ae813b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -936,6 +936,7 @@ F: hw/ppc/mac_oldworld.c
 F: hw/pci-host/grackle.c
 F: hw/misc/macio/
 F: hw/intc/heathrow_pic.c
+F: include/hw/intc/heathrow_pic.h
=20
 PReP
 M: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
--=20
2.17.2
