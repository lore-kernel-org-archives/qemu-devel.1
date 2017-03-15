Received: from eggs.gnu.org ([2001:4830:134:3::10]:47197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1co19U-0003nS-Gr
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 01:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1co19R-00078C-Cm
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 01:07:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1co19R-00077y-7N
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 01:07:09 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 15 Mar 2017 13:06:01 +0800
Message-Id: <20170315050602.7750-1-stefanha@redhat.com>
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

The following changes since commit d84f714eafedd8bb9d4aaec8b76417bef8e3535e:

  Update version for v2.9.0-rc0 release (2017-03-14 19:18:23 +0000)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 9dc44aa5829eb3131a01378a738dee28a382bbc1:

  os: don't corrupt pre-existing memory-backend data with prealloc (2017-03-15 11:55:41 +0800)

----------------------------------------------------------------

----------------------------------------------------------------

Daniel P. Berrange (1):
  os: don't corrupt pre-existing memory-backend data with prealloc

 util/oslib-posix.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

-- 
2.9.3
