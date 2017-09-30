Received: from eggs.gnu.org ([2001:4830:134:3::10]:38102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1dy9FH-0000GT-7g
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 00:19:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1dy9FD-0001sg-TW
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 00:19:19 -0400
Received: from prv3-mh.provo.novell.com ([137.65.250.26]:34179)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lma@suse.com>) id 1dy9FD-0001rE-OA
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 00:19:15 -0400
From: Lin Ma <lma@suse.com>
Date: Sat, 30 Sep 2017 12:18:55 +0800
Message-Id: <20170930041855.10997-1-lma@suse.com>
Subject: [Qemu-devel] [PATCH] maint: Add scsi/qemu-pr-helper to .gitignore
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Lin Ma <lma@suse.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 40acfcb9e2..30474bc1df 100644
--- a/.gitignore
+++ b/.gitignore
@@ -135,3 +135,4 @@ trace-dtrace-root.h
 trace-dtrace-root.dtrace
 trace-ust-all.h
 trace-ust-all.c
+scsi/qemu-pr-helper
-- 
2.14.0
