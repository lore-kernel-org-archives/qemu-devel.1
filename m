Received: from eggs.gnu.org ([2001:4830:134:3::10]:34836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewAGL-0003Bk-Vk
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 13:32:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewAGL-0004FC-8x
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 13:32:30 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 14 Mar 2018 18:32:13 +0100
Message-Id: <20180314173213.18563-6-kwolf@redhat.com>
In-Reply-To: <20180314173213.18563-1-kwolf@redhat.com>
References: <20180314173213.18563-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 5/5] tests/multiboot: Add .gitignore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-stable@nongnu.org, jack.schwartz@oracle.com, anatol.pomozov@gmail.com, ppandit@redhat.com

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/multiboot/.gitignore | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 tests/multiboot/.gitignore

diff --git a/tests/multiboot/.gitignore b/tests/multiboot/.gitignore
new file mode 100644
index 0000000000..93ef99800b
--- /dev/null
+++ b/tests/multiboot/.gitignore
@@ -0,0 +1,3 @@
+*.bin
+*.elf
+test.out
-- 
2.13.6
