Received: from eggs.gnu.org ([2001:4830:134:3::10]:54836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eOzRD-0008Pv-Jf
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 00:18:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eOzR9-0004R7-5X
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 00:18:35 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 02:17:33 -0300
Message-Id: <20171213051736.17755-2-f4bug@amsat.org>
In-Reply-To: <20171213051736.17755-1-f4bug@amsat.org>
References: <20171213051736.17755-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/4] MAINTAINERS: add "hw/registerfields.h" in
 Register API entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Orphan since afb3141c660

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0255113470..7edfa25542 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1538,6 +1538,7 @@ M: Alistair Francis <alistair.francis@xilinx.com>
 S: Maintained
 F: hw/core/register.c
 F: include/hw/register.h
+F: include/hw/registerfields.h
 
 SLIRP
 M: Samuel Thibault <samuel.thibault@ens-lyon.org>
-- 
2.15.1
