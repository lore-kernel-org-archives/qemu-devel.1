Received: from eggs.gnu.org ([2001:4830:134:3::10]:58528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fUz9C-0006Uu-4H
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:45:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fUz98-0006g8-WE
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:45:02 -0400
Received: from chuckie.co.uk ([82.165.15.123]:45240
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fUz98-0006fk-PG
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:44:58 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Mon, 18 Jun 2018 19:44:48 +0100
Message-Id: <20180618184448.13592-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PULL] qemu-openbios queue 20180618
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org

The following changes since commit 2ef2f16781af9dee6ba6517755e9073ba5799fa2:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20180615a' into staging (2018-06-15 18:13:35 +0100)

are available in the git repository at:

  git://github.com/mcayland/qemu.git tags/qemu-openbios-20180618

for you to fetch changes up to 5b20e4cacecb62fb2bdc6867c11d44cddd77c4ff:

  Update OpenBIOS images to 8fe6f5f96f built from submodule. (2018-06-18 19:22:16 +0100)

----------------------------------------------------------------
qemu-openbios queue

----------------------------------------------------------------
Mark Cave-Ayland (1):
      Update OpenBIOS images to 8fe6f5f96f built from submodule.

 pc-bios/openbios-ppc     | Bin 754936 -> 763128 bytes
 pc-bios/openbios-sparc32 | Bin 382048 -> 382048 bytes
 pc-bios/openbios-sparc64 | Bin 1593408 -> 1593408 bytes
 roms/openbios            |   2 +-
 4 files changed, 1 insertion(+), 1 deletion(-)
