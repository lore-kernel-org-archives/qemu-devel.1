Received: from eggs.gnu.org ([2001:4830:134:3::10]:43734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dtvjg-0005Fy-0v
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:05:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dtvjY-0006Qu-Da
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:05:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dtvjY-0006Ps-44
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:05:08 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8ID4YkB062909
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 09:05:06 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d2afwfxdq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 09:05:05 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 18 Sep 2017 14:04:59 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 18 Sep 2017 15:04:55 +0200
Message-Id: <20170918130455.144262-1-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH] MAINTAINERS/s390x: add terminal3270.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4bd1797..3cdaa52 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -789,6 +789,7 @@ M: Christian Borntraeger <borntraeger@de.ibm.com>
 M: Alexander Graf <agraf@suse.de>
 S: Supported
 F: hw/char/sclp*.[hc]
+F: hw/char/terminal3270.c
 F: hw/s390x/
 F: include/hw/s390x/
 F: pc-bios/s390-ccw/
-- 
2.9.4
