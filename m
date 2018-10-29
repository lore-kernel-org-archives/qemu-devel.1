Received: from eggs.gnu.org ([2001:4830:134:3::10]:34002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gH9Kv-0007ru-PI
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gH9Kq-00032u-Ku
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:20:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38736
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1gH9Kq-000323-Bj
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:20:08 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9TFJIiu037914
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 11:20:07 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ne37ew6kp-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 11:20:07 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Mon, 29 Oct 2018 11:20:06 -0400
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Mon, 29 Oct 2018 11:19:55 -0400
In-Reply-To: <20181029151956.2164336-1-stefanb@linux.ibm.com>
References: <20181029151956.2164336-1-stefanb@linux.ibm.com>
Message-Id: <20181029151956.2164336-5-stefanb@linux.ibm.com>
Subject: [Qemu-devel] [PULL v1 4/5] MAINTAINERS: Change my email address to
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
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>

From: Stefan Berger <stefanb@linux.vnet.ibm.com>

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
