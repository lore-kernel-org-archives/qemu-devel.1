Received: from eggs.gnu.org ([2001:4830:134:3::10]:38833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1drIxr-00053Y-5r
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 03:17:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1drIxo-0007jp-1b
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 03:17:03 -0400
Received: from chuckie.co.uk ([82.165.15.123]:35432
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1drIxn-0007ic-Rj
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 03:16:59 -0400
Date: Mon, 11 Sep 2017 08:12:42 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20170911071242.GB16807@kentang.lan>
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

Here are the first set of OpenBIOS updates for 2.11. Please pull.


ATB,

Mark.


The following changes since commit fcea73709b966a7ded9efa7b106ea50c7fe9025c:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-09-08 16:04:42 +0100)

are available in the git repository at:


  https://github.com/mcayland/qemu.git tags/qemu-openbios-signed

for you to fetch changes up to 8722a719dea27818cb02709f3f72c2f9a996dadf:

  Update OpenBIOS images to 314d4f8 built from submodule. (2017-09-11 07:43:34 +0100)

----------------------------------------------------------------
Update OpenBIOS images

----------------------------------------------------------------
Mark Cave-Ayland (1):
      Update OpenBIOS images to 314d4f8 built from submodule.

 pc-bios/openbios-ppc     |  Bin 754936 -> 754936 bytes
 pc-bios/openbios-sparc32 |  Bin 382048 -> 382048 bytes
 pc-bios/openbios-sparc64 |  Bin 1593408 -> 1593408 bytes
 roms/openbios            |    2 +-
 4 files changed, 1 insertion(+), 1 deletion(-)
