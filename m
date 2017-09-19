Received: from eggs.gnu.org ([2001:4830:134:3::10]:59924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfL-00047H-F5
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfF-0005Pm-Ov
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:15 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHfF-0005O2-J7
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:09 -0400
Received: by mail-wm0-x242.google.com with SMTP id i131so3749680wma.1
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:30:09 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:29:11 +0200
Message-Id: <1505824179-21541-23-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/50] MAINTAINERS: update email,
 add missing test entry for megasas
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

and update maintainer email address

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20170910171557.12689-1-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 57f4efd..ef7c191 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1103,11 +1103,12 @@ F: hw/block/nvme*
 F: tests/nvme-test.c
 
 megasas
-M: Hannes Reinecke <hare@suse.de>
+M: Hannes Reinecke <hare@suse.com>
 L: qemu-block@nongnu.org
 S: Supported
 F: hw/scsi/megasas.c
 F: hw/scsi/mfi.h
+F: tests/megasas-test.c
 
 Network packet abstractions
 M: Dmitry Fleytman <dmitry@daynix.com>
-- 
1.8.3.1
