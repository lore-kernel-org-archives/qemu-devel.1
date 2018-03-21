Received: from eggs.gnu.org ([2001:4830:134:3::10]:37497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyevf-0006sI-8W
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:41:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyeve-0002ER-HH
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:41:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46728 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1eyeve-0002E7-9j
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:41:26 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 21 Mar 2018 15:41:07 +0100
Message-Id: <20180321144107.22770-6-kwolf@redhat.com>
In-Reply-To: <20180321144107.22770-1-kwolf@redhat.com>
References: <20180321144107.22770-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 5/5] tests/multiboot: Add .gitignore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Jack Schwartz <jack.schwartz@oracle.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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
