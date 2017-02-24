Received: from eggs.gnu.org ([2001:4830:134:3::10]:35486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ch3ey-00051k-Eu
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 19:22:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ch3eu-00031o-Hx
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 19:22:56 -0500
Received: from mailapp01.imgtec.com ([195.59.15.196]:16823)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ch3eu-00031f-By
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 19:22:52 -0500
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Fri, 24 Feb 2017 00:22:30 +0000
Message-ID: <1487895752-28659-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 0/2] target-mips queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>

The following changes since commit 10f25e4844cb9b3f02fb032f88051dd5b65b4206:

  Merge remote-tracking branch 'remotes/yongbok/tags/mips-20170222' into staging (2017-02-23 09:59:40 +0000)

are available in the git repository at:

  git://github.com/yongbok/upstream-qemu.git tags/mips-20170224

for you to fetch changes up to 0288d4485392832b25e40551433377a36d56dd8c:

  hw/mips: MIPS Boston board support (2017-02-24 00:04:32 +0000)

----------------------------------------------------------------
MIPS patches 2017-02-24

Changes:
* Revert the boston model commit which breaks "make check" on 32-bit hosts
* Add the boston model with fixing the issue.

----------------------------------------------------------------

Paul Burton (1):
  hw/mips: MIPS Boston board support

Yongbok Kim (1):
  Revert "hw/mips: MIPS Boston board support"

 hw/mips/boston.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.7.4
