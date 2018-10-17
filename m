Received: from eggs.gnu.org ([2001:4830:134:3::10]:53446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCiiA-0005yH-Am
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCii7-0002Dz-4l
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gCii6-00012D-MT
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:50 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 17 Oct 2018 12:04:58 +0200
Message-Id: <1539770707-7289-7-git-send-email-thuth@redhat.com>
In-Reply-To: <1539770707-7289-1-git-send-email-thuth@redhat.com>
References: <1539770707-7289-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 06/15] MAINTAINERS: update block/sheepdog
 maintainers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

From: Liu Yuan <liuyuan1@cmiot.chinamobile.com>

E-mail to one of block/sheepdog maintainers Mitake Hitoshi bounces

<mitake.hitoshi@lab.ntt.co.jp>: unknown user: "mitake.hitoshi"

and no current address is known. So just remove it.

Signed-off-by: Liu Yuan <liuyuan1@cmiot.chinamobile.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fb81b3a..40672c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2023,7 +2023,6 @@ F: block/rbd.c
 T: git git://github.com/codyprime/qemu-kvm-jtc.git block
 
 Sheepdog
-M: Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>
 M: Liu Yuan <namei.unix@gmail.com>
 M: Jeff Cody <jcody@redhat.com>
 L: qemu-block@nongnu.org
-- 
1.8.3.1
