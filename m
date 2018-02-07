Received: from eggs.gnu.org ([2001:4830:134:3::10]:58982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ejSfJ-0001Yj-P9
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:33:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ejSfI-0002k9-Ri
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:33:45 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38170 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1ejSfI-0002el-NA
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:33:44 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed,  7 Feb 2018 11:33:21 -0500
Message-Id: <20180207163322.25820-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] Ide patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com

The following changes since commit 0833df03f4206a6cf416fbb3d380fa95c8e61fba:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20180206a' into staging (2018-02-07 12:07:23 +0000)

are available in the Git repository at:

  https://github.com/jnsnow/qemu.git tags/ide-pull-request

for you to fetch changes up to 29e1d473ccb0703044541959df443c175ea5f5da:

  ide-test: test trim requests (2018-02-07 11:25:22 -0500)

----------------------------------------------------------------

----------------------------------------------------------------

Anton Nefedov (1):
  ide-test: test trim requests

 tests/ide-test.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

-- 
2.14.3
