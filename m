Received: from eggs.gnu.org ([2001:4830:134:3::10]:53929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dCtum-00081p-Eo
	for qemu-devel@nongnu.org; Mon, 22 May 2017 16:26:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dCtuj-0001Yr-8Y
	for qemu-devel@nongnu.org; Mon, 22 May 2017 16:26:52 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 22 May 2017 22:26:45 +0200
Message-Id: <1495484805-4201-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-doc: Add hyperlinks to further license
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

Add a link to the GPLv2 and a link to the LICENSE file in the
QEMU repository to fix the two TODO items in this appendix.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qemu-doc.texi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index de0cc30..b0bfd84 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -3020,10 +3020,10 @@ Run the emulation in single step mode.
 
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
1.8.3.1
