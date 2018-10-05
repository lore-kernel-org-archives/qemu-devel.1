Received: from eggs.gnu.org ([2001:4830:134:3::10]:39467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1g8Lpx-0002mO-5a
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 04:51:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1g8Lpt-0007w9-Vc
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 04:51:53 -0400
Received: from chuckie.co.uk ([82.165.15.123]:48576
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1g8Lpt-0007pV-NS
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 04:51:49 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri,  5 Oct 2018 09:51:31 +0100
Message-Id: <20181005085132.26394-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PULL 0/1] qemu-openbios.for-upstream queue 20181005
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org

The following changes since commit dafd95053611aa14dda40266857608d12ddce658:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-10-02 18:27:18 +0100)

are available in the git repository at:

  git://github.com/mcayland/qemu.git tags/qemu-openbios.for-upstream-20181005

for you to fetch changes up to 422d33b8c847fe1264099f93ec8ddb2e56772d4d:

  Update OpenBIOS images to 441a84d3 built from submodule. (2018-10-05 09:25:14 +0100)

----------------------------------------------------------------
qemu-openbios.for-upstream queue

----------------------------------------------------------------
Mark Cave-Ayland (1):
      Update OpenBIOS images to 441a84d3 built from submodule.

 pc-bios/openbios-ppc     | Bin 767224 -> 767224 bytes
 pc-bios/openbios-sparc32 | Bin 382048 -> 382048 bytes
 pc-bios/openbios-sparc64 | Bin 1593408 -> 1593408 bytes
 roms/openbios            |   2 +-
 4 files changed, 1 insertion(+), 1 deletion(-)
