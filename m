Received: from eggs.gnu.org ([2001:4830:134:3::10]:54044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1gHQSz-0002nW-Nr
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 05:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1gHQSv-0006Ug-Mh
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 05:37:41 -0400
From: Alexander Graf <agraf@suse.de>
Date: Tue, 30 Oct 2018 10:37:15 +0100
Message-Id: <20181030093715.18793-1-agraf@suse.de>
Subject: [Qemu-devel] [PATCH] MAINTAINERS: s390: Remove myself
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>

I haven't realistically maintained s390 related parts for quite a while
now, so let's remove my name from the MATINAINERS file to reflect reality.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 MAINTAINERS | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d1a6d3c740..8bc9a594da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -250,7 +250,6 @@ F: disas/riscv.c
 
 S390
 M: Richard Henderson <rth@twiddle.net>
-M: Alexander Graf <agraf@suse.de>
 M: David Hildenbrand <david@redhat.com>
 S: Maintained
 F: target/s390x/
@@ -346,7 +345,6 @@ F: target/ppc/kvm.c
 S390
 M: Christian Borntraeger <borntraeger@de.ibm.com>
 M: Cornelia Huck <cohuck@redhat.com>
-M: Alexander Graf <agraf@suse.de>
 S: Maintained
 F: target/s390x/kvm.c
 F: target/s390x/kvm_s390x.h
@@ -931,7 +929,6 @@ S390 Machines
 S390 Virtio-ccw
 M: Cornelia Huck <cohuck@redhat.com>
 M: Christian Borntraeger <borntraeger@de.ibm.com>
-M: Alexander Graf <agraf@suse.de>
 S: Supported
 F: hw/char/sclp*.[hc]
 F: hw/char/terminal3270.c
@@ -1987,7 +1984,6 @@ F: tcg/ppc/
 F: disas/ppc.c
 
 S390 target
-M: Alexander Graf <agraf@suse.de>
 M: Richard Henderson <rth@twiddle.net>
 S: Maintained
 F: tcg/s390/
-- 
2.12.3
