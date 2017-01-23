Received: from eggs.gnu.org ([2001:4830:134:3::10]:48689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cVXan-00083T-PM
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 00:55:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cVXak-0004dg-Na
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 00:55:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cVXak-0004dC-IJ
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 00:54:58 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A9199C057FA9
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 05:54:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 23 Jan 2017 06:54:55 +0100
Message-Id: <1485150895-19753-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [RFC PATCH] MAINTAINERS: Add an entry for
 hw/core/null-machine.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org

The "Machine core" section sounds like a good match for this file.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b5ebfab..5be2033 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -813,6 +813,7 @@ M: Eduardo Habkost <ehabkost@redhat.com>
 M: Marcel Apfelbaum <marcel@redhat.com>
 S: Supported
 F: hw/core/machine.c
+F: hw/core/null-machine.c
 F: include/hw/boards.h
 
 Xtensa Machines
-- 
1.8.3.1
