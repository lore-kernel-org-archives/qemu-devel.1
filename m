Received: from eggs.gnu.org ([2001:4830:134:3::10]:45687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwEVQ-0004sL-Jp
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 17:32:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwEVN-0000If-EW
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 17:32:04 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 25 Sep 2017 00:22:34 +0300
Message-Id: <94299fffab0071bdc75a90d334e50baba7bfbabd.1506288070.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
References: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
References: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/31] MAINTAINERS: update docs/interop/ entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

moved in commit 7746cf8aab68

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Acked-by: Fam Zheng <famz@redhat.com>
Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f4444467e0..932443df41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1271,7 +1271,7 @@ F: block/dirty-bitmap.c
 F: include/qemu/hbitmap.h
 F: include/block/dirty-bitmap.h
 F: tests/test-hbitmap.c
-F: docs/bitmaps.md
+F: docs/interop/bitmaps.rst
 T: git git://github.com/famz/qemu.git bitmaps
 T: git git://github.com/jnsnow/qemu.git bitmaps
=20
@@ -1857,7 +1857,7 @@ M: Denis V. Lunev <den@openvz.org>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/parallels.c
-F: docs/specs/parallels.txt
+F: docs/interop/parallels.txt
=20
 qed
 M: Stefan Hajnoczi <stefanha@redhat.com>
--=20
2.11.0
