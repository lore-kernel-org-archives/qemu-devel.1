Received: from eggs.gnu.org ([2001:4830:134:3::10]:38828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cRZyu-0006yI-3p
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:39:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cRZyq-0002Tb-W7
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:39:32 -0500
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Date: Thu, 12 Jan 2017 15:44:55 +0800
Message-ID: <1484207095-16224-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] doc/usb2: fix typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, qemu-trivial@nongnu.org

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 docs/usb2.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/usb2.txt b/docs/usb2.txt
index c7a445afcd55..b9e75480737c 100644
--- a/docs/usb2.txt
+++ b/docs/usb2.txt
@@ -19,7 +19,7 @@ the controller so the USB 2.0 bus gets a individual name, for example
 '-device usb-ehci,id=ehci".  This will give you a USB 2.0 bus named
 "ehci.0".
 
-I strongly recomment to also use -device to attach usb devices because
+I strongly recommend to also use -device to attach usb devices because
 you can specify the bus they should be attached to this way.  Here is
 a complete example:
 
-- 
2.1.0
