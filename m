Received: from eggs.gnu.org ([2001:4830:134:3::10]:40366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1P5-0001fL-Da
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 15:53:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1P4-0006ng-60
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 15:53:19 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sun, 25 Nov 2018 21:50:00 +0100
Message-Id: <20181125205000.10324-26-philmd@redhat.com>
In-Reply-To: <20181125205000.10324-1-philmd@redhat.com>
References: <20181125205000.10324-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.1 25/25] MAINTAINERS: Remove duplicate
 entries of qemu-devel@nongnu.org
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

The list is always selected by the 'All patches CC here' section.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c616861ca3..9d6dae71ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -109,7 +109,6 @@ L: qemu-s390x@nongnu.org
 Guest CPU cores (TCG):
 ----------------------
 Overall
-L: qemu-devel@nongnu.org
 M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
 M: Richard Henderson <rth@twiddle.net>
 R: Paolo Bonzini <pbonzini@redhat.com>
@@ -403,30 +402,25 @@ Hosts:
 ------
=20
 LINUX
-L: qemu-devel@nongnu.org
 S: Maintained
 F: linux-*
 F: linux-headers/
=20
 POSIX
-L: qemu-devel@nongnu.org
 S: Maintained
 F: *posix*
=20
 NETBSD
-L: qemu-devel@nongnu.org
 M: Kamil Rytarowski <kamil@netbsd.org>
 S: Maintained
 K: ^Subject:.*(?i)NetBSD
=20
 OPENBSD
-L: qemu-devel@nongnu.org
 M: Brad Smith <brad@comstyle.com>
 S: Maintained
 K: ^Subject:.*(?i)OpenBSD
=20
 W32, W64
-L: qemu-devel@nongnu.org
 M: Stefan Weil <sw@weilnetz.de>
 S: Maintained
 F: *win32*
@@ -532,7 +526,6 @@ F: include/hw/*/digic*
 Gumstix
 M: Peter Maydell <peter.maydell@linaro.org>
 R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
-L: qemu-devel@nongnu.org
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/gumstix.c
@@ -953,7 +946,6 @@ F: include/hw/intc/heathrow_pic.h
=20
 PReP
 M: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
-L: qemu-devel@nongnu.org
 L: qemu-ppc@nongnu.org
 S: Maintained
 F: hw/ppc/prep.c
@@ -1690,7 +1682,6 @@ S: Supported
 F: scripts/coverity-model.c
=20
 CPU
-L: qemu-devel@nongnu.org
 S: Supported
 F: qom/cpu.c
 F: include/qom/cpu.h
@@ -1722,7 +1713,6 @@ F: util/error.c
 F: util/qemu-error.c
=20
 GDB stub
-L: qemu-devel@nongnu.org
 S: Odd Fixes
 F: gdbstub*
 F: gdb-xml/
@@ -2124,7 +2114,6 @@ F: tcg/arm/
 F: disas/arm.c
=20
 i386 target
-L: qemu-devel@nongnu.org
 S: Maintained
 F: tcg/i386/
 F: disas/i386.c
@@ -2389,7 +2378,6 @@ Build and test automation
 M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
 M: Fam Zheng <famz@redhat.com>
 R: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
-L: qemu-devel@nongnu.org
 S: Maintained
 F: .travis.yml
 F: scripts/travis/
@@ -2405,7 +2393,6 @@ M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
 R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
 F: tests/tcg/Makefile
 F: tests/tcg/Makefile.include
-L: qemu-devel@nongnu.org
=20
 Documentation
 -------------
--=20
2.17.2
