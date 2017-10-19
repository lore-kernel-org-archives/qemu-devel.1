Received: from eggs.gnu.org ([2001:4830:134:3::10]:60943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e54yk-0001yj-5L
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 03:10:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e54yh-0002t0-0y
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 03:10:54 -0400
Received: from chuckie.co.uk ([82.165.15.123]:45386
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e54yg-0002sS-Pn
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 03:10:50 -0400
Date: Thu, 19 Oct 2017 08:10:36 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20171019071036.GB20805@kentang.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL] Update OpenBIOS images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org

Hi Peter,

Here are the latest set of updates for OpenBIOS which should be pulled after the sun4u
patches have been applied due to breaking changes in the sun4u machine.


ATB,

Mark.


The following changes since commit 861cd431c99e56ddb5953ca1da164a9c32b477ca:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.11-20171017' into staging (2017-10-17 15:26:51 +0100)

are available in the git repository at:


  https://github.com/mcayland/qemu.git tags/qemu-openbios-signed

for you to fetch changes up to 08e2c1854d8bc32b3b6fcefbead0ea808c44cbc8:

  Update OpenBIOS images to 83818bd built from submodule. (2017-10-19 08:04:15 +0100)

----------------------------------------------------------------
Update OpenBIOS images

----------------------------------------------------------------
Mark Cave-Ayland (1):
      Update OpenBIOS images to 83818bd built from submodule.

 pc-bios/openbios-ppc     |  Bin 754936 -> 754936 bytes
 pc-bios/openbios-sparc32 |  Bin 382048 -> 382048 bytes
 pc-bios/openbios-sparc64 |  Bin 1593408 -> 1593408 bytes
 roms/openbios            |    2 +-
 4 files changed, 1 insertion(+), 1 deletion(-)
