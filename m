Received: from eggs.gnu.org ([2001:4830:134:3::10]:55323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dSK2L-0000jQ-Jy
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:22:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dSK2H-0008PF-Sb
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:22:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dSK2H-0008P9-Ld
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:22:21 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue,  4 Jul 2017 11:22:15 +0200
Message-Id: <20170704092215.13742-2-cohuck@redhat.com>
In-Reply-To: <20170704092215.13742-1-cohuck@redhat.com>
References: <20170704092215.13742-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH 1/1] Update my email address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, Cornelia Huck <cohuck@redhat.com>

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7df088259b..afc2b8b328 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -299,7 +299,7 @@ F: target/ppc/kvm.c
 
 S390
 M: Christian Borntraeger <borntraeger@de.ibm.com>
-M: Cornelia Huck <cornelia.huck@de.ibm.com>
+M: Cornelia Huck <cohuck@redhat.com>
 M: Alexander Graf <agraf@suse.de>
 S: Maintained
 F: target/s390x/kvm.c
@@ -778,7 +778,7 @@ F: include/hw/sparc/grlib.h
 S390 Machines
 -------------
 S390 Virtio-ccw
-M: Cornelia Huck <cornelia.huck@de.ibm.com>
+M: Cornelia Huck <cohuck@redhat.com>
 M: Christian Borntraeger <borntraeger@de.ibm.com>
 M: Alexander Graf <agraf@suse.de>
 S: Supported
@@ -1006,7 +1006,7 @@ F: hw/vfio/*
 F: include/hw/vfio/
 
 vfio-ccw
-M: Cornelia Huck <cornelia.huck@de.ibm.com>
+M: Cornelia Huck <cohuck@redhat.com>
 S: Supported
 F: hw/vfio/ccw.c
 F: hw/s390x/s390-ccw.c
@@ -1048,7 +1048,7 @@ F: tests/virtio-blk-test.c
 T: git git://github.com/stefanha/qemu.git block
 
 virtio-ccw
-M: Cornelia Huck <cornelia.huck@de.ibm.com>
+M: Cornelia Huck <cohuck@redhat.com>
 M: Christian Borntraeger <borntraeger@de.ibm.com>
 S: Supported
 F: hw/s390x/virtio-ccw.[hc]
-- 
2.13.0
