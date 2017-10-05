Received: from eggs.gnu.org ([2001:4830:134:3::10]:37180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e0767-0003c1-7Q
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:26:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e0763-00059o-9b
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:25:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1e0763-00058x-4M
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:25:55 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu,  5 Oct 2017 10:25:46 -0400
Message-Id: <20171005142547.1363-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] Tracing patches
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

The following changes since commit 5456c6a4ec9cd8fc314ddc303e88bf85c110975c:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2017-10-05 12:02:21 +0100)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to 45042732f39ecd42794c256bf98f231e58849c3e:

  checkpatch: fix incompatibility with old perl (2017-10-05 10:22:44 -0400)

----------------------------------------------------------------

----------------------------------------------------------------

Vladimir Sementsov-Ogievskiy (1):
  checkpatch: fix incompatibility with old perl

 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.13.6
