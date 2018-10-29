Received: from eggs.gnu.org ([2001:4830:134:3::10]:37628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gH821-0003F5-NI
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gH81w-0003A5-7J
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:56:33 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 29 Oct 2018 13:56:05 +0000
Message-Id: <20181029135607.4485-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>

The following changes since commit 285278ca785f5fa9a570927e1c0958a2ca2b2150:

  Merge remote-tracking branch 'remotes/famz/tags/testing-pull-request' into staging (2018-10-27 19:55:08 +0100)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to bd54b11062c4baa7d2e4efadcf71b8cfd55311fd:

  nvdimm: Add docs hint for Linux driver name (2018-10-29 13:35:22 +0000)

----------------------------------------------------------------
Pull request

No changelog-worthy entries, just small tweaks.

----------------------------------------------------------------

Kees Cook (1):
  nvdimm: Add docs hint for Linux driver name

Li Qiang (1):
  util: aio-posix: fix a typo

 docs/nvdimm.txt  | 5 +++--
 util/aio-posix.c | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.17.2
