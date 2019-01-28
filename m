Received: from eggs.gnu.org ([209.51.188.92]:32960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1goEME-0008Fj-W0
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 16:22:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1goEMC-0001R2-Pc
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 16:22:18 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Mon, 28 Jan 2019 21:21:55 +0000
Message-Id: <20190128212157.424-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 0/2] qemu-macppc patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Here's the contents of my qemu-macppc branch: just two minor patches consisting of
an update to MAINTAINERS, plus bringing in updated binaries containing bugfixes
for Ben's MacOS NDRV VGA driver.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Mark Cave-Ayland (2):
  MAINTAINERS: add myself as maintainer for Mac Old World and New World
    machines
  QemuMacDrivers: update qemu_vga.ndrv to 90c488d built from submodule

 MAINTAINERS           |   6 ++++--
 pc-bios/qemu_vga.ndrv | Bin 14752 -> 18752 bytes
 roms/QemuMacDrivers   |   2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.11.0
