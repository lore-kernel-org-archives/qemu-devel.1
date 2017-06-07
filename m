Received: from eggs.gnu.org ([2001:4830:134:3::10]:54432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dIXIT-0002oG-EW
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:30:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dIXIO-0003P9-DP
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:30:37 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:56957)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dIXIO-0003OP-2j
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:30:32 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed,  7 Jun 2017 11:30:26 +0200
Message-Id: <20170607093027.14086-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 0/1] M68k for 2.10 patches
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

The following changes since commit 65dfad62a176f5265f801683be64149c5ad55f7d:

  Merge remote-tracking branch 'remotes/xtensa/tags/20170606-xtensa' into staging (2017-06-06 17:00:12 +0100)

are available in the git repository at:

  git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.10-pull-request

for you to fetch changes up to 18059c9e1648bf4fc5c7c1bae6f54690742b05ba:

  target/m68k: implement rtd (2017-06-07 11:18:30 +0200)

----------------------------------------------------------------

----------------------------------------------------------------

Laurent Vivier (1):
  target/m68k: implement rtd

 target/m68k/cpu.c       |  2 ++
 target/m68k/cpu.h       |  1 +
 target/m68k/translate.c | 11 +++++++++++
 3 files changed, 14 insertions(+)

-- 
2.9.4
