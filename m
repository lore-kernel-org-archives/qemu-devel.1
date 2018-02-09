Received: from eggs.gnu.org ([2001:4830:134:3::10]:43983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4wt-0002ZY-Fo
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:26:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4ws-0006aA-PQ
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:26:27 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  9 Feb 2018 10:25:24 +0100
Message-Id: <20180209092524.31348-30-cohuck@redhat.com>
In-Reply-To: <20180209092524.31348-1-cohuck@redhat.com>
References: <20180209092524.31348-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 29/29] MAINTAINERS: add David as additional
 tcg/s390 maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e3e0b1d2f4..54feb95646 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -236,6 +236,7 @@ F: disas/ppc.c
 S390
 M: Richard Henderson <rth@twiddle.net>
 M: Alexander Graf <agraf@suse.de>
+M: David Hildenbrand <david@redhat.com>
 S: Maintained
 F: target/s390x/
 F: hw/s390x/
-- 
2.13.6
