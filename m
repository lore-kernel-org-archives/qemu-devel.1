Received: from eggs.gnu.org ([209.51.188.92]:53697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMtbB-00084t-F7
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:17:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMtbA-0001r5-FH
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:17:01 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sat,  4 May 2019 14:16:50 +0200
Message-Id: <20190504121650.12651-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] hw/display/cirrus_vga: Update the
 documentation URL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

The documentation URL is not working, but is backed up by the
Wayback Machine on the Internet Archive.
Replace the outdated link by a captured one.
Add another link to the VGADOC4b.ZIP archive content.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/display/cirrus_vga.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index a0e71469f4d..a04440b3748 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -23,8 +23,13 @@
  * THE SOFTWARE.
  */
 /*
- * Reference: Finn Thogersons' VGADOC4b
- *   available at http://home.worldonline.dk/~finth/
+ * Reference: Finn Thogersons' VGADOC4b:
+ *
+ *  http://web.archive.org/web/20021019054927/http://home.worldonline.dk=
/finth/
+ *
+ * VGADOC4b.ZIP content available at:
+ *
+ *  https://pdos.csail.mit.edu/6.828/2005/readings/hardware/vgadoc
  */
 #include "qemu/osdep.h"
 #include "qemu/units.h"
--=20
2.20.1
