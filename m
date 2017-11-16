Received: from eggs.gnu.org ([2001:4830:134:3::10]:60158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eFN9K-0002w3-P8
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:36:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eFN9G-00060b-Df
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:36:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eFN9G-00060J-75
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:36:18 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 16 Nov 2017 16:36:13 +0000
Message-Id: <20171116163614.24710-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.11 0/1] Block patches
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

The following changes since commit 8048082f7a11040a366942a2de8abb4c3d0020c9:

  Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2017-11-15-1' into staging (2017-11-16 11:34:24 +0000)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 341e0b5658681f46680024cdbfc998717d85cc35:

  throttle-groups: forget timer and schedule next TGM on detach (2017-11-16 14:12:57 +0000)

----------------------------------------------------------------

----------------------------------------------------------------

Stefan Hajnoczi (1):
  throttle-groups: forget timer and schedule next TGM on detach

 block/throttle-groups.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
2.13.6
