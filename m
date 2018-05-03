Received: from eggs.gnu.org ([2001:4830:134:3::10]:53343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fEIqg-0002Ce-B6
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:20:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fEIqf-0008LH-2v
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:20:58 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:39810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fEIqe-0008L0-Rb
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:20:56 -0400
Received: by mail-wm0-x242.google.com with SMTP id f8-v6so469927wmc.4
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 11:20:56 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Thu,  3 May 2018 21:21:25 +0300
Message-Id: <20180503182125.20310-9-marcel.apfelbaum@gmail.com>
In-Reply-To: <20180503182125.20310-1-marcel.apfelbaum@gmail.com>
References: <20180503182125.20310-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PULL 8/8] MAINTAINERS: update Marcel Apfelbaum email
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel.apfelbaum@gmail.com, yuval.shaia@oracle.com, peter.maydell@linaro.org, f4bug@amsat.org

From: Marcel Apfelbaum <marcel@redhat.com>

Use my gmail account for maintainer tasks.

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
Message-Id: <20180426084523.10565-1-marcel@redhat.com>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 24b70169bc..459e3594e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -909,7 +909,7 @@ X86 Machines
 ------------
 PC
 M: Michael S. Tsirkin <mst@redhat.com>
-M: Marcel Apfelbaum <marcel@redhat.com>
+M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
 S: Supported
 F: include/hw/i386/
 F: hw/i386/
@@ -959,7 +959,7 @@ F: include/hw/timer/mc146818rtc*
 
 Machine core
 M: Eduardo Habkost <ehabkost@redhat.com>
-M: Marcel Apfelbaum <marcel@redhat.com>
+M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
 S: Supported
 F: hw/core/machine.c
 F: hw/core/null-machine.c
@@ -1033,7 +1033,7 @@ F: hw/ipack/
 
 PCI
 M: Michael S. Tsirkin <mst@redhat.com>
-M: Marcel Apfelbaum <marcel@redhat.com>
+M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
 S: Supported
 F: include/hw/pci/*
 F: hw/misc/pci-testdev.c
@@ -2075,7 +2075,7 @@ F: docs/block-replication.txt
 
 PVRDMA
 M: Yuval Shaia <yuval.shaia@oracle.com>
-M: Marcel Apfelbaum <marcel@redhat.com>
+M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
 S: Maintained
 F: hw/rdma/*
 F: hw/rdma/vmw/*
-- 
2.14.3
