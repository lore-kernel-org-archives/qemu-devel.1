Received: from eggs.gnu.org ([2001:4830:134:3::10]:57255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ciq52-0000Zk-5Z
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:17:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ciq4z-0004qc-1K
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:17:12 -0500
Received: from chuckie.co.uk ([82.165.15.123]:43661
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ciq4y-0004qL-Q2
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:17:08 -0500
Date: Tue, 28 Feb 2017 22:16:44 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20170228221644.GA30636@kentang.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL for-2.9] Update OpenBIOS images
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

Here are the OpenBIOS updates for QEMU 2.9. Please pull.


ATB,

Mark.


The following changes since commit e7c83a885f865128ae3cf1946f8cb538b63cbfba:

  vhost-user: delay vhost_user_stop (2017-02-28 19:11:15 +0000)

are available in the git repository at:

  https://github.com/mcayland/qemu.git tags/qemu-openbios-signed

for you to fetch changes up to 9b40d1ee130432c8d80bfabde85918f187b4ae32:

  Update OpenBIOS images to 0cd97cc built from submodule. (2017-02-28 21:50:03 +0000)

----------------------------------------------------------------
Update OpenBIOS images

----------------------------------------------------------------
Mark Cave-Ayland (1):
      Update OpenBIOS images to 0cd97cc built from submodule.

 pc-bios/openbios-ppc     |  Bin 750840 -> 750840 bytes
 pc-bios/openbios-sparc32 |  Bin 382048 -> 382048 bytes
 pc-bios/openbios-sparc64 |  Bin 1593408 -> 1593408 bytes
 roms/openbios            |    2 +-
 4 files changed, 1 insertion(+), 1 deletion(-)
