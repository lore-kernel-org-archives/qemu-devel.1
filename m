Received: from eggs.gnu.org ([2001:4830:134:3::10]:51370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d45fb-00031J-AI
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 09:10:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d45fW-0005wr-SX
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 09:10:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1d45fW-0005wO-I4
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 09:10:42 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3SDA6jm072172
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 09:10:41 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a3j0mpfbk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 09:10:41 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Fri, 28 Apr 2017 07:10:40 -0600
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Fri, 28 Apr 2017 15:09:51 +0200
In-Reply-To: <20170428130951.44771-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170428130951.44771-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170428130951.44771-14-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v6 13/13] MAINTAINERS: Add vfio-ccw maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com

Add Cornelia Huck as the vfio-ccw maintainer.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cae3b09..c1f9917 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -999,6 +999,11 @@ S: Supported
 F: hw/vfio/*
 F: include/hw/vfio/
 
+vfio-ccw
+M: Cornelia Huck <cornelia.huck@de.ibm.com>
+S: Supported
+F: hw/vfio/ccw.c
+
 vhost
 M: Michael S. Tsirkin <mst@redhat.com>
 S: Supported
-- 
2.10.2
