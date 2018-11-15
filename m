Received: from eggs.gnu.org ([2001:4830:134:3::10]:46616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gNEXz-00019y-Eo
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:06:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gNEXw-0002lu-9m
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:06:51 -0500
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 15 Nov 2018 02:06:25 -0800
Message-Id: <1542276385-7638-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH] vl.c: remove outdated comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, laurent@vivier.eu
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

Cc: qemu-trivial@nongnu.org

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 vl.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/vl.c b/vl.c
index fa25d1ae2d..ae63018a1d 100644
--- a/vl.c
+++ b/vl.c
@@ -1522,9 +1522,6 @@ static int machine_help_func(QemuOpts *opts, MachineState *machine)
     return 1;
 }
 
-/***********************************************************/
-/* main execution loop */
-
 struct vm_change_state_entry {
     VMChangeStateHandler *cb;
     void *opaque;
-- 
2.11.0
