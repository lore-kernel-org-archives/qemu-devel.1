Received: from eggs.gnu.org ([2001:4830:134:3::10]:58565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8X-0003dG-4p
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8U-00009N-UT
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41474 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fOR8U-00008j-PA
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:14 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:12:21 +0200
Message-Id: <20180531171253.21012-22-pbonzini@redhat.com>
In-Reply-To: <20180531171253.21012-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/53] hw/i386/pc: Remove unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20180528232719.4721-20-f4bug@amsat.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d768930d02..8b0803cb83 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -64,7 +64,6 @@
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/cpu_hotplug.h"
 #include "hw/boards.h"
-#include "hw/pci/pci_host.h"
 #include "acpi-build.h"
 #include "hw/mem/pc-dimm.h"
 #include "qapi/error.h"
--=20
2.17.0
