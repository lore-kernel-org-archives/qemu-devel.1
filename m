Received: from eggs.gnu.org ([2001:4830:134:3::10]:54351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gVJLX-0001RM-6a
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:51:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gVJLV-00068E-JV
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:51:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gVJLV-00062p-83
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:51:21 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  7 Dec 2018 17:51:00 +0100
Message-Id: <20181207165103.3992-2-philmd@redhat.com>
In-Reply-To: <20181207165103.3992-1-philmd@redhat.com>
References: <20181207165103.3992-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/4] tests: Remove unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <minyard@acm.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Laszlo Ersek <lersek@redhat.com>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acpi-utils.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
index 41dc1ea9b4..297af55d39 100644
--- a/tests/acpi-utils.c
+++ b/tests/acpi-utils.c
@@ -15,7 +15,6 @@
 #include "qemu/osdep.h"
 #include <glib/gstdio.h>
 #include "qemu-common.h"
-#include "hw/smbios/smbios.h"
 #include "qemu/bitmap.h"
 #include "acpi-utils.h"
 #include "boot-sector.h"
--=20
2.17.2
