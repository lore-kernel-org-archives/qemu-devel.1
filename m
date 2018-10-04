Received: from eggs.gnu.org ([2001:4830:134:3::10]:46249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g86LH-0005ZV-RH
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:19:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g86LG-0002X4-T6
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:19:11 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Thu,  4 Oct 2018 12:18:44 -0400
Message-Id: <20181004161852.11673-3-crosa@redhat.com>
In-Reply-To: <20181004161852.11673-1-crosa@redhat.com>
References: <20181004161852.11673-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 02/10] tests/tcg/README: fix location for lm32
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Cleber Rosa <crosa@redhat.com>, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>

Point to the right and obvious location for lm32 tests.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/tcg/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/README b/tests/tcg/README
index a5643d33e7..2a58f9a058 100644
--- a/tests/tcg/README
+++ b/tests/tcg/README
@@ -10,6 +10,6 @@ with "make test-cris".
 
 LM32
 ====
-The testsuite for LM32 is in tests/tcg/cris.  You can run it
+The testsuite for LM32 is in tests/tcg/lm32.  You can run it
 with "make test-lm32".
 
-- 
2.17.1
