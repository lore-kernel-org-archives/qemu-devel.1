Received: from eggs.gnu.org ([2001:4830:134:3::10]:35535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dau2b-0002Zk-SJ
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 21:26:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dau2b-00028U-0W
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 21:26:09 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 27 Jul 2017 22:25:40 -0300
Message-Id: <20170728012542.29975-7-f4bug@amsat.org>
In-Reply-To: <20170728012542.29975-1-f4bug@amsat.org>
References: <20170728012542.29975-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 6/8] docs: fix broken paths to
 docs/config/ich9-ehci-uhci.cfg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 docs/usb2.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/usb2.txt b/docs/usb2.txt
index b9e7548073..09df45b5b1 100644
--- a/docs/usb2.txt
+++ b/docs/usb2.txt
@@ -50,7 +50,7 @@ companion controllers with two ports each.
 There is a config file in docs which will do all this for you, just
 try ...
 
-    qemu -readconfig docs/ich9-ehci-uhci.cfg
+    qemu -readconfig docs/config/ich9-ehci-uhci.cfg
 
 ... then use "bus=ehci.0" to assign your usb devices to that bus.
 
-- 
2.13.3
