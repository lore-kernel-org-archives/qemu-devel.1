Received: from eggs.gnu.org ([208.118.235.92]:36331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ehdQQ-0006dz-3J
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:39:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ehdPL-0001gQ-W5
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:38:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ehdPL-0001eV-12
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:37:43 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA4853F738
	for <qemu-devel@nongnu.org>; Fri,  2 Feb 2018 08:32:34 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  2 Feb 2018 09:32:28 +0100
Message-Id: <20180202083229.6681-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] Vga 20180202 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit b05631954d6dfe93340d516660397e2c1a2a5dd6:

  Merge remote-tracking branch 'remotes/rth/tags/pull-hppa-20180131' into staging (2018-01-31 15:50:29 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/vga-20180202-pull-request

for you to fetch changes up to 34e304e97576a9e17680c868c00ff524a981007b:

  virtio-gpu: disallow vIOMMU (2018-02-02 08:53:22 +0100)

----------------------------------------------------------------
virtio-gpu: disallow vIOMMU

----------------------------------------------------------------

Peter Xu (1):
  virtio-gpu: disallow vIOMMU

 hw/display/virtio-gpu-pci.c | 8 +++++++-
 hw/display/virtio-gpu.c     | 5 +++++
 2 files changed, 12 insertions(+), 1 deletion(-)

-- 
2.9.3
