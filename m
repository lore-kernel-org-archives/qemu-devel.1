Received: from eggs.gnu.org ([2001:4830:134:3::10]:59401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5VuN-0003Ts-RO
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:56:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5VuK-0003si-4p
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:56:11 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 20 Oct 2017 13:54:05 +0200
Message-Id: <20171020115418.2050-34-cohuck@redhat.com>
In-Reply-To: <20171020115418.2050-1-cohuck@redhat.com>
References: <20171020115418.2050-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 33/46] s390x/MAINTAINERS: add mailing list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

There's a new qemu-s390x@nongnu.org mailing list: add it to the
s390 sections.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 757b02031d..12175425a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -216,6 +216,7 @@ S: Maintained
 F: target/s390x/
 F: hw/s390x/
 F: disas/s390.c
+L: qemu-s390x@nongnu.org
 
 SH4
 M: Aurelien Jarno <aurelien@aurel32.net>
@@ -310,6 +311,7 @@ F: include/hw/s390x/s390_flic.h
 F: gdb-xml/s390*.xml
 T: git git://github.com/cohuck/qemu.git s390-next
 T: git git://github.com/borntraeger/qemu.git s390-next
+L: qemu-s390x@nongnu.org
 
 X86
 M: Paolo Bonzini <pbonzini@redhat.com>
@@ -808,6 +810,7 @@ F: pc-bios/s390-ccw.img
 F: default-configs/s390x-softmmu.mak
 T: git git://github.com/cohuck/qemu.git s390-next
 T: git git://github.com/borntraeger/qemu.git s390-next
+L: qemu-s390x@nongnu.org
 
 UniCore32 Machines
 -------------
@@ -1032,6 +1035,7 @@ F: hw/vfio/ccw.c
 F: hw/s390x/s390-ccw.c
 F: include/hw/s390x/s390-ccw.h
 T: git git://github.com/cohuck/qemu.git s390-next
+L: qemu-s390x@nongnu.org
 
 vhost
 M: Michael S. Tsirkin <mst@redhat.com>
@@ -1075,6 +1079,7 @@ S: Supported
 F: hw/s390x/virtio-ccw.[hc]
 T: git git://github.com/cohuck/qemu.git s390-next
 T: git git://github.com/borntraeger/qemu.git s390-next
+L: qemu-s390x@nongnu.org
 
 virtio-input
 M: Gerd Hoffmann <kraxel@redhat.com>
@@ -1718,6 +1723,7 @@ M: Richard Henderson <rth@twiddle.net>
 S: Maintained
 F: tcg/s390/
 F: disas/s390.c
+L: qemu-s390x@nongnu.org
 
 SPARC target
 S: Odd Fixes
-- 
2.13.6
