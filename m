Received: from eggs.gnu.org ([209.51.188.92]:51831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hLvn0-0003eo-NN
	for qemu-devel@nongnu.org; Wed, 01 May 2019 16:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hLvmz-00018U-Pd
	for qemu-devel@nongnu.org; Wed, 01 May 2019 16:25:14 -0400
From: John Snow <jsnow@redhat.com>
Date: Wed,  1 May 2019 16:25:04 -0400
Message-Id: <20190501202506.13875-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Bitmaps patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org, qemu-block@nongnu.org, qemu-stable@nongnu.org

The following changes since commit 46316f1dfffc6be72e94e89f7b0e9162e7dcdc=
f1:

  Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-201903=
11.0' into staging (2019-03-12 13:37:29 +0000)

are available in the Git repository at:

  https://github.com/jnsnow/qemu.git tags/bitmaps-pull-request

for you to fetch changes up to 90edef80a0852cf8a3d2668898ee40e8970e4314:

  docs/interop/bitmaps: rewrite and modernize doc (2019-05-01 16:21:24 -0=
400)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

John Snow (2):
  Makefile: add nit-picky mode to sphinx-build
  docs/interop/bitmaps: rewrite and modernize doc

 docs/interop/bitmaps.rst | 1599 ++++++++++++++++++++++++++++++--------
 Makefile                 |    2 +-
 2 files changed, 1265 insertions(+), 336 deletions(-)

--=20
2.20.1
