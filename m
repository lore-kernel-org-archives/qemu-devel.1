Received: from eggs.gnu.org ([2001:4830:134:3::10]:47609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLta8-0007Rd-WD
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:54:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLta8-0001gH-9z
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:54:45 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 16 Jun 2017 17:54:32 +0200
Message-Id: <1497628474-13275-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH RESEND v3 0/2] -blockdev documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

This series was posted as part of my -blockdev prototype implementation back in
September 2016 and already received review. When Markus merged his final
implementation of -blockdev, no real documentation was added, so even though my
implementation isn't needed any more, we still need these doc patches.

There is nothing new in here, I'm only reposting the series to notify everyone
that I'm including the patches in my block tree now.

Kevin Wolf (2):
  doc: Document generic -blockdev options
  doc: Document driver-specific -blockdev options

 qemu-options.hx | 221 ++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 192 insertions(+), 29 deletions(-)

-- 
1.8.3.1
