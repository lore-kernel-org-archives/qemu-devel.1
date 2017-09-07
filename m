Received: from eggs.gnu.org ([2001:4830:134:3::10]:50033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dq1kP-0003bl-Ro
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:41:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dq1kL-0004CA-C5
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:41:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34825
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1dq1kL-00049k-61
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:41:49 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v87IeNfa056764
	for <qemu-devel@nongnu.org>; Thu, 7 Sep 2017 14:41:45 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cub7t98pu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 14:41:45 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 7 Sep 2017 14:41:44 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu,  7 Sep 2017 14:41:38 -0400
Message-Id: <1504809698-30479-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] Add myself as maintainer for TPM code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index caf7e8a..1d5ea97 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1487,7 +1487,8 @@ F: docs/tracing.txt
 T: git git://github.com/stefanha/qemu.git tracing
 
 TPM
-S: Orphan
+M: Stefan Berger <stefanb@linux.vnet.ibm.com>
+S: Maintained
 F: tpm.c
 F: hw/tpm/*
 F: include/hw/acpi/tpm.h
-- 
2.5.5
