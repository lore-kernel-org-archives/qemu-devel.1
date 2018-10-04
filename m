Received: from eggs.gnu.org ([2001:4830:134:3::10]:46297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g86LK-0005cu-TO
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:19:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g86LH-0002Xv-Ly
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:19:13 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Thu,  4 Oct 2018 12:18:48 -0400
Message-Id: <20181004161852.11673-7-crosa@redhat.com>
In-Reply-To: <20181004161852.11673-1-crosa@redhat.com>
References: <20181004161852.11673-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 06/10] thunk.c: clean up commented out
 definition
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

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 thunk.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/thunk.c b/thunk.c
index d5d8645cd4..e351ae53af 100644
--- a/thunk.c
+++ b/thunk.c
@@ -21,8 +21,6 @@
 #include "qemu.h"
 #include "exec/user/thunk.h"
 
-//#define DEBUG
-
 static unsigned int max_struct_entries;
 StructEntry *struct_entries;
 
-- 
2.17.1
