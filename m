Received: from eggs.gnu.org ([2001:4830:134:3::10]:57172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUCRr-0007he-No
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 08:08:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUCRo-0006J3-1n
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 08:08:15 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu, 19 Jan 2017 21:07:57 +0800
Message-Id: <20170119130759.28319-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] block: Fix iotests 059
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

The 059.out went out of sync, bring it back in line.

Fam Zheng (2):
  qapi: Tweak error message of bdrv_query_image_info
  iotests: Fix reference output for 059

 block/qapi.c               | 4 ++--
 tests/qemu-iotests/059.out | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.9.3
