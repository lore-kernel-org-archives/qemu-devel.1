Received: from eggs.gnu.org ([2001:4830:134:3::10]:49328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eezoE-00081n-CK
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 03:56:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eezoB-0003qb-B8
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 03:56:30 -0500
Received: from chuckie.co.uk ([82.165.15.123]:58551
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eezoB-0003n2-4C
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 03:56:27 -0500
Date: Fri, 26 Jan 2018 08:16:47 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20180126081647.72sxtshbfbfrb426@kentang.home>
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

Here are the latest OpenBIOS updates (mainly the power support for SPARC). Please pull.


ATB,

Mark.


The following changes since commit 2077fef91d5eb8e3745a84fabd87a5ee7d2b535d:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180125' into staging (2018-01-25 17:04:47 +0000)

are available in the git repository at:

  https://github.com/mcayland/qemu.git tags/qemu-openbios-signed

for you to fetch changes up to bbb596054e480ee30c248ff5b2bf8a1f2a205454:

  Update OpenBIOS images to b5c93acd14 built from submodule. (2018-01-26 07:59:25 +0000)

----------------------------------------------------------------
Update OpenBIOS images

----------------------------------------------------------------
Mark Cave-Ayland (1):
      Update OpenBIOS images to b5c93acd14 built from submodule.

 pc-bios/openbios-ppc     | Bin 754936 -> 754936 bytes
 pc-bios/openbios-sparc32 | Bin 382048 -> 382048 bytes
 pc-bios/openbios-sparc64 | Bin 1593408 -> 1593408 bytes
 roms/openbios            |   2 +-
 4 files changed, 1 insertion(+), 1 deletion(-)
