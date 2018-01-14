Received: from eggs.gnu.org ([2001:4830:134:3::10]:50200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eaeBU-00054A-0y
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 04:02:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eaeBS-000256-Fg
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 04:02:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eaeBS-00024q-AJ
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 04:02:30 -0500
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Sun, 14 Jan 2018 11:01:47 +0200
Message-Id: <20180114090147.39255-6-marcel@redhat.com>
In-Reply-To: <20180114090147.39255-1-marcel@redhat.com>
References: <20180114090147.39255-1-marcel@redhat.com>
Subject: [Qemu-devel]  [PATCH V7 5/5] MAINTAINERS: add entry for hw/rdma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, yuval.shaia@oracle.com, marcel@redhat.com, pbonzini@redhat.com, mst@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, f4bug@amsat.org

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4770f105d4..fc4f54eebb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1984,6 +1984,14 @@ F: block/replication.c
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
