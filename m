Received: from eggs.gnu.org ([2001:4830:134:3::10]:32781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1gS08a-0007GI-N1
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 08:44:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1gS08Y-0002Kl-3P
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 08:44:20 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:39515 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1gS08X-0001xk-Qv
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 08:44:18 -0500
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Wed, 28 Nov 2018 14:43:08 +0100
Message-Id: <1543412590-29716-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 0/2] qemu-doc: Update MIPS/nanoMIPS info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, peter.maydell@linaro.org, huth@tuxfamily.org, hpoussin@reactos.org, pburton@wavecomp.com, jhogan@kernel.org

From: Stefan Markovic <smarkovic@wavecomp.com>

Update QEMU documentation with nanoMIPS ISA info and add list of QEMU
supported MIPS/nanoMIPS CPU models.

Stefan Markovic (2):
  qemu-doc: Add nanoMIPS ISA information
  docs/qemu-cpu-models: Add MIPS/nanoMIPS QEMU supported CPU models

 docs/qemu-cpu-models.texi | 163 +++++++++++++++++++++++++++++++++++++++++++++-
 qemu-doc.texi             |  29 +++++++++
 2 files changed, 190 insertions(+), 2 deletions(-)

-- 
1.9.1
