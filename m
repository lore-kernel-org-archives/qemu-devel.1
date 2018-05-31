Received: from eggs.gnu.org ([2001:4830:134:3::10]:58567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8X-0003dH-50
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8U-00008B-0s
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41016 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fOR8T-00007n-ST
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:13 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:12:20 +0200
Message-Id: <20180531171253.21012-21-pbonzini@redhat.com>
In-Reply-To: <20180531171253.21012-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/53] hw/hppa: Remove unused include
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
Message-Id: <20180528232719.4721-19-f4bug@amsat.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/hppa/hppa_sys.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/hppa/hppa_sys.h b/hw/hppa/hppa_sys.h
index a182d1f34e..3f6c145120 100644
--- a/hw/hppa/hppa_sys.h
+++ b/hw/hppa/hppa_sys.h
@@ -3,7 +3,6 @@
 #ifndef HW_HPPA_SYS_H
 #define HW_HPPA_SYS_H
=20
-#include "target/hppa/cpu-qom.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "hw/ide.h"
--=20
2.17.0
