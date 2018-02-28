Received: from eggs.gnu.org ([2001:4830:134:3::10]:54993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1erA1w-0003Xs-0Q
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:17:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1erA1p-0003eb-DO
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:16:55 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:37412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1erA1o-0003cF-T6
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:16:49 -0500
Received: by mail-lf0-x244.google.com with SMTP id y19so5880349lfd.4
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 14:16:48 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 28 Feb 2018 14:16:09 -0800
Message-Id: <20180228221609.11265-12-jcmvbkbc@gmail.com>
In-Reply-To: <20180228221609.11265-1-jcmvbkbc@gmail.com>
References: <20180228221609.11265-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH v2 11/11] MAINTAINERS: fix W: address for xtensa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a334a25e5df0..33c4ef0935dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -279,7 +279,7 @@ T: git git://github.com/ehabkost/qemu.git x86-next
 
 Xtensa
 M: Max Filippov <jcmvbkbc@gmail.com>
-W: http://wiki.osll.spb.ru/doku.php?id=etc:users:jcmvbkbc:qemu-target-xtensa
+W: http://wiki.osll.ru/doku.php?id=etc:users:jcmvbkbc:qemu-target-xtensa
 S: Maintained
 F: target/xtensa/
 F: hw/xtensa/
-- 
2.11.0
