Received: from eggs.gnu.org ([2001:4830:134:3::10]:54801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eOzQy-0007uq-Vi
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 00:18:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eOzQu-0004LN-29
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 00:18:20 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 02:17:32 -0300
Message-Id: <20171213051736.17755-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/4] Trivial changes in "registerfields.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>

Philippe Mathieu-Daudé (4):
  MAINTAINERS: add "hw/registerfields.h" in Register API entry
  hw/registerfields: fix a typo in the FIELD() documentation
  hw/registerfields: add 64-bit extract/deposit macros
  hw/registerfields: add missing include

 include/hw/registerfields.h | 15 ++++++++++++++-
 MAINTAINERS                 |  1 +
 2 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.15.1
