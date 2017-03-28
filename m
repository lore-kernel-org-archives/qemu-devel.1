Received: from eggs.gnu.org ([2001:4830:134:3::10]:60250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cso26-0004Cx-Rk
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 06:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cso22-0002wT-25
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 06:07:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cso21-0002vX-S6
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 06:07:17 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 28 Mar 2017 11:07:12 +0100
Message-Id: <20170328100713.28785-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 0/1] Block patches
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

The following changes since commit eb06c9e2d3c8f026a206e8402b0ffa201060ec8e:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-03-27 17:34:50 +0100)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to dc62da88b5d17477227a3563a6ad466129d416d6:

  parallels: wrong call to bdrv_truncate (2017-03-28 11:06:00 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Denis V. Lunev (1):
  parallels: wrong call to bdrv_truncate

 block/parallels.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.9.3
