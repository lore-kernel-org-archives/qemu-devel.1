Received: from eggs.gnu.org ([2001:4830:134:3::10]:33373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNRZX-0007xr-1X
	for qemu-devel@nongnu.org; Mon, 28 May 2018 19:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNRZW-0001tJ-9A
	for qemu-devel@nongnu.org; Mon, 28 May 2018 19:29:03 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 28 May 2018 20:27:17 -0300
Message-Id: <20180528232719.4721-20-f4bug@amsat.org>
In-Reply-To: <20180528232719.4721-1-f4bug@amsat.org>
References: <20180528232719.4721-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 19/21] hw/i386/pc: Remove unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
-- 
2.17.0
