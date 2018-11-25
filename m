Received: from eggs.gnu.org ([2001:4830:134:3::10]:39728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1Nz-0000fM-Qh
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 15:52:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1Nz-00062n-2a
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 15:52:11 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sun, 25 Nov 2018 21:49:46 +0100
Message-Id: <20181125205000.10324-12-philmd@redhat.com>
In-Reply-To: <20181125205000.10324-1-philmd@redhat.com>
References: <20181125205000.10324-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.1 11/25] MAINTAINERS: Add missing entries
 for the PC machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d9cddb0cc8..9f89e37a1e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1101,6 +1101,10 @@ F: hw/acpi/ich9.c
 F: include/hw/acpi/ich9.h
 F: include/hw/acpi/piix4.h
 F: hw/misc/sga.c
+F: hw/isa/apm.c
+F: include/hw/isa/apm.h
+F: tests/test-x86-cpuid.c
+F: tests/test-x86-cpuid-compat.c
=20
 PC Chipset
 M: Michael S. Tsirkin <mst@redhat.com>
--=20
2.17.2
