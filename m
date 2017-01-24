Received: from eggs.gnu.org ([2001:4830:134:3::10]:55300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cW68B-0001Gi-Li
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cW689-0006n0-HP
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cW689-0006mP-Bm
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:45 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7366F341ACA
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 18:47:45 +0000 (UTC)
Received: from dgilbert-t530.redhat.com (ovpn-116-204.ams2.redhat.com
	[10.36.116.204])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v0OIlhUn020536
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 13:47:44 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 24 Jan 2017 18:47:28 +0000
Message-Id: <20170124184742.1639-2-dgilbert@redhat.com>
In-Reply-To: <20170124184742.1639-1-dgilbert@redhat.com>
References: <20170124184742.1639-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 01/15] MAINTAINERS: Add myself as a migration
 submaintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Amit Shah <amit.shah@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20170124100437.18200-1-dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6a3df66..e41271c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1420,6 +1420,7 @@ F: scripts/checkpatch.pl
 Migration
 M: Juan Quintela <quintela@redhat.com>
 M: Amit Shah <amit.shah@redhat.com>
+M: Dr. David Alan Gilbert <dgilbert@redhat.com>
 S: Maintained
 F: include/migration/
 F: migration/
-- 
2.9.3
