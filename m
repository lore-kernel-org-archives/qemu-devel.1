Received: from eggs.gnu.org ([209.51.188.92]:41910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fam@euphon.net>) id 1gh342-00024L-Ak
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 20:53:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fam@euphon.net>) id 1gh340-0005yE-6D
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 20:53:50 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17773
	helo=sender1.zoho.com.cn) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fam@euphon.net>) id 1gh33z-0005jD-RH
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 20:53:48 -0500
From: Fam Zheng <fam@euphon.net>
Message-ID: <20190109015240.2116-1-fam@euphon.net>
Date: Wed,  9 Jan 2019 09:52:38 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Block/testing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Fam Zheng <fam@euphon.net>

The following changes since commit 147923b1a901a0370f83a0f4c58ec1baffef22f0=
:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20190108-pull-reque=
st' into staging (2019-01-08 16:07:32 +0000)

are available in the git repository at:

  https://github.com/famz/qemu.git tags/staging-pull-request

for you to fetch changes up to 4ce58d861bf740bb893bd28b974675ad3d9f98b5:

  docker: Use a stable snapshot for Debian Sid (2019-01-09 09:38:34 +0800)

----------------------------------------------------------------
Block/testing patches

v2: Fix URL.
    Drop BSD patch.

----------------------------------------------------------------

Li Feng (1):
  block/nvme: optimize the performance of nvme driver based on vfio-pci

Philippe Mathieu-Daud=C3=A9 (1):
  docker: Use a stable snapshot for Debian Sid

 block/nvme.c                               | 16 ++++++----------
 tests/docker/dockerfiles/debian-sid.docker |  4 ++++
 2 files changed, 10 insertions(+), 10 deletions(-)

--=20
2.11.0
