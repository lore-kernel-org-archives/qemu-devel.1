Received: from eggs.gnu.org ([2001:4830:134:3::10]:50483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ciZXH-0006ql-OF
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 23:37:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ciZXG-0007Tg-MM
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 23:37:15 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Mon, 27 Feb 2017 23:37:05 -0500
Message-Id: <20170228043707.23121-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org

The following changes since commit 8f2d7c341184a95d05476ea3c45dbae2b9ddbe51:

  Merge remote-tracking branch 'remotes/berrange/tags/pull-qcrypto-2017-02-27-1' into staging (2017-02-27 15:33:21 +0000)

are available in the git repository at:

  https://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request

for you to fetch changes up to 51654aa52a94612edfaf76dcb51c0a0b7821c90d:

  iscsi: add missing colons to the qapi docs (2017-02-27 23:33:41 -0500)

----------------------------------------------------------------
Block patches for 2.9
----------------------------------------------------------------

Jeff Cody (1):
  iscsi: add missing colons to the qapi docs

John Snow (1):
  block/mirror: fix broken sparseness detection

 block/mirror.c       |  2 +-
 qapi/block-core.json | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.9.3
