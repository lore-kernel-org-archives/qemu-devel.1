Received: from eggs.gnu.org ([2001:4830:134:3::10]:46150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eYA8H-0007MY-1j
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 07:32:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eYA8D-0003d8-U7
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 07:32:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eYA8D-0003cg-OR
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 07:32:53 -0500
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Sun,  7 Jan 2018 14:32:24 +0200
Message-Id: <20180107123224.100877-6-marcel@redhat.com>
In-Reply-To: <20180107123224.100877-1-marcel@redhat.com>
References: <20180107123224.100877-1-marcel@redhat.com>
Subject: [Qemu-devel]  [PATCH V6 5/5] MAINTAINERS: add entry for hw/rdma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, yuval.shaia@oracle.com, marcel@redhat.com, pbonzini@redhat.com, mst@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 73a5555735..256a284753 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1979,6 +1979,14 @@ F: block/replication.c
 F: tests/test-replication.c
 F: docs/block-replication.txt
 
+PVRDMA
+M: Yuval Shaia <yuval.shaia@oracle.com>
+M: Marcel Apfelbaum <marcel@redhat.com>
+S: Maintained
+F: hw/rdma/*
+F: hw/rdma/vmw/*
+F: docs/pvrdma.txt
+
 Build and test automation
 -------------------------
 Build and test automation
-- 
2.13.5
