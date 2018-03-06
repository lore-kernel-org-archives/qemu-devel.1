Received: from eggs.gnu.org ([2001:4830:134:3::10]:39546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1et2Zw-0005mu-L7
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 21:43:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1et2Zt-0007ou-Ex
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 21:43:48 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37348 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1et2Zt-0007oo-A6
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 21:43:45 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8384A40214E7
	for <qemu-devel@nongnu.org>; Tue,  6 Mar 2018 02:43:41 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Tue,  6 Mar 2018 10:43:28 +0800
Message-Id: <20180306024328.19195-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] README: Fix typo 'git-publish'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com

Reported-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README b/README
index 7833b97365..49a9fd09cd 100644
--- a/README
+++ b/README
@@ -73,7 +73,7 @@ The QEMU website is also maintained under source control.
   git clone git://git.qemu.org/qemu-web.git
   https://www.qemu.org/2017/02/04/the-new-qemu-website-is-up/
 
-A 'git-profile' utility was created to make above process less
+A 'git-publish' utility was created to make above process less
 cumbersome, and is highly recommended for making regular contributions,
 or even just for sending consecutive patch series revisions. It also
 requires a working 'git send-email' setup, and by default doesn't
-- 
2.14.3
