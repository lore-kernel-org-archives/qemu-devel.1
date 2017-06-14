Received: from eggs.gnu.org ([2001:4830:134:3::10]:50318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dLGGG-0008Lx-8D
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 17:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dLGGF-0004mc-Ep
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 17:55:36 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 14 Jun 2017 17:55:24 -0400
Message-Id: <20170614215526.9218-1-jcody@redhat.com>
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
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com

The following changes since commit 3f0602927b120a480b35dcf58cf6f95435b3ae91:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170613' into staging (2017-06-13 15:49:07 +0100)

are available in the git repository at:

  git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request

for you to fetch changes up to 5c3ad1a6a8fa041c57403dbe1fc5927eec0be66b:

  block/iscsi: enable filename option and parsing (2017-06-14 17:39:46 -0400)

----------------------------------------------------------------
Block patches
----------------------------------------------------------------

Jeff Cody (2):
  block/rbd: enable filename option and parsing
  block/iscsi: enable filename option and parsing

 block/iscsi.c | 22 +++++++++++++++++++++-
 block/rbd.c   | 22 +++++++++++++++++++++-
 2 files changed, 42 insertions(+), 2 deletions(-)

-- 
2.9.3
