Received: from eggs.gnu.org ([2001:4830:134:3::10]:55573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dORBK-0003KO-QD
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dORBF-0002a2-O6
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:11:38 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 23 Jun 2017 13:11:19 -0300
Message-Id: <20170623161121.8047-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/2] hw/unimp: add MAINTAINERS entry and
 missing include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

I separated these patches from the previous series "various easy cleanups".

Add an entry in MAINTAINERS for the "Unimplemented" device, voluntary myself as
reviewer, fix a missing include.

Regards,

Phil.

Philippe Mathieu-Daudé (2):
  hw/unimp: add missing include
  MAINTAINERS: add entry for "Unimplemented" device

 MAINTAINERS             | 7 +++++++
 include/hw/misc/unimp.h | 2 ++
 2 files changed, 9 insertions(+)

-- 
2.13.1
