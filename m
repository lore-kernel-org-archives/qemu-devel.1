Received: from eggs.gnu.org ([2001:4830:134:3::10]:38152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvIgy-0000CM-Jn
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvIgx-0001EX-KT
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:48:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dvIgx-0001E9-F4
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:48:07 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 22 Sep 2017 15:46:56 +0800
Message-Id: <20170922074659.30097-34-famz@redhat.com>
In-Reply-To: <20170922074659.30097-1-famz@redhat.com>
References: <20170922074659.30097-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 33/36] MAINTAINERS: Add tests/vm entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 13c1ac65b7..762e37bfd6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1905,6 +1905,7 @@ S: Maintained
 F: .travis.yml
 F: .shippable.yml
 F: tests/docker/
+F: tests/vm/
 W: https://travis-ci.org/qemu/qemu
 W: https://app.shippable.com/github/qemu/qemu
 W: http://patchew.org/QEMU/
-- 
2.13.5
