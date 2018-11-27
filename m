Received: from eggs.gnu.org ([2001:4830:134:3::10]:35311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gReU3-0003tb-0o
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:37:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gReTw-0001dz-Rv
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:37:02 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 27 Nov 2018 15:36:30 +0100
Message-Id: <1543329397-48407-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543329397-48407-1-git-send-email-pbonzini@redhat.com>
References: <1543329397-48407-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 08/15] vl.c: remove outdated comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Li Qiang <liq3ea@gmail.com>, qemu-trivial@nongnu.org

From: Li Qiang <liq3ea@gmail.com>

Cc: qemu-trivial@nongnu.org

Signed-off-by: Li Qiang <liq3ea@gmail.com>
Message-Id: <1542276385-7638-1-git-send-email-liq3ea@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 vl.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/vl.c b/vl.c
index 611d887..a5ae5f2 100644
--- a/vl.c
+++ b/vl.c
@@ -1523,9 +1523,6 @@ static int machine_help_func(QemuOpts *opts, MachineState *machine)
     return 1;
 }
 
-/***********************************************************/
-/* main execution loop */
-
 struct vm_change_state_entry {
     VMChangeStateHandler *cb;
     void *opaque;
-- 
1.8.3.1
