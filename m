Received: from eggs.gnu.org ([2001:4830:134:3::10]:48830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eg4d8-0002oS-UA
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 03:17:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eg4d4-0003pf-AD
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 03:17:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eg4d4-0003p5-48
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 03:17:26 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 29 Jan 2018 16:17:05 +0800
Message-Id: <1517213825-24085-7-git-send-email-jasowang@redhat.com>
In-Reply-To: <1517213825-24085-1-git-send-email-jasowang@redhat.com>
References: <1517213825-24085-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/6] MAINTAINERS: update Dmitry Fleytman email
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Jason Wang <jasowang@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

gently asked by his automatic reply :)

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 753e799..fe39b30 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1163,7 +1163,7 @@ F: hw/scsi/mfi.h
 F: tests/megasas-test.c
=20
 Network packet abstractions
-M: Dmitry Fleytman <dmitry@daynix.com>
+M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
 S: Maintained
 F: include/net/eth.h
 F: net/eth.c
@@ -1171,7 +1171,7 @@ F: hw/net/net_rx_pkt*
 F: hw/net/net_tx_pkt*
=20
 Vmware
-M: Dmitry Fleytman <dmitry@daynix.com>
+M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
 S: Maintained
 F: hw/net/vmxnet*
 F: hw/scsi/vmw_pvscsi*
@@ -1192,12 +1192,12 @@ F: hw/mem/nvdimm.c
 F: include/hw/mem/nvdimm.h
=20
 e1000x
-M: Dmitry Fleytman <dmitry@daynix.com>
+M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
 S: Maintained
 F: hw/net/e1000x*
=20
 e1000e
-M: Dmitry Fleytman <dmitry@daynix.com>
+M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
 S: Maintained
 F: hw/net/e1000e*
=20
--=20
2.7.4
