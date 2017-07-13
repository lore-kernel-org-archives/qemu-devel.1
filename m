Received: from eggs.gnu.org ([2001:4830:134:3::10]:35123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dVjY8-0001F4-Hu
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 15:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dVjY4-0000Xq-BW
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 15:13:20 -0400
Received: from chuckie.co.uk ([82.165.15.123]:39912
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dVjY4-0000O7-58
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 15:13:16 -0400
Date: Thu, 13 Jul 2017 20:12:52 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20170713191252.GB20141@kentang.lan>
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

Here are the latest set of updates for OpenBIOS. Please pull.


ATB,

Mark.


The following changes since commit 49bcce4b9c11759678fd223aefb48691c4959d4f:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-07-12' into staging (2017-07-13 16:56:06 +0100)

are available in the git repository at:


  https://github.com/mcayland/qemu.git tags/qemu-openbios-signed

for you to fetch changes up to abcea034a05e617866d456bf6afc4c4d4ea26151:

  Update OpenBIOS images to fbc1b4a built from submodule. (2017-07-13 19:44:45 +0100)

----------------------------------------------------------------
Update OpenBIOS images

----------------------------------------------------------------
Mark Cave-Ayland (1):
      Update OpenBIOS images to fbc1b4a built from submodule.

 pc-bios/openbios-ppc     |  Bin 750840 -> 754936 bytes
 pc-bios/openbios-sparc32 |  Bin 382048 -> 382048 bytes
 pc-bios/openbios-sparc64 |  Bin 1593408 -> 1593408 bytes
 roms/openbios            |    2 +-
 4 files changed, 1 insertion(+), 1 deletion(-)
