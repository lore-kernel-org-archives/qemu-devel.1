Received: from [2001:4830:134:3::10] (port=53255 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1fwReW-0001gN-CP
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 08:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1fwReI-0006PS-Q5
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 08:38:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41948 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ybettan@redhat.com>) id 1fwRe9-0006CG-Ul
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 08:38:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1F6E5402170B
	for <qemu-devel@nongnu.org>; Sun,  2 Sep 2018 12:36:26 +0000 (UTC)
From: Yoni Bettan <ybettan@redhat.com>
Date: Sun,  2 Sep 2018 15:36:08 +0300
Message-Id: <20180902123608.124586-5-ybettan@redhat.com>
In-Reply-To: <20180902123608.124586-1-ybettan@redhat.com>
References: <20180902123608.124586-1-ybettan@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] LICENSE.md : Reformatted to fit the
 Markdown (.md) format.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, Yoni Bettan <ybettan@redhat.com>

Signed-off-by: Yoni Bettan <ybettan@redhat.com>
---
 LICENSE => LICENSE.md | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
 rename LICENSE => LICENSE.md (90%)

diff --git a/LICENSE b/LICENSE.md
similarity index 90%
rename from LICENSE
rename to LICENSE.md
index 0e0b4b9553..644e953429 100644
--- a/LICENSE
+++ b/LICENSE.md
@@ -1,3 +1,5 @@
+# License
+
 The following points clarify the QEMU license:
 
 1) QEMU as a whole is released under the GNU General Public License,
@@ -11,7 +13,7 @@ option) any later version.
 
 As of July 2013, contributions under version 2 of the GNU General Public
 License (and no later version) are only accepted for the following files
-or directories: bsd-user/, linux-user/, hw/vfio/, hw/xen/xen_pt*.
+or directories: `bsd-user/`, `linux-user/`, `hw/vfio/`, `hw/xen/xen_pt*`.
 
 3) The Tiny Code Generator (TCG) is released under the BSD license
    (see license headers in files).
-- 
2.17.1
