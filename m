Received: from eggs.gnu.org ([2001:4830:134:3::10]:53819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fT79t-0006c5-RM
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:54:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fT79s-0005c3-WB
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:54:01 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 13 Jun 2018 10:53:50 -0400
Message-Id: <20180613145351.414-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

The following changes since commit 2ab09bf2f9f55b9fb8d2de6eb2ba2a8570e268e2:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20180612-pull-request' into staging (2018-06-12 15:34:34 +0100)

are available in the git repository at:

  git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request

for you to fetch changes up to b61acdecbf19c3c5a327baec1e8e4c06d0da68b7:

  block: Ignore generated job QAPI files (2018-06-13 10:51:49 -0400)

----------------------------------------------------------------
Block patch for .gitignore
----------------------------------------------------------------

Eric Blake (1):
  block: Ignore generated job QAPI files

 .gitignore | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.13.6
