Received: from eggs.gnu.org ([2001:4830:134:3::10]:46250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g86LH-0005ZW-RJ
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:19:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g86LG-0002X8-TD
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:19:11 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Thu,  4 Oct 2018 12:18:43 -0400
Message-Id: <20181004161852.11673-2-crosa@redhat.com>
In-Reply-To: <20181004161852.11673-1-crosa@redhat.com>
References: <20181004161852.11673-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 01/10] qemu-img.c: comment typo fix
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

A trivial comment typo fix.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 qemu-img.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index b12f4cd19b..a96b76c187 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1085,7 +1085,7 @@ static int64_t find_nonzero(const uint8_t *buf, int64_t n)
 }
 
 /*
- * Returns true iff the first sector pointed to by 'buf' contains at least
+ * Returns true if the first sector pointed to by 'buf' contains at least
  * a non-NUL byte.
  *
  * 'pnum' is set to the number of sectors (including and immediately following
-- 
2.17.1
