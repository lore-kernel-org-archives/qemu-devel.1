Received: from eggs.gnu.org ([2001:4830:134:3::10]:48870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnAxs-0005S1-6r
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 17:56:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnAxq-0007gu-Su
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 17:56:00 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 30 Aug 2017 18:55:13 -0300
Message-Id: <20170830215523.25278-8-f4bug@amsat.org>
In-Reply-To: <20170830215523.25278-1-f4bug@amsat.org>
References: <20170830215523.25278-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 07/17] MAINTAINERS: add missing qcow2 entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-block@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f4e07173c8..eb20365fbb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1841,6 +1841,7 @@ M: Max Reitz <mreitz@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/qcow2*
+F: docs/interop/qcow2.txt
 
 qcow
 M: Kevin Wolf <kwolf@redhat.com>
-- 
2.14.1
