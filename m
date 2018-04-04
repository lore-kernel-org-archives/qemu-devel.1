Received: from eggs.gnu.org ([2001:4830:134:3::10]:54874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1f3kzX-0007Bi-Rm
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 12:10:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1f3kzX-0006VW-0U
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 12:10:31 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed,  4 Apr 2018 12:10:22 -0400
Message-Id: <20180404161023.19211-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL for-2.12 0/1] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

The following changes since commit fd69ad866b62ca8ed4337ffee83b6d82a4e99282:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2018-04-04 14:00:07 +0100)

are available in the git repository at:

  git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request

for you to fetch changes up to bfb15b4becf2c9cf484bc3bf893a37c8f3c15cb3:

  block/rbd: remove processed options from qdict (2018-04-04 12:05:13 -0400)

----------------------------------------------------------------
Regression fix for 2.12
----------------------------------------------------------------

Jeff Cody (1):
  block/rbd: remove processed options from qdict

 block/rbd.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.13.6
