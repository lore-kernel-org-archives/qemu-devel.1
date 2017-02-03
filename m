Received: from eggs.gnu.org ([2001:4830:134:3::10]:44232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cZezv-0006yy-OX
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 09:38:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cZezs-0002Hh-Kd
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 09:37:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cZezs-0002Gf-Ep
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 09:37:56 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  3 Feb 2017 14:37:52 +0000
Message-Id: <20170203143753.9903-1-stefanha@redhat.com>
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

The following changes since commit 4100a344eb3d50d88f9da85cae334afc47aee134:

  Merge remote-tracking branch 'remotes/sstabellini/tags/xen-20170202' into staging (2017-02-03 12:31:40 +0000)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to cdd7abfdba9287a289c404dfdcb02316f9ffee7d:

  iothread: enable AioContext polling by default (2017-02-03 14:23:38 +0000)

----------------------------------------------------------------

----------------------------------------------------------------

Stefan Hajnoczi (1):
  iothread: enable AioContext polling by default

 iothread.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

-- 
2.9.3
