Received: from eggs.gnu.org ([2001:4830:134:3::10]:45957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dGoaA-0003EX-Kq
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:33:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dGoa9-0001AS-Sh
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:33:46 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Fri,  2 Jun 2017 11:33:35 -0400
Message-Id: <20170602153336.18951-1-jcody@redhat.com>
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
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com

The following changes since commit d47a851caeda96d5979bf48d4bae6a87784ad91d:

  Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20170601' into staging (2017-06-02 14:07:53 +0100)

are available in the git repository at:

  git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request

for you to fetch changes up to df3a429ae82c0f45becdfab105617701d75e0f05:

  gluster: add support for PREALLOC_MODE_FALLOC (2017-06-02 10:51:47 -0400)

----------------------------------------------------------------
Gluster patch(es)
----------------------------------------------------------------

Niels de Vos (1):
  gluster: add support for PREALLOC_MODE_FALLOC

 block/gluster.c | 78 ++++++++++++++++++++++++++++++---------------------------
 configure       |  6 +++++
 2 files changed, 47 insertions(+), 37 deletions(-)

-- 
2.9.3
