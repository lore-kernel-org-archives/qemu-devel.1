Received: from eggs.gnu.org ([2001:4830:134:3::10]:35937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amit.shah@redhat.com>) id 1cZbof-0004Wy-NX
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:14:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amit.shah@redhat.com>) id 1cZboa-00021D-Jh
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:14:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amit.shah@redhat.com>)
	id 1cZboa-00020h-ER
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:14:04 -0500
From: Amit Shah <amit.shah@redhat.com>
Date: Fri,  3 Feb 2017 16:43:53 +0530
Message-Id: <1486120433-11628-1-git-send-email-amit.shah@redhat.com>
Subject: [Qemu-devel] [PATCH] MAINTAINERS: update my email address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu list <qemu-devel@nongnu.org>, Amit Shah <amit.shah@redhat.com>

I'm leaving my job at Red Hat, this email address will stop working next week.
Update it to one that I will have access to later.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4382bcc..d69549f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1034,7 +1034,7 @@ F: hw/input/virtio-input*.c
 F: include/hw/virtio/virtio-input.h
 
 virtio-serial
-M: Amit Shah <amit.shah@redhat.com>
+M: Amit Shah <amit@kernel.org>
 S: Supported
 F: hw/char/virtio-serial-bus.c
 F: hw/char/virtio-console.c
@@ -1043,7 +1043,7 @@ F: tests/virtio-console-test.c
 F: tests/virtio-serial-test.c
 
 virtio-rng
-M: Amit Shah <amit.shah@redhat.com>
+M: Amit Shah <amit@kernel.org>
 S: Supported
 F: hw/virtio/virtio-rng.c
 F: include/hw/virtio/virtio-rng.h
-- 
1.8.3.1
