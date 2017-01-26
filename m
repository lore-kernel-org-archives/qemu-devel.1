Received: from eggs.gnu.org ([2001:4830:134:3::10]:45890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWh9u-0002Q3-9l
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:20:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWh9p-0006Ol-GT
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:20:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cWh9p-0006Oa-BK
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:19:57 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 26 Jan 2017 10:19:53 +0000
Message-Id: <20170126101954.21236-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] Block patches
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

The following changes since commit c7f1cf01b8245762ca5864e835d84f6677ae8b1f:

  Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into staging (2017-01-25 17:54:14 +0000)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 59c9f437c59a4bf0594ed300d28fb24c645963a5:

  aio-posix: honor is_external in AioContext polling (2017-01-26 10:02:33 +0000)

----------------------------------------------------------------

----------------------------------------------------------------

Stefan Hajnoczi (1):
  aio-posix: honor is_external in AioContext polling

 aio-posix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.9.3
