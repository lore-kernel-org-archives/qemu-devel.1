Received: from eggs.gnu.org ([2001:4830:134:3::10]:50095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cyAjF-0008TI-PS
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 01:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cyAjB-0000M2-Mu
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 01:22:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45869
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1cyAjB-0000Lo-Fq
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 01:22:01 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3C5Ig1x087651
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 01:22:00 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29ru2u1a0q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 01:22:00 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 11 Apr 2017 23:22:00 -0600
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Wed, 12 Apr 2017 07:21:15 +0200
In-Reply-To: <20170412052115.101657-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170412052115.101657-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170412052115.101657-14-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v5 13/13] MAINTAINERS: Add vfio-ccw maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com

Add Cornelia Huck as the vfio-ccw maintainer.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c60235e..5bac5f1 100644
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
