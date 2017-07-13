Received: from eggs.gnu.org ([2001:4830:134:3::10]:50883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf2u-00007Q-LW
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:24:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf2t-0001wU-Py
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:24:48 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVf2t-0001uy-Kc
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:24:47 -0400
Received: by mail-wm0-x244.google.com with SMTP id u23so5454780wma.2
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:24:47 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jul 2017 16:23:59 +0200
Message-Id: <1499955874-10954-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
References: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/41] MAINTAINERS: add entry for
 "Unimplemented" device
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

Also voluntary myself as reviewer

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20170629150308.22766-6-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dd7e1e5..b9aa878 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1155,6 +1155,13 @@ F: docs/specs/vmgenid.txt
 F: tests/vmgenid-test.c
 F: stubs/vmgenid.c
 
+Unimplemented device
+M: Peter Maydell <peter.maydell@linaro.org>
+R: Philippe Mathieu-Daudé <f4bug@amsat.org>
+S: Maintained
+F: include/hw/misc/unimp.h
+F: hw/misc/unimp.c
+
 Subsystems
 ----------
 Audio
-- 
1.8.3.1
