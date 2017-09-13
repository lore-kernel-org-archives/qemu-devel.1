Received: from eggs.gnu.org ([2001:4830:134:3::10]:49259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ds41v-00068H-7p
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ds41s-0004MO-TA
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:32:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ds41s-0004Kt-No
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:32:20 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 13 Sep 2017 11:32:13 +0200
Message-Id: <20170913093215.10043-3-kraxel@redhat.com>
In-Reply-To: <20170913093215.10043-1-kraxel@redhat.com>
References: <20170913093215.10043-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/4] MAINTAINERS: add missing USB entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Gerd Hoffmann <kraxel@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 36eeb42d19..2c333aba21 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -999,6 +999,7 @@ F: docs/usb2.txt
 F: docs/usb-storage.txt
 F: include/hw/usb.h
 F: include/hw/usb/
+F: default-configs/usb.mak
=20
 USB (serial adapter)
 M: Gerd Hoffmann <kraxel@redhat.com>
--=20
2.9.3
