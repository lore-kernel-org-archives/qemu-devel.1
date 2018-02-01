Received: from eggs.gnu.org ([208.118.235.92]:48046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ehLxc-0001Nc-TU
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 16:01:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ehLta-0001ZA-RB
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 15:59:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ehLta-0001Y8-IR
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 15:55:46 -0500
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Thu,  1 Feb 2018 22:55:11 +0200
Message-Id: <20180201205511.19198-5-marcel@redhat.com>
In-Reply-To: <20180201205511.19198-1-marcel@redhat.com>
References: <20180201205511.19198-1-marcel@redhat.com>
Subject: [Qemu-devel]  [PATCH V9 4/4] MAINTAINERS: add entry for hw/rdma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, yuval.shaia@oracle.com, marcel@redhat.com, pbonzini@redhat.com, mst@redhat.com, cohuck@redhat.com, dotanb75@yahoo.com

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f8deaf638c..23a4fd0b3d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1986,6 +1986,14 @@ F: block/replication.c
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
