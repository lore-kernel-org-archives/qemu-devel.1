Received: from eggs.gnu.org ([2001:4830:134:3::10]:48388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cVxy1-0002Ie-AC
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:04:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cVxxy-0008U1-2K
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:04:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cVxxx-0008Rg-TG
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:04:42 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7E78A3D95D
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 10:04:40 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 24 Jan 2017 10:04:37 +0000
Message-Id: <20170124100437.18200-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Add myself as a migration
 submaintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, amit.shah@redhat.com, quintela@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ad10004..c4b00ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1413,6 +1413,7 @@ F: scripts/checkpatch.pl
 Migration
 M: Juan Quintela <quintela@redhat.com>
 M: Amit Shah <amit.shah@redhat.com>
+M: Dr. David Alan Gilbert <dgilbert@redhat.com>
 S: Maintained
 F: include/migration/
 F: migration/
-- 
2.9.3
