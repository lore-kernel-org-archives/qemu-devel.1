Received: from eggs.gnu.org ([2001:4830:134:3::10]:58946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eQYTV-0006Yb-TE
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 07:55:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eQYTV-00068P-6Y
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 07:55:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eQYTU-00067k-P8
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 07:55:25 -0500
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Sun, 17 Dec 2017 14:54:57 +0200
Message-Id: <20171217125457.3429-6-marcel@redhat.com>
In-Reply-To: <20171217125457.3429-1-marcel@redhat.com>
References: <20171217125457.3429-1-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH V2 5/5] MAINTAINERS: add entry for hw/net/pvrdma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, yuval.shaia@oracle.com, marcel@redhat.com, pbonzini@redhat.com, mst@redhat.com

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ffd77b461c..d24401a4d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1960,6 +1960,13 @@ F: block/replication.c
 F: tests/test-replication.c
 F: docs/block-replication.txt
 
+PVRDMA
+M: Yuval Shaia <yuval.shaia@oracle.com>
+M: Marcel Apfelbaum <marcel@redhat.com>
+S: Maintained
+F: hw/net/pvrdma/*
+F: docs/pvrdma.txt
+
 Build and test automation
 -------------------------
 Build and test automation
-- 
2.13.5
