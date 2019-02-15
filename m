Received: from eggs.gnu.org ([209.51.188.92]:32969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1guaps-0000qt-C0
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:35:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1guapp-0003IB-Uu
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:35:12 -0500
Received: from chuckie.co.uk ([82.165.15.123]:38932
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1guapo-0003BJ-IL
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:35:09 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 15 Feb 2019 10:34:52 +0000
Message-Id: <20190215103453.15821-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PULL 0/1] qemu-openbios queue 20190215
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org

The following changes since commit 0266c739abbed804deabb4ccde2aa449466ac3b4:

  Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-feb-14-2019' into staging (2019-02-14 18:33:00 +0000)

are available in the git repository at:

  git://github.com/mcayland/qemu.git tags/qemu-openbios-20190215

for you to fetch changes up to e9deadb1c10351213845428de7591931f790f111:

  Update OpenBIOS images to 3464681b built from submodule. (2019-02-15 10:07:40 +0000)

----------------------------------------------------------------
qemu-openbios queue

----------------------------------------------------------------
Mark Cave-Ayland (1):
      Update OpenBIOS images to 3464681b built from submodule.

 pc-bios/openbios-ppc     | Bin 767224 -> 767224 bytes
 pc-bios/openbios-sparc32 | Bin 382048 -> 382048 bytes
 pc-bios/openbios-sparc64 | Bin 1593408 -> 1593408 bytes
 roms/openbios            |   2 +-
 4 files changed, 1 insertion(+), 1 deletion(-)
