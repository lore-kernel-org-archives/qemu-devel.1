Received: from eggs.gnu.org ([2001:4830:134:3::10]:60816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dZW2a-0006mK-US
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 01:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dZW2X-0008RS-Rh
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 01:36:24 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Mon, 24 Jul 2017 15:35:42 +1000
Message-Id: <20170724053542.6099-1-aik@ozlabs.ru>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>

The following changes since commit 91939262ffcd3c85ea6a4793d3029326eea1d649:

  configure: Drop ancient Solaris 9 and earlier support (2017-07-21 15:04:05 +0100)

are available in the git repository at:

  git@github.com:aik/qemu.git tags/qemu-slof-20170724

for you to fetch changes up to 9f581865da041772eb2e1700c30d75489fe2c971:

  pseries: Update SLOF firmware image (2017-07-24 15:25:04 +1000)

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      pseries: Update SLOF firmware image

 pc-bios/README   |   2 +-
 pc-bios/slof.bin | Bin 902120 -> 905200 bytes
 roms/SLOF        |   2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)


*** Note: this is not for master, this is for pseries
