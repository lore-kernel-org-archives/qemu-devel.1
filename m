Received: from eggs.gnu.org ([2001:4830:134:3::10]:45626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cbNLG-0006Os-94
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 03:11:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cbNLB-0004UW-BJ
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 03:11:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cbNLB-0004UM-5H
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 03:11:01 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  8 Feb 2017 09:10:58 +0100
Message-Id: <20170208081058.27512-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [qemu-web PATCH] releases: update 2.7 branch for 2.7.1
 release
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

Suggested-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 _data/releases.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/_data/releases.yml b/_data/releases.yml
index 883cab3..db02a39 100644
--- a/_data/releases.yml
+++ b/_data/releases.yml
@@ -2,8 +2,8 @@
   patch: 0
   date: "Dec 20 2016"
 - branch: 2.7
-  patch: 0
-  date: "Sep 2 2016"
+  patch: 1
+  date: "Dec 23 2016"
 - branch: 2.6
   patch: 2
   date: "Sep 29 2016"
-- 
2.9.3
