Received: from eggs.gnu.org ([2001:4830:134:3::10]:44611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dBkVg-0004n7-Fu
	for qemu-devel@nongnu.org; Fri, 19 May 2017 12:12:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dBkVc-0007z6-DE
	for qemu-devel@nongnu.org; Fri, 19 May 2017 12:12:12 -0400
Received: from chuckie.co.uk ([82.165.15.123]:59759
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dBkVc-0007yr-6Q
	for qemu-devel@nongnu.org; Fri, 19 May 2017 12:12:08 -0400
Date: Fri, 19 May 2017 17:11:56 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20170519161156.GB6895@kentang.lan>
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
To: stefanha@gmail.com, qemu-devel@nongnu.org

Hi Stefan,

This update contains the OpenBIOS VGA driver updates required to enable Ben's QemuMacDrivers
for Mac guests. Please pull.


ATB,

Mark.


The following changes since commit 56821559f0ba682fe6b367815572e6f974d329ab:

  Merge remote-tracking branch 'dgilbert/tags/pull-hmp-20170517' into staging (2017-05-18 13:36:15 +0100)

are available in the git repository at:


  https://github.com/mcayland/qemu.git tags/qemu-openbios-signed

for you to fetch changes up to 415c3824836d3b65a5796a81b17fccd1ad575ff8:

  Update OpenBIOS images to 3ebaaa2 built from submodule. (2017-05-19 16:52:40 +0100)

----------------------------------------------------------------
Update OpenBIOS images

----------------------------------------------------------------
Mark Cave-Ayland (1):
      Update OpenBIOS images to 3ebaaa2 built from submodule.

 pc-bios/openbios-ppc     |  Bin 750840 -> 750840 bytes
 pc-bios/openbios-sparc32 |  Bin 382048 -> 382048 bytes
 pc-bios/openbios-sparc64 |  Bin 1593408 -> 1593408 bytes
 roms/openbios            |    2 +-
 4 files changed, 1 insertion(+), 1 deletion(-)
