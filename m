Received: from eggs.gnu.org ([2001:4830:134:3::10]:46134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5iL-0001x4-TT
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5iJ-000076-6b
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:45 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:42:10 -0500
Message-Id: <20180619014319.28272-45-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 044/113] tests/multiboot: Add .gitignore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>

From: Kevin Wolf <kwolf@redhat.com>

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Jack Schwartz <jack.schwartz@oracle.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
(cherry picked from commit e2679395d598bd40770c22a793c0152576ac211f)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
2.11.0
