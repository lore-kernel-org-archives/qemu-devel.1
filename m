Received: from eggs.gnu.org ([2001:4830:134:3::10]:50537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1eZKJ4-0007uD-8l
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 12:36:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1eZKIz-0000mx-90
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 12:36:54 -0500
From: Klim Kireev <klim.kireev@virtuozzo.com>
Date: Wed, 10 Jan 2018 20:36:30 +0300
Message-Id: <20180110173635.28255-1-klim.kireev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/5 v2] preparation for Parallels Disk xml
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, qemu-block@nongnu.org

Parallels Desktop and Parallels Cloud Server uses images glued with the
bundle description in XML format. This series contains very basic
description of this XML files and makes preparations for actual
implementation to be followed.

Signed-off-by: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>

Changelog:

v2:
PATCH 1/5: Fix some places noticed by Stefan Hajnoczi <stefanha@redhat.com>
PATCH 2/5: Rebase to upstream
PATCH 3/5: Fix includes
