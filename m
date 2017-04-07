Received: from eggs.gnu.org ([2001:4830:134:3::10]:54214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <weiqi4@huawei.com>) id 1cwOEI-0001ux-09
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 03:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <weiqi4@huawei.com>) id 1cwOEE-0001MR-4K
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 03:22:46 -0400
Received: from [45.249.212.189] (port=2915 helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <weiqi4@huawei.com>) id 1cwOED-0001Hn-Jr
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 03:22:42 -0400
From: weiqi <weiqi4@huawei.com>
Date: Fri, 7 Apr 2017 14:58:25 +0800
Message-ID: <1491548305-75464-1-git-send-email-weiqi4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/3] some simple cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, kraxel@redhat.com
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com, Wei Qi <weiqi4@huawei.com>

From: Wei Qi <weiqi4@huawei.com>

This patchset cleanups some unused/unnecessary variables assignment.

Wei Qi (3):
  vhost: simple clean up
  vnc: simple clean up
  esp-pci: simple clean up

 hw/scsi/esp-pci.c | 1 -
 hw/virtio/vhost.c | 1 -
 ui/vnc-enc-zrle.c | 1 -
 3 files changed, 3 deletions(-)

-- 
1.8.3.1
