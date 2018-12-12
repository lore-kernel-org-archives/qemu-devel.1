Received: from eggs.gnu.org ([2001:4830:134:3::10]:43619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gX1Eu-0006An-L4
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:55:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gX1Er-0006ZE-B0
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:55:36 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 12 Dec 2018 10:55:16 +0100
Message-Id: <20181212095519.6390-4-cohuck@redhat.com>
In-Reply-To: <20181212095519.6390-1-cohuck@redhat.com>
References: <20181212095519.6390-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 3/6] s390/MAINTAINERS: Add Halil as kvm and
 machine maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Christian Borntraeger <borntraeger@de.ibm.com>

Halil does more work in this area than I do right now. Lets add Halil.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20181204133802.100998-1-borntraeger@de.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 63effdc473..76fbf1331a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -365,8 +365,9 @@ S: Maintained
 F: target/ppc/kvm.c
 
 S390
-M: Christian Borntraeger <borntraeger@de.ibm.com>
+M: Halil Pasic <pasic@linux.ibm.com>
 M: Cornelia Huck <cohuck@redhat.com>
+M: Christian Borntraeger <borntraeger@de.ibm.com>
 S: Maintained
 F: target/s390x/kvm.c
 F: target/s390x/kvm_s390x.h
@@ -1057,6 +1058,7 @@ S390 Machines
 -------------
 S390 Virtio-ccw
 M: Cornelia Huck <cohuck@redhat.com>
+M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@de.ibm.com>
 S: Supported
 F: hw/char/sclp*.[hc]
-- 
2.17.2
