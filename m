Received: from eggs.gnu.org ([2001:4830:134:3::10]:52325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e07py-0005l0-GZ
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e07pu-000261-MR
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:13:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e07pu-00025e-FZ
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:13:18 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  5 Oct 2017 17:13:13 +0200
Message-Id: <20171005151313.32015-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH] s390x/MAINTAINERS: add mailing list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, thuth@redhat.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

There's a new qemu-s390x@nongnu.org mailing list: add it to the
s390 sections.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 772ac209e1..f1b096ca08 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -216,6 +216,7 @@ S: Maintained
 F: target/s390x/
 F: hw/s390x/
 F: disas/s390.c
+L: qemu-s390x@nongnu.org
 
 SH4
 M: Aurelien Jarno <aurelien@aurel32.net>
@@ -309,6 +310,7 @@ F: include/hw/s390x/s390_flic.h
 F: gdb-xml/s390*.xml
 T: git git://github.com/cohuck/qemu.git s390-next
 T: git git://github.com/borntraeger/qemu.git s390-next
+L: qemu-s390x@nongnu.org
 
 X86
 M: Paolo Bonzini <pbonzini@redhat.com>
@@ -807,6 +809,7 @@ F: pc-bios/s390-ccw.img
 F: default-configs/s390x-softmmu.mak
 T: git git://github.com/cohuck/qemu.git s390-next
 T: git git://github.com/borntraeger/qemu.git s390-next
+L: qemu-s390x@nongnu.org
 
 UniCore32 Machines
 -------------
@@ -1036,6 +1039,7 @@ F: hw/vfio/ccw.c
 F: hw/s390x/s390-ccw.c
 F: include/hw/s390x/s390-ccw.h
 T: git git://github.com/cohuck/qemu.git s390-next
+L: qemu-s390x@nongnu.org
 
 vhost
 M: Michael S. Tsirkin <mst@redhat.com>
@@ -1079,6 +1083,7 @@ S: Supported
 F: hw/s390x/virtio-ccw.[hc]
 T: git git://github.com/cohuck/qemu.git s390-next
 T: git git://github.com/borntraeger/qemu.git s390-next
+L: qemu-s390x@nongnu.org
 
 virtio-input
 M: Gerd Hoffmann <kraxel@redhat.com>
@@ -1709,6 +1714,7 @@ M: Richard Henderson <rth@twiddle.net>
 S: Maintained
 F: tcg/s390/
 F: disas/s390.c
+L: qemu-s390x@nongnu.org
 
 SPARC target
 S: Odd Fixes
-- 
2.13.6
