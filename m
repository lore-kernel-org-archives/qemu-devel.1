Received: from eggs.gnu.org ([2001:4830:134:3::10]:55482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dr5qF-0003ON-6D
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 13:16:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dr5qE-0003Y7-8P
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 13:16:19 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 10 Sep 2017 14:15:57 -0300
Message-Id: <20170910171557.12689-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] MAINTAINERS: update email,
 add missing test entry for megasas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hannes Reinecke <hare@suse.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>

and update maintainer email address

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Hannes Reinecke replied:
I'm currently on vacation with no internet access, but will be happy to answer your mail once I'm back at work on Sep, 12th.

 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 36eeb42d19..371e23a9ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1101,11 +1101,12 @@ F: hw/block/nvme*
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
2.14.1
