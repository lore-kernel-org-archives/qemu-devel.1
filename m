Received: from eggs.gnu.org ([2001:4830:134:3::10]:35885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amit.shah@redhat.com>) id 1cZboM-0004EP-Au
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:13:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amit.shah@redhat.com>) id 1cZboH-0001mW-BQ
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:13:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amit.shah@redhat.com>)
	id 1cZboH-0001lY-5k
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:13:45 -0500
From: Amit Shah <amit.shah@redhat.com>
Date: Fri,  3 Feb 2017 16:43:36 +0530
Message-Id: <1486120416-11566-1-git-send-email-amit.shah@redhat.com>
Subject: [Qemu-devel] [PATCH] migration: remove myself as maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu list <qemu-devel@nongnu.org>, Amit Shah <amit.shah@redhat.com>

I'm switching jobs, and I'm not sure I can continue maintaining migration.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 00b81f1..4382bcc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1431,7 +1431,6 @@ F: scripts/checkpatch.pl
 
 Migration
 M: Juan Quintela <quintela@redhat.com>
-M: Amit Shah <amit.shah@redhat.com>
 M: Dr. David Alan Gilbert <dgilbert@redhat.com>
 S: Maintained
 F: include/migration/
-- 
1.8.3.1
