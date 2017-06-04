Received: from eggs.gnu.org ([2001:4830:134:3::10]:59724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHXir-0002Mf-Bs
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 11:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHXin-0005rQ-HA
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 11:45:45 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun,  4 Jun 2017 18:45:06 +0300
Message-Id: <2f8d8f01c8a501e74a7911555587dbb79acae727.1496591095.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
References: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
References: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 02/22] qemu-doc: Add hyperlinks to further
 license information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Thomas Huth <thuth@redhat.com>

Add a link to the GPLv2 and a link to the LICENSE file in the
QEMU repository to fix the two TODO items in this appendix.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-doc.texi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 3f4ed0aa9a..965ba5929e 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -3021,10 +3021,10 @@ Run the emulation in single step mode.
 
 QEMU is a trademark of Fabrice Bellard.
 
-QEMU is released under the GNU General Public License (TODO: add link).
-Parts of QEMU have specific licenses, see file LICENSE.
-
-TODO (refer to file LICENSE, include it, include the GPL?)
+QEMU is released under the
+@url{https://www.gnu.org/licenses/gpl-2.0.txt,GNU General Public License},
+version 2. Parts of QEMU have specific licenses, see file
+@url{http://git.qemu.org/?p=qemu.git;a=blob_plain;f=LICENSE,LICENSE}.
 
 @node Index
 @appendix Index
-- 
2.11.0
