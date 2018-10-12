Received: from eggs.gnu.org ([2001:4830:134:3::10]:39313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <namei.unix@gmail.com>) id 1gAryq-0005Xn-7f
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 03:35:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <namei.unix@gmail.com>) id 1gAryk-0002W3-LM
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 03:35:28 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <namei.unix@gmail.com>)
	id 1gAryj-0002Uo-F5
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 03:35:22 -0400
Received: by mail-pf1-x441.google.com with SMTP id j23-v6so5747104pfi.4
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 00:35:21 -0700 (PDT)
From: Liu Yuan <namei.unix@gmail.com>
Date: Fri, 12 Oct 2018 15:35:10 +0800
Message-Id: <1539329710-11600-1-git-send-email-namei.unix@gmail.com>
Subject: [Qemu-devel] [PATCH] MAINTAINERS: update block/sheepdog maintainers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>

From: Liu Yuan <liuyuan1@cmiot.chinamobile.com>

E-mail to one of block/sheepdog maintainers Mitake Hitoshi bounces

<mitake.hitoshi@lab.ntt.co.jp>: unknown user: "mitake.hitoshi"

and no current address is known. So just remove it.

Signed-off-by: Liu Yuan <liuyuan1@cmiot.chinamobile.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3275cc6..6670c16 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2007,7 +2007,6 @@ F: block/rbd.c
 T: git git://github.com/codyprime/qemu-kvm-jtc.git block
 
 Sheepdog
-M: Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>
 M: Liu Yuan <namei.unix@gmail.com>
 M: Jeff Cody <jcody@redhat.com>
 L: qemu-block@nongnu.org
-- 
2.7.4
