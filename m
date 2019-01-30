Received: from eggs.gnu.org ([209.51.188.92]:36914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1goppr-0001VQ-4B
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:23:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1goppp-0006XR-HY
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:23:23 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 30 Jan 2019 14:22:07 +0100
Message-Id: <20190130132214.25493-7-laurent@vivier.eu>
In-Reply-To: <20190130132214.25493-1-laurent@vivier.eu>
References: <20190130132214.25493-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/13] COPYING.LIB: Synchronize the LGPL 2.1
 with the version from gnu.org
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jiri Slaby <jslaby@suse.cz>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Stefan Hajnoczi <stefanha@redhat.com>, Stafford Horne <shorne@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Thomas Huth <thuth@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

From: Thomas Huth <thuth@redhat.com>

The current version of the LGPL 2.1 from gnu.org (see the URL
https://www.gnu.org/licenses/old-licenses/lgpl-2.1.txt ) slightly
differs from the old one that we use in our repository. Especially
the recommendation to use "either version 2 of the License, or [...]
any later version" is somewhat misleading, since there was never a
"version 2" of the "Lesser GPL" license - the "version 2" was still
called "Library GPL" instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <1548252536-6242-2-git-send-email-thuth@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 COPYING.LIB | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/COPYING.LIB b/COPYING.LIB
index 48afc2efd7..4362b49151 100644
--- a/COPYING.LIB
+++ b/COPYING.LIB
@@ -1,8 +1,8 @@
-		  GNU LESSER GENERAL PUBLIC LICENSE
-		       Version 2.1, February 1999
+                  GNU LESSER GENERAL PUBLIC LICENSE
+                       Version 2.1, February 1999
 
  Copyright (C) 1991, 1999 Free Software Foundation, Inc.
-	51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
  Everyone is permitted to copy and distribute verbatim copies
  of this license document, but changing it is not allowed.
 
@@ -10,7 +10,7 @@
  as the successor of the GNU Library Public License, version 2, hence
  the version number 2.1.]
 
-			    Preamble
+                            Preamble
 
   The licenses for most software are designed to take away your
 freedom to share and change it.  By contrast, the GNU General Public
@@ -112,7 +112,7 @@ modification follow.  Pay close attention to the difference between a
 former contains code derived from the library, whereas the latter must
 be combined with the library in order to run.
 

-		  GNU LESSER GENERAL PUBLIC LICENSE
+                  GNU LESSER GENERAL PUBLIC LICENSE
    TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
 
   0. This License Agreement applies to any software library or other
@@ -146,7 +146,7 @@ such a program is covered only if its contents constitute a work based
 on the Library (independent of the use of the Library in a tool for
 writing it).  Whether that is true depends on what the Library does
 and what the program that uses the Library does.
-  
+
   1. You may copy and distribute verbatim copies of the Library's
 complete source code as you receive it, in any medium, provided that
 you conspicuously and appropriately publish on each copy an
@@ -432,7 +432,7 @@ decision will be guided by the two goals of preserving the free status
 of all derivatives of our free software and of promoting the sharing
 and reuse of software generally.
 
-			    NO WARRANTY
+                            NO WARRANTY
 
   15. BECAUSE THE LIBRARY IS LICENSED FREE OF CHARGE, THERE IS NO
 WARRANTY FOR THE LIBRARY, TO THE EXTENT PERMITTED BY APPLICABLE LAW.
@@ -455,7 +455,7 @@ FAILURE OF THE LIBRARY TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
 SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH
 DAMAGES.
 
-		     END OF TERMS AND CONDITIONS
+                     END OF TERMS AND CONDITIONS
 

            How to Apply These Terms to Your New Libraries
 
@@ -476,7 +476,7 @@ convey the exclusion of warranty; and each file should have at least the
     This library is free software; you can redistribute it and/or
     modify it under the terms of the GNU Lesser General Public
     License as published by the Free Software Foundation; either
-    version 2 of the License, or (at your option) any later version.
+    version 2.1 of the License, or (at your option) any later version.
 
     This library is distributed in the hope that it will be useful,
     but WITHOUT ANY WARRANTY; without even the implied warranty of
@@ -485,7 +485,7 @@ convey the exclusion of warranty; and each file should have at least the
 
     You should have received a copy of the GNU Lesser General Public
     License along with this library; if not, write to the Free Software
-    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 
 Also add information on how to contact you by electronic and paper mail.
 
@@ -500,5 +500,3 @@ necessary.  Here is a sample; alter the names:
   Ty Coon, President of Vice
 
 That's all there is to it!
-
-
-- 
2.20.1
