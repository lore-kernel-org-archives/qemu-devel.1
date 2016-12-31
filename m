Received: from eggs.gnu.org ([2001:4830:134:3::10]:54316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8Is-0000ZW-ML
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:17:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8Iq-0008Hk-Q5
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:17:46 -0500
Received: from m12-14.163.com ([220.181.12.14]:42331)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8Iq-0008G5-6A
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:17:44 -0500
From: xiaoqiang zhao <zxq_yx_007@163.com>
Date: Sat, 31 Dec 2016 09:17:18 +0800
Message-Id: <20161231011720.3965-1-zxq_yx_007@163.com>
Subject: [Qemu-devel] [PATCH 0/2] QOM'ify audio devices code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

This patch set QOM'ify code about audio devices.
See each commit message for deatils.

xiaoqiang zhao (2):
  hw/audio: QOM'ify marvell_88w8618.c
  hw/audio: QOM'ify pl041.c

 hw/audio/marvell_88w8618.c | 18 +++++++++++-------
 hw/audio/pl041.c           | 25 ++++++++++++++-----------
 2 files changed, 25 insertions(+), 18 deletions(-)

-- 
2.11.0
