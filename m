Received: from eggs.gnu.org ([2001:4830:134:3::10]:45092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gZj72-0002ua-8V
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 16:10:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gZj6y-0006Bo-Rr
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 16:10:40 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:50369 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gZj6y-000665-IK
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 16:10:36 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 19 Dec 2018 22:10:19 +0100
Message-Id: <20181219211022.5379-1-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 0/3] MAINTAINERS: Clean up main target/mips
 section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, smarkovic@wavecomp.com, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Clean up main target/mips section. Add some new files, add email
filter, and reorder items.

v1->v2:
  - fixed typo in a commit message
  - removed unnecessary "?" in a line for filtering email subjects

Aleksandar Markovic (3):
  MAINTAINERS: target/mips: Add MIPS files under default-configs
    directory
  MAINTAINERS: target/mips: Add filter for mips in email subjects
  MAINTAINERS: target/mips: Reorder items alphabetically

 MAINTAINERS | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

-- 
2.17.1
