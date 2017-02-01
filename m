Received: from eggs.gnu.org ([2001:4830:134:3::10]:41229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYuuG-0001rJ-Iy
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:25:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYuuC-00082d-JJ
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:25:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cYuuC-00082U-DW
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:25:00 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  1 Feb 2017 13:24:55 +0000
Message-Id: <20170201132456.11406-1-stefanha@redhat.com>
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

The following changes since commit a0def594286d9110a6035e02eef558cf3cf5d847:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-01-30 10:23:20 +0000)

are available in the git repository at:

  git://github.com/stefanha/qemu.git block-pull-request

for you to fetch changes up to 81a9f2cb9336a7e9f50b0729b4c81d287e0015e9:

  iothread: enable AioContext polling by default (2017-01-31 17:09:34 +0000)

----------------------------------------------------------------

----------------------------------------------------------------

Stefan Hajnoczi (1):
  iothread: enable AioContext polling by default

 iothread.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

-- 
2.9.3
