Received: from eggs.gnu.org ([2001:4830:134:3::10]:39040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gHcVK-0001ur-C1
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 18:28:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gHcVC-0000lH-4A
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 18:28:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34270
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1gHbsO-0006OT-St
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 17:48:41 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9ULj8aB139144
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 17:48:36 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2nevw7e8f7-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 17:48:36 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 30 Oct 2018 21:48:36 -0000
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 30 Oct 2018 17:47:39 -0400
In-Reply-To: <20181030214740.2294043-1-stefanb@linux.vnet.ibm.com>
References: <20181030214740.2294043-1-stefanb@linux.vnet.ibm.com>
Message-Id: <20181030214740.2294043-5-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL v2 4/5] MAINTAINERS: Change my email address to
 the new domain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.ibm.com>

From: Stefan Berger <stefanb@linux.ibm.com>

My old email address will soon not work anymore, so change it to the
new domain.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 40672c4eba..332353ce5c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1794,7 +1794,7 @@ F: docs/devel/tracing.txt
 T: git git://github.com/stefanha/qemu.git tracing
 
 TPM
-M: Stefan Berger <stefanb@linux.vnet.ibm.com>
+M: Stefan Berger <stefanb@linux.ibm.com>
 S: Maintained
 F: tpm.c
 F: stubs/tpm.c
-- 
2.17.1
