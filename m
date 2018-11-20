Received: from eggs.gnu.org ([2001:4830:134:3::10]:33441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gOz8x-0000cu-On
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 01:04:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gOz6S-0004I9-F8
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 01:01:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gOz6S-0004Ho-AN
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 01:01:40 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9B4D9C0C2726
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 06:01:39 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 20 Nov 2018 07:01:37 +0100
Message-Id: <20181120060138.25446-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] Seabios 1.12 20181120 patches
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

The following changes since commit cb968d275c145467c8b385a3618a207ec111eab1:

  Update version for v3.1.0-rc1 release (2018-11-13 18:16:14 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/seabios-1.12-20181120-pull-request

for you to fetch changes up to af51dbed380b7eec0c815da1c37b46e57a909ce8:

  update seabios to 1.12 (2018-11-20 06:57:53 +0100)

----------------------------------------------------------------
seabios: update to 1.12-final

----------------------------------------------------------------

Gerd Hoffmann (1):
  update seabios to 1.12

 pc-bios/bios-256k.bin             | Bin 262144 -> 262144 bytes
 pc-bios/bios.bin                  | Bin 131072 -> 131072 bytes
 pc-bios/vgabios-bochs-display.bin | Bin 27648 -> 27648 bytes
 pc-bios/vgabios-cirrus.bin        | Bin 38400 -> 38400 bytes
 pc-bios/vgabios-qxl.bin           | Bin 38912 -> 38912 bytes
 pc-bios/vgabios-ramfb.bin         | Bin 28160 -> 28160 bytes
 pc-bios/vgabios-stdvga.bin        | Bin 38912 -> 38912 bytes
 pc-bios/vgabios-virtio.bin        | Bin 38912 -> 38912 bytes
 pc-bios/vgabios-vmware.bin        | Bin 38912 -> 38912 bytes
 pc-bios/vgabios.bin               | Bin 38400 -> 38400 bytes
 roms/Makefile                     |   2 +-
 roms/seabios                      |   2 +-
 12 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.9.3
