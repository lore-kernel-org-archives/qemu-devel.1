Received: from eggs.gnu.org ([2001:4830:134:3::10]:42723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d1om9-0001ap-NG
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 02:44:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d1om6-0001EI-Ls
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 02:44:09 -0400
Received: from chuckie.co.uk ([82.165.15.123]:53360
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1d1om6-0001E2-EC
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 02:44:06 -0400
Date: Sat, 22 Apr 2017 07:43:36 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20170422064336.GB15974@kentang.lan>
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
To: peter.maydell@linaro.org, qemu-devel@nongnu.org

Hi Peter,

Here are updated images for OpenBIOS containing the latest set of stable fixes.
Please pull.


ATB,

Mark.
 

The following changes since commit da92ada855036c55bd08b0b0c64c7551d56f3586:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170420' into staging (2017-04-20 17:41:34 +0100)

are available in the git repository at:


  https://github.com/mcayland/qemu.git tags/qemu-openbios-signed

for you to fetch changes up to e0a31457e1b3aeb6222d2433b7415ac94887fdcf:

  Update OpenBIOS images to 04898e8 built from submodule. (2017-04-22 07:27:20 +0100)

----------------------------------------------------------------
Update OpenBIOS images

----------------------------------------------------------------
Mark Cave-Ayland (1):
      Update OpenBIOS images to 04898e8 built from submodule.

 pc-bios/openbios-ppc     |  Bin 750840 -> 750840 bytes
 pc-bios/openbios-sparc32 |  Bin 382048 -> 382048 bytes
 pc-bios/openbios-sparc64 |  Bin 1593408 -> 1593408 bytes
 roms/openbios            |    2 +-
 4 files changed, 1 insertion(+), 1 deletion(-)
