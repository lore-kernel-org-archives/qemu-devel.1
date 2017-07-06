Received: from eggs.gnu.org ([2001:4830:134:3::10]:49493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dT194-0003Lf-KQ
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:24:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dT190-0005R7-5O
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:24:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41527
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dT18z-0005Qs-VI
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:24:10 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v667O6rD117538
	for <qemu-devel@nongnu.org>; Thu, 6 Jul 2017 03:24:09 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bgvqkr3g5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 03:24:08 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 6 Jul 2017 08:23:44 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu,  6 Jul 2017 09:23:34 +0200
In-Reply-To: <1499325817-9166-1-git-send-email-borntraeger@de.ibm.com>
References: <1499325817-9166-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1499325817-9166-6-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 5/8] s390x/MAINTAINERS: Update my email address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Cornelia Huck <cohuck@redhat.com>

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20170704092215.13742-2-cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 839f7ca..4e17216 100644
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
2.7.4
