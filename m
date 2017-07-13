Received: from eggs.gnu.org ([2001:4830:134:3::10]:50832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf2s-00005s-Oe
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:24:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf2r-0001sO-PK
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:24:46 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVf2r-0001qC-JB
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:24:45 -0400
Received: by mail-wm0-x243.google.com with SMTP id y5so5443252wmh.3
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:24:45 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jul 2017 16:23:57 +0200
Message-Id: <1499955874-10954-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
References: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/41] MAINTAINERS: update Xen entries
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

moved in 56e2cd24..28b99f47 to hw/xen/ and hw/i386/xen/

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Message-Id: <20170629150308.22766-4-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 55061e9..5540460 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -323,7 +323,6 @@ M: Stefano Stabellini <sstabellini@kernel.org>
 M: Anthony Perard <anthony.perard@citrix.com>
 L: xen-devel@lists.xenproject.org
 S: Supported
-F: xen-*
 F: */xen*
 F: hw/9pfs/xen-9p-backend.c
 F: hw/char/xen_console.c
-- 
1.8.3.1
