Received: from eggs.gnu.org ([2001:4830:134:3::10]:43965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1cjdpf-0007do-SG
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:24:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1cjdpc-0000yD-Ld
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:24:39 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Fri,  3 Mar 2017 14:24:30 +1100
Message-Id: <20170303032430.33308-1-aik@ozlabs.ru>
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

The following changes since commit ecb24d334af1a98ef0329f4b3b0e14ae8cb8770d:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tgt-20170302' into staging (2017-03-02 22:06:41 +0000)

are available in the git repository at:

  git@github.com:aik/qemu.git tags/qemu-slof-20170303

for you to fetch changes up to 138c1712bc9d5ea3a4de03e2d463259a11362367:

  pseries: Update SLOF firmware image (2017-03-03 13:35:43 +1100)

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      pseries: Update SLOF firmware image

 pc-bios/README   |   2 +-
 pc-bios/slof.bin | Bin 898232 -> 902120 bytes
 roms/SLOF        |   2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)


*** Note: this is not for master, this is for pseries
