Received: from eggs.gnu.org ([2001:4830:134:3::10]:53326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCii4-0005vS-V4
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCihs-0001Tf-W8
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gCihi-00010f-4Q
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:28 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 17 Oct 2018 12:04:57 +0200
Message-Id: <1539770707-7289-6-git-send-email-thuth@redhat.com>
In-Reply-To: <1539770707-7289-1-git-send-email-thuth@redhat.com>
References: <1539770707-7289-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/15] gdbstub: Remove unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 gdbstub.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/gdbstub.c b/gdbstub.c
index c8478de..c4e4f9f 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -20,7 +20,6 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
-#include "cpu.h"
 #include "trace-root.h"
 #ifdef CONFIG_USER_ONLY
 #include "qemu.h"
--=20
1.8.3.1
