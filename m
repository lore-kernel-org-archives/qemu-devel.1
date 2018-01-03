Received: from eggs.gnu.org ([2001:4830:134:3::10]:52789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eWkYx-0005d0-7T
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 10:02:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eWkYt-0003PF-7H
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 10:02:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eWkYt-0003OT-0q
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 10:02:35 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0DF5D2D1A6
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 15:02:34 +0000 (UTC)
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Wed,  3 Jan 2018 17:02:29 +0200
Message-Id: <20180103150229.52155-1-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Add myself as maintainer to X86
 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel@redhat.com, mst@redhat.com

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---

Hi,

Getting CC-ed will help me be more responsive.

Thanks,
Marcel

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 73a5555735..0b319573c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -845,6 +845,7 @@ X86 Machines
 ------------
 PC
 M: Michael S. Tsirkin <mst@redhat.com>
+M: Marcel Apfelbaum <marcel@redhat.com>
 S: Supported
 F: include/hw/i386/
 F: hw/i386/
-- 
2.13.5
