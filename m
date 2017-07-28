Received: from eggs.gnu.org ([2001:4830:134:3::10]:60920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbE1W-000561-2d
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 18:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbE1V-0002Bt-BA
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 18:46:22 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 28 Jul 2017 19:46:02 -0300
Message-Id: <20170728224608.3598-3-f4bug@amsat.org>
In-Reply-To: <20170728224608.3598-1-f4bug@amsat.org>
References: <20170728224608.3598-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 for 2.10 2/8] docs: fix broken paths to
 docs/interop/qcow2.txt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-block@nongnu.org

With the move of some docs to docs/interop on d59157ea05, a reference path
was not updated.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 docs/qcow2-cache.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
index 1fdd6f9ce7..b0571de4b8 100644
--- a/docs/qcow2-cache.txt
+++ b/docs/qcow2-cache.txt
@@ -15,7 +15,7 @@ not a straightforward operation.
 This document attempts to give an overview of the L2 and refcount
 caches, and how to configure them.
 
-Please refer to the docs/specs/qcow2.txt file for an in-depth
+Please refer to the docs/interop/qcow2.txt file for an in-depth
 technical description of the qcow2 file format.
 
 
-- 
2.13.3
