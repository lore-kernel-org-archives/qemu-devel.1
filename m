Received: from eggs.gnu.org ([2001:4830:134:3::10]:42885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gH9gr-0004pv-KI
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:42:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gH9go-0008Ho-8R
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:42:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39554
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gH9gn-00089z-UE
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:42:50 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9TFdp16005311
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 11:42:40 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ne4w28ptt-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 11:42:40 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 29 Oct 2018 09:42:39 -0600
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 29 Oct 2018 16:42:22 +0100
In-Reply-To: <1540827745-20795-1-git-send-email-borntraeger@de.ibm.com>
References: <1540827745-20795-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1540827745-20795-2-git-send-email-borntraeger@de.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH 1/4] MAINTAINERS: s390: more maintainers for
 vfio-ccw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Eric and Farhan will help with maintaining vfio-ccw.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d794bd7..10045b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1204,6 +1204,8 @@ F: include/hw/vfio/
 
 vfio-ccw
 M: Cornelia Huck <cohuck@redhat.com>
+M: Eric Farman <farman@linux.ibm.com>
+M: Farhan Ali <alifm@linux.ibm.com>
 S: Supported
 F: hw/vfio/ccw.c
 F: hw/s390x/s390-ccw.c
-- 
1.8.3.1
