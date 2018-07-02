Received: from eggs.gnu.org ([2001:4830:134:3::10]:33952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fZw5L-0000TZ-Pm
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:29:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fZw5G-0000NS-OP
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:29:31 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:33139)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fZw5G-0000N5-EV
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:29:26 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon,  2 Jul 2018 12:28:20 +0200
Message-Id: <20180702102821.22188-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 0/1] M68k for 3.0 patches
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

The following changes since commit 281bd281222776229d5dbf84d1a5c6d8d9d2a34b:

  Merge remote-tracking branch 'remotes/xtensa/tags/20180630-xtensa' into staging (2018-06-30 22:23:51 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu-m68k.git tags/m68k-for-3.0-pull-request

for you to fetch changes up to d9345f1e1b1936b9ed7026b83091cf701f7ce07e:

  target/m68k: correctly disassemble move16 (2018-07-02 12:02:00 +0200)

----------------------------------------------------------------
correctly disassemble move16

----------------------------------------------------------------

Laurent Vivier (1):
  target/m68k: correctly disassemble move16

 disas/m68k.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

-- 
2.14.4
