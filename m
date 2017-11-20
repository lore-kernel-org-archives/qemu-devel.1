Received: from eggs.gnu.org ([2001:4830:134:3::10]:39470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eGcoH-0007En-FE
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 22:31:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eGcoE-0000vl-2x
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 22:31:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eGcoD-0000vU-Sw
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 22:31:46 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Nov 2017 11:31:25 +0800
Message-Id: <1511148687-24909-5-git-send-email-jasowang@redhat.com>
In-Reply-To: <1511148687-24909-1-git-send-email-jasowang@redhat.com>
References: <1511148687-24909-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 4/6] MAINTAINERS: Add missing entry for eepro100
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowang@redhat.com>

From: Stefan Weil <sw@weilnetz.de>

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ffd77b4..83434e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1183,6 +1183,11 @@ M: Dmitry Fleytman <dmitry@daynix.com>
 S: Maintained
 F: hw/net/e1000e*
 
+eepro100
+M: Stefan Weil <sw@weilnetz.de>
+S: Maintained
+F: hw/net/eepro100.c
+
 Generic Loader
 M: Alistair Francis <alistair.francis@xilinx.com>
 S: Maintained
-- 
2.7.4
