Received: from eggs.gnu.org ([2001:4830:134:3::10]:55247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePa1W-0001z9-8q
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 15:22:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePa1V-0006jx-EP
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 15:22:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ePa1V-0006iA-8K
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 15:22:29 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 703637F7C2
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 20:22:28 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 14 Dec 2017 20:22:19 +0000
Message-Id: <20171214202220.20379-2-stefanha@redhat.com>
In-Reply-To: <20171214202220.20379-1-stefanha@redhat.com>
References: <20171214202220.20379-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] vhost-user: fix indentation in protocol
 specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/interop/vhost-user.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index 954771d0d8..fd8ac56562 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -53,8 +53,8 @@ Depending on the request type, payload can be:
 
  * A vring state description
    ---------------
-  | index | num |
-  ---------------
+   | index | num |
+   ---------------
 
    Index: a 32-bit index
    Num: a 32-bit number
-- 
2.14.3
