Received: from eggs.gnu.org ([2001:4830:134:3::10]:48195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dwwQN-0003Ch-U9
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 16:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dwwQJ-0000dk-10
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 16:25:47 -0400
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Date: Tue, 26 Sep 2017 13:25:12 -0700
Message-Id: <20170926202512.37670-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] gitignore: ignore check-qlit test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, qemu-trivial@nongnu.org, =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 tests/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/.gitignore b/tests/.gitignore
index cf6d99c91e..53cb2efaee 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -6,6 +6,7 @@ check-qdict
 check-qnum
 check-qjson
 check-qlist
+check-qlit
 check-qnull
 check-qstring
 check-qom-interface
-- 
2.13.5 (Apple Git-94)
