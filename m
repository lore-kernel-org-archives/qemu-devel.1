Received: from eggs.gnu.org ([2001:4830:134:3::10]:50886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf2v-00007m-4b
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:24:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf2u-0001wr-A5
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:24:49 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33635)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVf2u-0001w6-2M
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:24:48 -0400
Received: by mail-wm0-x243.google.com with SMTP id j85so5436558wmj.0
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:24:47 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jul 2017 16:23:58 +0200
Message-Id: <1499955874-10954-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
References: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/41] MAINTAINERS: update TCI entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

moved in 244f1441 to tcg/

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20170629150308.22766-5-f4bug@amsat.org>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5540460..dd7e1e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1645,7 +1645,7 @@ TCI target
 M: Stefan Weil <sw@weilnetz.de>
 S: Maintained
 F: tcg/tci/
-F: tci.c
+F: tcg/tci.c
 F: disas/tci.c
 
 Block drivers
-- 
1.8.3.1
