Received: from eggs.gnu.org ([2001:4830:134:3::10]:43944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ekQ0F-0002e8-Uv
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 02:55:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ekQ0B-0000e0-Uw
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 02:55:19 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sat, 10 Feb 2018 10:54:57 +0300
Message-Id: <8c2486a5122e50a5f88f2ecb47c5086ad52c716e.1518249254.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
References: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
References: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 02/17] scripts/argparse.py: spelling
 (independant)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/argparse.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/argparse.py b/scripts/argparse.py
index 288c1f06c0..27d1f28935 100644
--- a/scripts/argparse.py
+++ b/scripts/argparse.py
@@ -76,7 +76,7 @@ considered public as object names -- the API of the formatter objects is
 still considered an implementation detail.)
 """
 
-__version__ = '1.4.0'  # we use our own version number independant of the
+__version__ = '1.4.0'  # we use our own version number independent of the
                        # one in stdlib and we release this on pypi.
 
 __external_lib__ = True  # to make sure the tests really test THIS lib,
-- 
2.11.0
