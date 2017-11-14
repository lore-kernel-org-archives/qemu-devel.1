Received: from eggs.gnu.org ([2001:4830:134:3::10]:38122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eEcNy-0005Sp-Eb
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:40:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eEcNv-0006tY-0H
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:40:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eEcNu-0006ry-KE
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:40:18 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8D50F7EA91
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 14:40:17 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 14 Nov 2017 15:40:01 +0100
Message-Id: <20171114144002.20156-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] Seabios 1.11 final 20171114 patches
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

The following changes since commit 2e550e31518f90cc9cb7e5c855a1995c317463a3:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20171110-pull-request' into staging (2017-11-14 08:39:50 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/seabios-1.11-final-20171114-pull-request

for you to fetch changes up to 6350b2a09b8a330cbfaea462a34bbb1b8c63d7b1:

  seabios: update to 1.11 final (2017-11-14 15:36:08 +0100)

----------------------------------------------------------------
seabios: update to 1.11 final

----------------------------------------------------------------

Gerd Hoffmann (1):
  seabios: update to 1.11 final

 pc-bios/bios-256k.bin      | Bin 262144 -> 262144 bytes
 pc-bios/bios.bin           | Bin 131072 -> 131072 bytes
 pc-bios/vgabios-cirrus.bin | Bin 38400 -> 38400 bytes
 pc-bios/vgabios-qxl.bin    | Bin 38912 -> 38912 bytes
 pc-bios/vgabios-stdvga.bin | Bin 38912 -> 38912 bytes
 pc-bios/vgabios-virtio.bin | Bin 38912 -> 38912 bytes
 pc-bios/vgabios-vmware.bin | Bin 38912 -> 38912 bytes
 pc-bios/vgabios.bin        | Bin 38400 -> 38400 bytes
 roms/seabios               |   2 +-
 9 files changed, 1 insertion(+), 1 deletion(-)

-- 
2.9.3
