Received: from eggs.gnu.org ([2001:4830:134:3::10]:45547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fgBjr-0008V6-KG
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fgBjl-0003uw-PM
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:25:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36108 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fgBjl-0003uN-JT
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:25:05 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 19 Jul 2018 17:25:00 +0100
Message-Id: <20180719162501.32641-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-3.0 0/1] Tracing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The following changes since commit ea6abffa8a08d832feb759d359d5b935e3087cf7:

  Update version for v3.0.0-rc1 release (2018-07-17 18:15:19 +0100)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to db817b8c500a60873eba80cbf047900ae5b32766:

  tracing: Use double-dash spelling for trace option (2018-07-19 13:09:04 +0100)

----------------------------------------------------------------
Pull request

Contains a fix to use double-dash consistently with tracing command-line
options in documentation and output.

----------------------------------------------------------------

Yaowei Bai (1):
  tracing: Use double-dash spelling for trace option

 docs/devel/tracing.txt | 6 +++---
 trace/control.h        | 4 ++--
 trace/control.c        | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.17.1
