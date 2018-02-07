Received: from eggs.gnu.org ([2001:4830:134:3::10]:47600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ejS4Y-0004ND-Hs
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:55:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ejS4X-0007IU-MC
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:55:46 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed,  7 Feb 2018 16:55:31 +0100
Message-Id: <20180207155531.28446-4-cohuck@redhat.com>
In-Reply-To: <20180207155531.28446-1-cohuck@redhat.com>
References: <20180207155531.28446-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] MAINTAINERS: add David as additional
 tcg/s390 maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd2dc7ed7c..b30d2ca23a 100644
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
