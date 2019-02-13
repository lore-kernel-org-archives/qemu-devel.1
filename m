Received: from eggs.gnu.org ([209.51.188.92]:45544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gtruG-00011W-Q1
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 05:36:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gtrt8-0002JS-DJ
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 05:35:35 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 13 Feb 2019 11:35:19 +0100
Message-Id: <20190213103519.32585-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH] s390x: upgrade status of KVM cores to
 "supported"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

We are actually paid to look after this.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a76845581b1..73ff5915638e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -377,7 +377,7 @@ S390
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Cornelia Huck <cohuck@redhat.com>
 M: Christian Borntraeger <borntraeger@de.ibm.com>
-S: Maintained
+S: Supported
 F: target/s390x/kvm.c
 F: target/s390x/kvm_s390x.h
 F: target/s390x/kvm-stub.c
-- 
2.17.2
