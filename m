Received: from eggs.gnu.org ([2001:4830:134:3::10]:47882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daxxK-0004J6-RR
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:37:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daxxK-0003SL-3G
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:36:58 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 28 Jul 2017 02:35:38 -0300
Message-Id: <20170728053610.15770-16-f4bug@amsat.org>
In-Reply-To: <20170728053610.15770-1-f4bug@amsat.org>
References: <20170728053610.15770-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 15/47] MAINTAINERS: add missing VMWare entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dmitry Fleytman <dmitry@daynix.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---

RFC because I'm not sure about tests/

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d8aef164ca..9670a3901a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1140,6 +1140,7 @@ M: Dmitry Fleytman <dmitry@daynix.com>
 S: Maintained
 F: hw/net/vmxnet*
 F: hw/scsi/vmw_pvscsi*
+F: tests/vmxnet3-test.c
 
 Rocker
 M: Jiri Pirko <jiri@resnulli.us>
-- 
2.13.3
