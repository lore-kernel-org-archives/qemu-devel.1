Received: from eggs.gnu.org ([208.118.235.92]:46619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcCmT-0006dX-P1
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:15:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcCmP-0004lX-H3
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:15:41 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:39303 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gcCmP-0004jh-6k
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:15:37 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 26 Dec 2018 18:15:10 +0100
Message-Id: <1545844514-1854-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 0/4] MAINTAINERS: Clean up MIPS sections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, pburton@wavecomp.com, hpoussin@reactos.org, jhogan@kernel.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Clean up main target/mips section. Add some new files, add email
filter, and reorder items. Also, add Aleksandar Rikalo as a reviewer
for all MIPS content.

v2->v3:

  - add patch on new MIPS reviewer Aleksandar Rikalo

v1->v2:

  - fixed typo in a commit message
  - removed unnecessary "?" in a line for filtering email subjects

Aleksandar Markovic (4):
  MAINTAINERS: target/mips: Add MIPS files under default-configs
    directory
  MAINTAINERS: target/mips: Add filter for mips in email subjects
  MAINTAINERS: target/mips: Reorder items alphabetically
  MAINTAINERS: Add Aleksandar Rikalo as a reviewer for MIPS content

 MAINTAINERS | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

-- 
2.7.4
