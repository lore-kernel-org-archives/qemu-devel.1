Received: from eggs.gnu.org ([209.51.188.92]:52665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glpe5-0007KU-QB
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 01:34:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glpe3-0002hU-ST
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 01:34:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1glpe2-0002g4-C3
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 01:34:46 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 294F085546
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 06:34:45 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 22 Jan 2019 07:34:40 +0100
Message-Id: <20190122063441.22458-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/1] Ipxe 20190122 patches
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

The following changes since commit 681d61362d3f766a00806b89d6581869041f73=
cb:

  Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request'=
 into staging (2019-01-17 12:48:42 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ipxe-20190122-pull-request

for you to fetch changes up to fd813c72392a712022d5d75a95416291cea229d7:

  ipxe: update to latest git master (2019-01-22 07:27:59 +0100)

----------------------------------------------------------------
ipxe: update to latest git master

----------------------------------------------------------------

Gerd Hoffmann (1):
  ipxe: update to latest git master

 pc-bios/efi-e1000.rom    | Bin 240128 -> 240128 bytes
 pc-bios/efi-e1000e.rom   | Bin 240128 -> 240128 bytes
 pc-bios/efi-eepro100.rom | Bin 240128 -> 240128 bytes
 pc-bios/efi-ne2k_pci.rom | Bin 238080 -> 238592 bytes
 pc-bios/efi-pcnet.rom    | Bin 238080 -> 238592 bytes
 pc-bios/efi-rtl8139.rom  | Bin 241664 -> 242688 bytes
 pc-bios/efi-virtio.rom   | Bin 242176 -> 242688 bytes
 pc-bios/efi-vmxnet3.rom  | Bin 236032 -> 236032 bytes
 roms/ipxe                |   2 +-
 9 files changed, 1 insertion(+), 1 deletion(-)

--=20
2.9.3
