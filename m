Received: from eggs.gnu.org ([2001:4830:134:3::10]:50829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf2s-00005o-M2
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:24:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf2p-0001pV-AE
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:24:46 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34691)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVf2p-0001ow-32
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:24:43 -0400
Received: by mail-wm0-x241.google.com with SMTP id p204so5452703wmg.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:24:43 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jul 2017 16:23:55 +0200
Message-Id: <1499955874-10954-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
References: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/41] MAINTAINERS: update TCG entries
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

moved in a9ded601..244f1441 to accel/

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20170629150308.22766-2-f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9529c94..74b3956 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -84,14 +84,10 @@ M: Paolo Bonzini <pbonzini@redhat.com>
 M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
 M: Richard Henderson <rth@twiddle.net>
 S: Maintained
-F: cpu-exec.c
-F: cpu-exec-common.c
 F: cpus.c
-F: cputlb.c
 F: exec.c
 F: softmmu_template.h
-F: translate-all.*
-F: translate-common.c
+F: accel/tcg/
 F: include/exec/cpu*.h
 F: include/exec/exec-all.h
 F: include/exec/helper*.h
-- 
1.8.3.1
