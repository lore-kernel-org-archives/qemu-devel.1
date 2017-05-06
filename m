Received: from eggs.gnu.org ([2001:4830:134:3::10]:48644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d6xVE-0007c0-I0
	for qemu-devel@nongnu.org; Sat, 06 May 2017 07:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d6xVB-0007ZT-A0
	for qemu-devel@nongnu.org; Sat, 06 May 2017 07:03:54 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:39896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d6xVB-0007V2-4a
	for qemu-devel@nongnu.org; Sat, 06 May 2017 07:03:53 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sat,  6 May 2017 13:03:32 +0200
Message-Id: <20170506110333.11000-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PULL 0/1] tcg-mips queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

The following changes since commit 12a95f320a36ef66f724a49bb05e4fb553ac5dbe:

  Merge remote-tracking branch 'kwolf/tags/for-upstream' into staging (2017-05-04 13:44:32 +0100)

are available in the git repository at:

  git://git.aurel32.net/qemu.git tags/pull-tcg-mips-20170506

for you to fetch changes up to 2f5a5f5774d95baacf86c03aa8a77a2d0390f2b2:

  tcg/mips: fix field extraction opcode (2017-05-06 12:48:53 +0200)

----------------------------------------------------------------
Fix MIPS R2 hosts support

----------------------------------------------------------------

Aurelien Jarno (1):
  tcg/mips: fix field extraction opcode

 tcg/mips/tcg-target.inc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.11.0
