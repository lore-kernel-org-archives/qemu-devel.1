Received: from eggs.gnu.org ([2001:4830:134:3::10]:60583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1defxF-00067I-3u
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 07:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1defxA-0005wj-AD
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 07:12:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15611)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1defxA-0005uO-3p
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 07:12:08 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon,  7 Aug 2017 12:04:06 +0100
Message-Id: <20170807110407.15511-1-stefanha@redhat.com>
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

The following changes since commit ac44ed2afb7c60255e989b163301479f5b4ecd04:

  Merge remote-tracking branch 'remotes/ehabkost/tags/machine-pull-request' into staging (2017-08-04 13:46:22 +0100)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to f42cf447e2310e84e119b99f7f13c8dc7a6cf3d6:

  block: move trace probes into bdrv_co_preadv|pwritev (2017-08-07 09:39:35 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Daniel P. Berrange (1):
  block: move trace probes into bdrv_co_preadv|pwritev

 block/io.c         | 8 ++++----
 block/trace-events | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.13.3
