Received: from eggs.gnu.org ([2001:4830:134:3::10]:59446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1elIXA-0008RY-OJ
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 13:09:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1elIX9-0002pM-FO
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 13:08:56 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58204 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1elIX9-0002ol-A8
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 13:08:55 -0500
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Mon, 12 Feb 2018 20:08:19 +0200
Message-Id: <20180212180819.82556-10-marcel@redhat.com>
In-Reply-To: <20180212180819.82556-1-marcel@redhat.com>
References: <20180212180819.82556-1-marcel@redhat.com>
Subject: [Qemu-devel]  [PATCH V10 9/9] MAINTAINERS: add entry for hw/rdma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, yuval.shaia@oracle.com, marcel@redhat.com, mst@redhat.com, dotanb@mellanox.com, yanjun.zhu@oracle.com

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 54feb95646..4e1501c28a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2033,6 +2033,14 @@ F: block/replication.c
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
