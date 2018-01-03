Received: from eggs.gnu.org ([2001:4830:134:3::10]:59493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eWgIw-0002cw-GZ
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:29:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eWgIs-0001TK-0O
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:29:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eWgIr-0001T0-RV
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:29:45 -0500
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Wed,  3 Jan 2018 12:29:11 +0200
Message-Id: <20180103102911.35562-6-marcel@redhat.com>
In-Reply-To: <20180103102911.35562-1-marcel@redhat.com>
References: <20180103102911.35562-1-marcel@redhat.com>
Subject: [Qemu-devel]  [PATCH V3 5/5] MAINTAINERS: add entry for hw/rdma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yuval.shaia@oracle.com, marcel@redhat.com, mst@redhat.com, ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, f4bug@amsat.org

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
