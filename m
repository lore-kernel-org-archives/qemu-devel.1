Received: from eggs.gnu.org ([2001:4830:134:3::10]:57742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eZdtp-0000WR-NS
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:32:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eZdtj-0001sd-N2
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:32:09 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Thu, 11 Jan 2018 17:32:01 +0300
Message-Id: <20180111143201.17865-1-mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PATCH trivial] scripts/argparse.py: spelling
 (independant)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
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
