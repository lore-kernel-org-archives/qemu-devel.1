Received: from eggs.gnu.org ([2001:4830:134:3::10]:57656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fvhfX-0006tu-Ub
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 07:32:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fvhfV-00026p-9p
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 07:32:51 -0400
Received: from chuckie.co.uk ([82.165.15.123]:42763
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fvhfV-0001zg-1Z
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 07:32:49 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 31 Aug 2018 12:32:32 +0100
Message-Id: <20180831113233.22997-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PULL 0/1] qemu-openbios.for-upstream queue 20180831
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org

The following changes since commit 19b599f7664b2ebfd0f405fb79c14dd241557452:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-08-27-v2' into staging (2018-08-27 16:44:20 +0100)

are available in the git repository at:

  git://github.com/mcayland/qemu.git tags/qemu-openbios.for-upstream-20180831

for you to fetch changes up to 09d0c187aa4cce9b349f23724f50587a0014b33b:

  Update OpenBIOS images to a1280807 built from submodule. (2018-08-31 12:19:30 +0100)

----------------------------------------------------------------
qemu-openbios.for-upstream queue

----------------------------------------------------------------
Mark Cave-Ayland (1):
      Update OpenBIOS images to a1280807 built from submodule.

 pc-bios/openbios-ppc     | Bin 763128 -> 767224 bytes
 pc-bios/openbios-sparc32 | Bin 382048 -> 382048 bytes
 pc-bios/openbios-sparc64 | Bin 1593408 -> 1593408 bytes
 roms/openbios            |   2 +-
 4 files changed, 1 insertion(+), 1 deletion(-)
