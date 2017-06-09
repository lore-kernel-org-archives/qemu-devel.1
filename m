Received: from eggs.gnu.org ([2001:4830:134:3::10]:48621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dJJG7-0004YX-Jf
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 08:43:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dJJG6-0003d0-OG
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 08:43:23 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Fri,  9 Jun 2017 08:43:12 -0400
Message-Id: <20170609124313.8026-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] Block patches
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

The following changes since commit 64175afc695c0672876fbbfc31b299c86d562cb4:

  arm_gicv3: Fix ICC_BPR1 reset value when EL3 not implemented (2017-06-07 17:21:44 +0100)

are available in the git repository at:

  git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request

for you to fetch changes up to 56faeb9bb6872b3f926b3b3e0452a70beea10af2:

  block/gluster.c: Handle qdict_array_entries() failure (2017-06-09 08:41:29 -0400)

----------------------------------------------------------------
Gluster patch
----------------------------------------------------------------

Peter Maydell (1):
  block/gluster.c: Handle qdict_array_entries() failure

 block/gluster.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.9.3
