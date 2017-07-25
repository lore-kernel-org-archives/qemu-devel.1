Received: from eggs.gnu.org ([2001:4830:134:3::10]:59804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1da2Cb-0000BJ-0W
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:56:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1da2Ca-0003MH-Er
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:56:53 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 25 Jul 2017 17:56:42 +0200
Message-Id: <20170725155644.20214-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] iotests: Fixes to 156 and 186
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

This series contains some small fixes for issues I stumbled upon when
preparing my pull request.


Max Reitz (2):
  iotests: Fix test 156
  iotests: Redirect stderr to stdout in 186

 tests/qemu-iotests/156     |  4 ++--
 tests/qemu-iotests/186     |  2 +-
 tests/qemu-iotests/186.out | 12 ++++++------
 3 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.9.4
