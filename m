Received: from eggs.gnu.org ([2001:4830:134:3::10]:47614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e5642-00018l-IY
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 04:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e563w-000784-LA
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 04:20:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e563w-000771-E2
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 04:20:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 67A6933A17B
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 08:20:19 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 19 Oct 2017 10:20:14 +0200
Message-Id: <20171019082015.16432-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] Seabios 1.11 prerelease 20171019 patches
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

The following changes since commit 861cd431c99e56ddb5953ca1da164a9c32b477ca:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.11-20171017' into staging (2017-10-17 15:26:51 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/seabios-1.11-prerelease-20171019-pull-request

for you to fetch changes up to 083fab0290f2c40d3d04f7f22eed9c8f2d5b6787:

  seabios: update to 1.11 prerelease (2017-10-19 10:14:26 +0200)

----------------------------------------------------------------
seabios: update to 1.11 prerelease

----------------------------------------------------------------

Gerd Hoffmann (1):
  seabios: update to 1.11 prerelease

 pc-bios/bios-256k.bin      | Bin 262144 -> 262144 bytes
 pc-bios/bios.bin           | Bin 131072 -> 131072 bytes
 pc-bios/vgabios-cirrus.bin | Bin 38400 -> 38400 bytes
 pc-bios/vgabios-qxl.bin    | Bin 38912 -> 38912 bytes
 pc-bios/vgabios-stdvga.bin | Bin 38912 -> 38912 bytes
 pc-bios/vgabios-virtio.bin | Bin 38912 -> 38912 bytes
 pc-bios/vgabios-vmware.bin | Bin 38912 -> 38912 bytes
 pc-bios/vgabios.bin        | Bin 38400 -> 38400 bytes
 roms/config.seabios-128k   |   4 ++++
 roms/seabios               |   2 +-
 10 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.9.3
