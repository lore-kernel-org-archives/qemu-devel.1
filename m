Received: from eggs.gnu.org ([2001:4830:134:3::10]:54979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEYr3-0002pF-4H
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 07:58:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEYqy-0006CR-UK
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 07:58:40 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:43818 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gEYqy-0005Rg-LY
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 07:58:36 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 22 Oct 2018 13:57:23 +0200
Message-Id: <1540209445-28831-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 0/2] target/mips: Two corrections
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

This small series adds two corrections for issues reported recently.

Aleksandar Markovic (2):
  target/mips: Fix the title of translate.c
  target/mips: Fix decoding of ALIGN and DALIGN instructions

 target/mips/translate.c | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

-- 
2.7.4
