Received: from eggs.gnu.org ([209.51.188.92]:51104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gkAIw-0002SN-Sc
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:14:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gkAIw-0004w5-9z
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:14:06 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu, 17 Jan 2019 17:13:55 +0100
Message-Id: <20190117161355.18204-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Fix utf-8 mangling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Patch incorrectly applied as 15ffb43cbf4.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Paolo can this be a patchew bug?
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index af339b86db..fd3d4de3fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1639,7 +1639,7 @@ F: include/hw/display/edid.h
 F: qemu-edid.c
=20
 Firmware configuration (fw_cfg)
-M: Philippe Mathieu-Daud=C3=83=C2=A9 <philmd@redhat.com>
+M: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
 R: Laszlo Ersek <lersek@redhat.com>
 R: Gerd Hoffmann <kraxel@redhat.com>
 S: Supported
--=20
2.17.2
