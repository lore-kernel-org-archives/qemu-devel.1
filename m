Received: from eggs.gnu.org ([2001:4830:134:3::10]:34209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eluT6-0002MD-JU
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 05:39:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eluT0-0003Fo-TK
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 05:39:14 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:50633)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eluT0-0003FX-J2
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 05:39:10 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 14 Feb 2018 11:39:05 +0100
Message-Id: <20180214103906.3704-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 0/1] M68k for 2.12 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

The following changes since commit bec9c64ef7be8063f1192608b83877bc5c9ea217:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-02-13 18:24:08 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.12-pull-request

for you to fetch changes up to 1226e212292e271b8795265c9639d5c0553df199:

  m68k: implement movep instruction (2018-02-14 11:09:13 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Pavel Dovgalyuk (1):
  m68k: implement movep instruction

 target/m68k/cpu.c       |  2 ++
 target/m68k/cpu.h       |  1 +
 target/m68k/translate.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

-- 
2.14.3
