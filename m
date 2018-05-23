Received: from eggs.gnu.org ([2001:4830:134:3::10]:57597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLQXf-0005jk-0p
	for qemu-devel@nongnu.org; Wed, 23 May 2018 05:58:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLQXe-0004fl-Cb
	for qemu-devel@nongnu.org; Wed, 23 May 2018 05:58:47 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 23 May 2018 11:58:28 +0200
Message-Id: <20180523095830.24362-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] qemu-iotests: Add more tests to
 "migration" group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org

Kevin Wolf (2):
  qemu-iotests: Add more tests to "migration" group
  qemu-iotests: Remove MIG_SOCKET from non-migration tests

 tests/qemu-iotests/185   |  2 --
 tests/qemu-iotests/191   |  2 --
 tests/qemu-iotests/group | 10 +++++-----
 3 files changed, 5 insertions(+), 9 deletions(-)

-- 
2.13.6
