Received: from eggs.gnu.org ([209.51.188.92]:50322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gixOe-0007Fn-Bb
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 03:15:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gixOd-0003Wy-8J
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 03:15:00 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Mon, 14 Jan 2019 19:14:54 +1100
Message-Id: <20190114081454.9991-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [GIT PULL for qemu-pseries] pseries: Update SLOF
 firmware image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

The following changes since commit 27df21ca3886fff4dd3d70e515517667963a52f1:

  Merge remote-tracking branch 'remotes/kraxel/tags/misc-20190111-pull-request' into staging (2019-01-11 16:45:59 +0000)

are available in the Git repository at:

  git@github.com:aik/qemu.git tags/qemu-slof-20190114

for you to fetch changes up to c4560a5144a01ebda98830cfa3203ce26a020386:

  pseries: Update SLOF firmware image (2019-01-14 18:06:53 +1100)

----------------------------------------------------------------
qemu-slof-20190114 signed update

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      pseries: Update SLOF firmware image

 pc-bios/README   |   2 +-
 pc-bios/slof.bin | Bin 974544 -> 926392 bytes
 roms/SLOF        |   2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)


*** Note: this is not for master, this is for pseries
