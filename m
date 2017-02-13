Received: from eggs.gnu.org ([2001:4830:134:3::10]:39008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cdKlt-0003Rk-Cw
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:50:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cdKls-0005tz-8a
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:50:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cdKls-0005tg-2A
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:50:40 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 13 Feb 2017 17:50:21 +0000
Message-Id: <20170213175033.7314-3-dgilbert@redhat.com>
In-Reply-To: <20170213175033.7314-1-dgilbert@redhat.com>
References: <20170213175033.7314-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 02/14] MAINTAINERS: update my email address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, ashijeetacharya@gmail.com, amit@kernel.org, pbutsykin@virtuozzo.com, zhang.zhanghailiang@huawei.com

From: Amit Shah <amit.shah@redhat.com>

I'm leaving my job at Red Hat, this email address will stop working next week.
Update it to one that I will have access to later.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
Message-Id: <1486120433-11628-1-git-send-email-amit.shah@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d8ea161..fb57d8e 100644
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
2.9.3
