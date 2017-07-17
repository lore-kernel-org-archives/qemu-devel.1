Received: from eggs.gnu.org ([2001:4830:134:3::10]:42041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX1xA-0007qf-5I
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:04:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX1x6-0004A1-Si
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:04:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dX1x6-00048y-N6
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:04:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EDFD880476
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 09:04:26 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 17 Jul 2017 11:04:22 +0200
Message-Id: <20170717090423.11433-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] Ipxe patches
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

The following changes since commit 6e2c46334385c7e295ac883c801c81b4925fb54f:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170711' into staging (2017-07-13 10:47:10 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ipxe-pull-request

for you to fetch changes up to 18375b5c1655d3ce0c5029404a4c993ac04c9d09:

  ipxe: update to commit 0600d3ae94 (2017-07-17 11:00:28 +0200)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Gerd Hoffmann (1):
  ipxe: update to commit 0600d3ae94

 pc-bios/efi-e1000.rom    | Bin 209920 -> 240128 bytes
 pc-bios/efi-e1000e.rom   | Bin 209920 -> 240128 bytes
 pc-bios/efi-eepro100.rom | Bin 209920 -> 240128 bytes
 pc-bios/efi-ne2k_pci.rom | Bin 208896 -> 238080 bytes
 pc-bios/efi-pcnet.rom    | Bin 208896 -> 238080 bytes
 pc-bios/efi-rtl8139.rom  | Bin 212480 -> 241664 bytes
 pc-bios/efi-virtio.rom   | Bin 212480 -> 242176 bytes
 pc-bios/efi-vmxnet3.rom  | Bin 206848 -> 236032 bytes
 roms/ipxe                |   2 +-
 9 files changed, 1 insertion(+), 1 deletion(-)

-- 
2.9.3
