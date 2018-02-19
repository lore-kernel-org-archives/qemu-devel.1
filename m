Received: from eggs.gnu.org ([2001:4830:134:3::10]:57004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1enjrf-0005JY-29
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 06:44:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1enjrc-0002fn-5g
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 06:44:11 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33010 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1enjrc-0002ff-2P
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 06:44:08 -0500
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Mon, 19 Feb 2018 13:43:32 +0200
Message-Id: <20180219114332.70443-11-marcel@redhat.com>
In-Reply-To: <20180219114332.70443-1-marcel@redhat.com>
References: <20180219114332.70443-1-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH PULL v2 10/10] MAINTAINERS: add entry for
 hw/rdma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, yuval.shaia@oracle.com, marcel@redhat.com

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 57358a08e2..6e7adad1df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2034,6 +2034,14 @@ F: block/replication.c
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
