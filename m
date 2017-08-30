Received: from eggs.gnu.org ([2001:4830:134:3::10]:48691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnAxc-00059w-Sv
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 17:55:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnAxb-0007U1-WE
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 17:55:44 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 30 Aug 2017 18:55:06 -0300
Message-Id: <20170830215523.25278-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 00/17] add missing entries in MAINTAINERS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Hi,

I tried to have a more helpful ./scripts/get_maintainer.pl output, filling
missing entries in MAINTAINERS.

Regards,

Phil.

v2:
- add R-b & A-b
- clean ARM entries (Thomas Huth)
- moved files: comment since which commit (Eric Blake)
- drop inconsistent patches (default-configs.mak related to hw/machine, no CPU)
- drop unhappy patches (include/standard-headers/linux/*)
- drop unreplied patches

Philippe Mathieu-Daudé (17):
  MAINTAINERS: add missing ARM entries
  MAINTAINERS: add missing Versatile PB entry
  MAINTAINERS: add missing STM32 entry
  MAINTAINERS: add missing entry for vhost
  MAINTAINERS: add missing VMWare entry
  MAINTAINERS: add missing Guest Agent entries
  MAINTAINERS: add missing qcow2 entry
  MAINTAINERS: add missing USB entry
  MAINTAINERS: add missing PCI entries
  MAINTAINERS: add missing SSI entries
  MAINTAINERS: add missing entries for throttling infra
  MAINTAINERS: add missing megasas test entry
  MAINTAINERS: add missing AIO entry
  MAINTAINERS: add missing entry for Generic Loader
  MAINTAINERS: add missing Cryptography entry
  MAINTAINERS: update docs/devel/ entries
  MAINTAINERS: update docs/interop/ entries

 MAINTAINERS | 44 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

-- 
2.14.1
