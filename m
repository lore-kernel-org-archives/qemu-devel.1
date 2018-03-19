Received: from eggs.gnu.org ([2001:4830:134:3::10]:45159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1exs0Z-0000Mi-2J
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 06:27:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1exs0U-0000Tr-29
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 06:27:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48136 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1exs0T-0000Rc-Rz
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 06:27:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8B840EB6F9
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 10:27:04 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 19 Mar 2018 11:26:56 +0100
Message-Id: <20180319102657.29304-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] Seabios 1.11.1 20180319 patches
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

The following changes since commit e1e44a9916b4318e943aecd669e096222cb3eaeb:

  Merge remote-tracking branch 'remotes/xtensa/tags/20180316-xtensa' into staging (2018-03-17 14:15:03 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/seabios-1.11.1-20180319-pull-request

for you to fetch changes up to 9cdd2a736b99bad19fb4f88d2230c75f680c31ec:

  update seabios to 1.11.1 (2018-03-19 11:18:29 +0100)

----------------------------------------------------------------
update seabios to 1.11.1

----------------------------------------------------------------

Gerd Hoffmann (1):
  update seabios to 1.11.1

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
