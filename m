Received: from eggs.gnu.org ([2001:4830:134:3::10]:53111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dSOUs-00088d-Qr
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:08:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dSOUo-0003Wd-Ox
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:08:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38312
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dSOUo-0003W8-IZ
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:08:06 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v64E4UUw109315
	for <qemu-devel@nongnu.org>; Tue, 4 Jul 2017 10:08:05 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bg6gdjp8k-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 10:08:05 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 4 Jul 2017 15:08:04 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue,  4 Jul 2017 16:07:57 +0200
In-Reply-To: <1499177279-131407-1-git-send-email-borntraeger@de.ibm.com>
References: <1499177279-131407-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1499177279-131407-6-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 5/7] s390x/MAINTAINERS: Update my email address
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
