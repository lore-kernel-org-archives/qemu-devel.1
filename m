Received: from eggs.gnu.org ([2001:4830:134:3::10]:51219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ekQ7o-00006F-C7
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 03:03:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ekQ7k-0000Vd-DJ
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 03:03:08 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sat, 10 Feb 2018 10:55:05 +0300
Message-Id: <a348f64d4652d68212886019ca74825aa1667969.1518249254.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
References: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
References: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 10/17] maint: Mention web site maintenance in
 README
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Eric Blake <eblake@redhat.com>

Now that we have a website that accepts patches on the list, the
main project should make it easier to find information about that
process.

Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
 README | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/README b/README
index b92a07a61a..2c8e1c8cc4 100644
--- a/README
+++ b/README
@@ -68,6 +68,10 @@ the QEMU website
   https://qemu.org/Contribute/SubmitAPatch
   https://qemu.org/Contribute/TrivialPatches
 
+The QEMU website is also maintained under source control.
+
+  git clone git://git.qemu.org/qemu-web.git
+  https://www.qemu.org/2017/02/04/the-new-qemu-website-is-up/
 
 Bug reporting
 =============
-- 
2.11.0
