Received: from eggs.gnu.org ([2001:4830:134:3::10]:45282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVxoU-0001g9-Gh
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVxoR-0005jU-6V
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:54:54 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 24 Jan 2017 12:39:20 +0300
Message-Id: <6e3a7db24261589741fe7e447025d945bebf6503.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 16/31] doc/usb2: fix typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cao jin <caoj.fnst@cn.fujitsu.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Cao jin <caoj.fnst@cn.fujitsu.com>

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/usb2.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/usb2.txt b/docs/usb2.txt
index c7a445a..b9e7548 100644
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
2.1.4
