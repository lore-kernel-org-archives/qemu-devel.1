Received: from eggs.gnu.org ([2001:4830:134:3::10]:51311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gC0TW-0007Hv-Om
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 06:51:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gC0TS-00011Q-UF
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 06:51:50 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:35258 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gC0TR-0000Na-49
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 06:51:46 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 15 Oct 2018 12:50:30 +0200
Message-Id: <1539600633-17726-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 0/3] target/mips: Add two CP0 related comments
 and update mailmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

This series contains three cosmetic changes that do not affect any
QEMU feature, but are still hopefully helpful for development.

Aleksandar Markovic (3):
  target/mips: Add a comment with an overview of CP0 registers
  target/mips: Add a comment before each CP0 register section in cpu.h
  mailmap: Add an item for Yongbok Kim

 .mailmap          |   1 +
 target/mips/cpu.h | 197 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 198 insertions(+)

-- 
2.7.4
