Received: from eggs.gnu.org ([2001:4830:134:3::10]:59009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gCOFv-0004DY-DD
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gCOFm-0007sa-Pa
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:15:21 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:38553 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gCOFm-000769-G9
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:15:14 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 16 Oct 2018 14:14:00 +0200
Message-Id: <1539692044-15732-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 0/4] target/mips: Add Ingenic's MXU ASE opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, jancraig@amazon.com, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

This series adds opcodes and accompanying comments for Ingenic's
MXU ASE.

Aleksandar Markovic (4):
  target/mips: Add basic description of MXU ASE
  target/mips: Add assembler mnemonics list for MXU ASE
  target/mips: Add organizational chart of MXU ASE
  target/mips: Add opcode values of MXU ASE

 target/mips/translate.c | 540 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 540 insertions(+)

-- 
2.7.4
