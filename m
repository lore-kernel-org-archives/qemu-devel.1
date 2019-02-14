Received: from eggs.gnu.org ([209.51.188.92]:43369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gu8im-0005dT-Ka
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:34:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gu8il-0003UE-Kc
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:34:00 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 14 Feb 2019 12:33:21 +0800
Message-Id: <20190214043322.2354-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
Cc: Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

The following changes since commit 0b5e750bea635b167eb03d86c3d9a09bbd43bc=
06:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2019-02-12 10:53:37 +0000)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 42824b4d16da56a50ff4027f6cd22378e0e2666e:

  virtio-blk: set correct config size for the host driver (2019-02-13 16:=
18:17 +0800)

----------------------------------------------------------------
Pull request

Fix a virtio-blk migration regression.

----------------------------------------------------------------

Changpeng Liu (1):
  virtio-blk: set correct config size for the host driver

 hw/block/virtio-blk.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--=20
2.20.1
