Received: from eggs.gnu.org ([2001:4830:134:3::10]:52156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eomAd-0004ZM-SV
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 03:24:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eomAa-0005Mt-Mw
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 03:24:03 -0500
Received: from chuckie.co.uk ([82.165.15.123]:46659
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eomAa-00057e-Eh
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 03:24:00 -0500
Date: Thu, 22 Feb 2018 08:23:41 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20180222082341.sk2pkai7kf5kurfh@kentang.home>
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

This update for OpenBIOS contains a single fix which allows yaboot 1.3.17 to boot
under qemu-system-ppc. Please pull.


ATB,

Mark.


The following changes since commit a6e0344fa0e09413324835ae122c4cadd7890231:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180220-pull-request' into staging (2018-02-20 14:05:00 +0000)

are available in the git repository at:

  https://github.com/mcayland/qemu.git tags/qemu-openbios-signed

for you to fetch changes up to feb3174ff27f94d34247952d9779f09e9b1dfd39:

  Update OpenBIOS images to 54d959d9 built from submodule. (2018-02-22 07:55:47 +0000)

----------------------------------------------------------------
Update OpenBIOS images

----------------------------------------------------------------
Mark Cave-Ayland (1):
      Update OpenBIOS images to 54d959d9 built from submodule.

 pc-bios/openbios-ppc     | Bin 754936 -> 754936 bytes
 pc-bios/openbios-sparc32 | Bin 382048 -> 382048 bytes
 pc-bios/openbios-sparc64 | Bin 1593408 -> 1593408 bytes
 roms/openbios            |   2 +-
 4 files changed, 1 insertion(+), 1 deletion(-)
