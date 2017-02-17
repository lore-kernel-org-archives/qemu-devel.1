Received: from eggs.gnu.org ([2001:4830:134:3::10]:32913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1ceWom-0003tl-PE
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 19:54:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1ceWol-0001pt-HW
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 19:54:36 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1ceWol-0001pR-C6
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 19:54:35 -0500
Received: by mail-qt0-x242.google.com with SMTP id b16so944387qte.2
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 16:54:35 -0800 (PST)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Thu, 16 Feb 2017 19:54:30 -0500
Message-Id: <20170217005431.4016-2-bobby.prani@gmail.com>
In-Reply-To: <20170217005431.4016-1-bobby.prani@gmail.com>
References: <20170217005431.4016-1-bobby.prani@gmail.com>
Subject: [Qemu-devel] [PATCH 1/2] Update README to accomodate markdown format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org, berrange@redhat.com, eblake@redhat.com

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 README | 44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/README b/README
index cb60d05bee..225afd6be7 100644
--- a/README
+++ b/README
@@ -1,5 +1,5 @@
-         QEMU README
-         ===========
+QEMU
+====
 
 QEMU is a generic and open source machine & userspace emulator and
 virtualizer.
@@ -31,22 +31,22 @@ version 2. For full licensing details, consult the LICENSE file.
 
 
 Building
-========
+--------
 
 QEMU is multi-platform software intended to be buildable on all modern
 Linux platforms, OS-X, Win32 (via the Mingw64 toolchain) and a variety
 of other UNIX targets. The simple steps to build QEMU are:
 
-  mkdir build
-  cd build
-  ../configure
-  make
+    mkdir build
+    cd build
+    ../configure
+    make
 
 Additional information can also be found online via the QEMU website:
 
-  http://qemu-project.org/Hosts/Linux
-  http://qemu-project.org/Hosts/Mac
-  http://qemu-project.org/Hosts/W32
+  - http://qemu-project.org/Hosts/Linux
+  - http://qemu-project.org/Hosts/Mac
+  - http://qemu-project.org/Hosts/W32
 
 
 Submitting patches
@@ -54,7 +54,7 @@ Submitting patches
 
 The QEMU source code is maintained under the GIT version control system.
 
-   git clone git://git.qemu-project.org/qemu.git
+    git clone git://git.qemu-project.org/qemu.git
 
 When submitting patches, the preferred approach is to use 'git
 format-patch' and/or 'git send-email' to format & send the mail to the
@@ -65,18 +65,18 @@ guidelines set out in the HACKING and CODING_STYLE files.
 Additional information on submitting patches can be found online via
 the QEMU website
 
-  http://qemu-project.org/Contribute/SubmitAPatch
-  http://qemu-project.org/Contribute/TrivialPatches
+  - http://qemu-project.org/Contribute/SubmitAPatch
+  - http://qemu-project.org/Contribute/TrivialPatches
 
 
 Bug reporting
-=============
+-------------
 
 The QEMU project uses Launchpad as its primary upstream bug tracker. Bugs
 found when running code built from QEMU git or upstream released sources
 should be reported via:
 
-  https://bugs.launchpad.net/qemu/
+  - https://bugs.launchpad.net/qemu/
 
 If using QEMU via an operating system vendor pre-built binary package, it
 is preferable to report bugs to the vendor's own bug tracker first. If
@@ -85,22 +85,20 @@ reported via launchpad.
 
 For additional information on bug reporting consult:
 
-  http://qemu-project.org/Contribute/ReportABug
+  - http://qemu-project.org/Contribute/ReportABug
 
 
 Contact
-=======
+-------
 
 The QEMU community can be contacted in a number of ways, with the two
 main methods being email and IRC
 
- - qemu-devel@nongnu.org
-   http://lists.nongnu.org/mailman/listinfo/qemu-devel
- - #qemu on irc.oftc.net
+ - Mailing List: qemu-devel@nongnu.org
+ - Archives: http://lists.nongnu.org/mailman/listinfo/qemu-devel
+ - IRC: #qemu on irc.oftc.net
 
 Information on additional methods of contacting the community can be
 found online via the QEMU website:
 
-  http://qemu-project.org/Contribute/StartHere
-
--- End
+  - http://qemu-project.org/Contribute/StartHere
-- 
2.11.0
