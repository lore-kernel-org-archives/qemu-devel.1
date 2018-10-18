Received: from eggs.gnu.org ([2001:4830:134:3::10]:35077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gDCvZ-0006ga-Gs
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gDCvW-00061j-7W
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:21:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39022
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1gDCvW-0005zB-1M
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:21:42 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9IIFGKA086427
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 14:21:41 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2n6wrjcjjv-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 14:21:41 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 18 Oct 2018 12:21:40 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 18 Oct 2018 14:21:30 -0400
In-Reply-To: <20181018182130.799406-1-stefanb@linux.vnet.ibm.com>
References: <20181018182130.799406-1-stefanb@linux.vnet.ibm.com>
Message-Id: <20181018182130.799406-2-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 2/2] MAINTAINERS: Change my email address to
 the new domain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, marcandre.lureau@gmail.com
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>

My old email address will soon not work anymore, so change it to the
new domain.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3275cc6bbe..b7b0be640c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1778,7 +1778,7 @@ F: docs/devel/tracing.txt
 T: git git://github.com/stefanha/qemu.git tracing
 
 TPM
-M: Stefan Berger <stefanb@linux.vnet.ibm.com>
+M: Stefan Berger <stefanb@linux.ibm.com>
 S: Maintained
 F: tpm.c
 F: stubs/tpm.c
-- 
2.17.1
