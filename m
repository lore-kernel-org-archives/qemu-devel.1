Received: from eggs.gnu.org ([209.51.188.92]:51243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzKnI-0001KF-RG
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzKnH-0007Pj-MN
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gzKnH-0007OZ-Di
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:07 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 28 Feb 2019 13:27:44 +0100
Message-Id: <1551356875-30676-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1551356875-30676-1-git-send-email-thuth@redhat.com>
References: <1551356875-30676-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/13] MAINTAINERS: Add missing entries for the
 PC machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 22e0293..3a034f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1185,6 +1185,10 @@ F: hw/acpi/ich9.c
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
1.8.3.1
