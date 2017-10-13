Received: from eggs.gnu.org ([2001:4830:134:3::10]:34647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e2vjR-0003pj-Vx
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:54:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e2vjP-0000kz-6W
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:54:14 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 13 Oct 2017 16:53:55 +0800
Message-Id: <20171013085355.7563-4-famz@redhat.com>
In-Reply-To: <20171013085355.7563-1-famz@redhat.com>
References: <20171013085355.7563-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/3] MAINTAINERS: Track
 default-configs/pci.mak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3938ccbf8a..7cb237babc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -934,6 +934,7 @@ F: hw/pci/*
 F: hw/pci-bridge/*
 F: docs/pci*
 F: docs/specs/*pci*
+F: default-configs/pci.mak
 
 ACPI/SMBIOS
 M: Michael S. Tsirkin <mst@redhat.com>
-- 
2.13.5
