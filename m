Received: from eggs.gnu.org ([2001:4830:134:3::10]:39808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ehca5-0001Wc-Fq
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:44:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ehca1-00037U-NT
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:44:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57930
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1ehca1-000372-Fw
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:44:41 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w12EhRjR103758
	for <qemu-devel@nongnu.org>; Fri, 2 Feb 2018 09:44:39 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fvps50ewr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 09:44:38 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 2 Feb 2018 07:44:37 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri,  2 Feb 2018 09:44:27 -0500
In-Reply-To: <1517582668-10923-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1517582668-10923-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1517582668-10923-4-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 3/4] MAINTAINERS: add pointer to tpm-next
 repository
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f8deaf6..d352d16 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1593,6 +1593,7 @@ F: include/hw/acpi/tpm.h
 F: include/sysemu/tpm*
 F: qapi/tpm.json
 F: backends/tpm.c
+T: git git://github.com/stefanberger/qemu-tpm.git tpm-next
 
 Checkpatch
 S: Odd Fixes
-- 
2.5.5
