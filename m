Received: from eggs.gnu.org ([2001:4830:134:3::10]:45041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1d8Tj2-0003rq-9e
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:40:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1d8Tiz-0006q3-OC
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:40:28 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:56109)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1d8Tiz-0006pt-Dt
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:40:25 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 10 May 2017 17:39:50 +0200
Message-Id: <20170510153950.29343-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH] maintainers: Add myself as linux-user reviewer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>

I volunteer to review linux-user patches.
Adding myself will help to not miss some of them.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8224be0..c9eed8a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1577,6 +1577,7 @@ F: default-configs/*-bsd-user.mak
 
 Linux user
 M: Riku Voipio <riku.voipio@iki.fi>
+R: Laurent Vivier <laurent@vivier.eu>
 S: Maintained
 F: linux-user/
 F: default-configs/*-linux-user.mak
-- 
2.9.3
