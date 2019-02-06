Received: from eggs.gnu.org ([209.51.188.92]:50022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1grOex-0007Q3-BC
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 09:58:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1grOew-00007z-Ed
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 09:58:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1grOew-0008SP-5t
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 09:58:42 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  6 Feb 2019 15:58:30 +0100
Message-Id: <20190206145831.656-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/1] Dump patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, peter.maydell@linaro.org

The following changes since commit 47994e16b1d66411953623e7c0bf0cdcd50bd5=
07:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
90205' into staging (2019-02-05 18:25:07 +0000)

are available in the Git repository at:

  https://github.com/elmarco/qemu.git tags/dump-pull-request

for you to fetch changes up to e17bebd049d78f489c2cff755e2b66a0536a156e:

  dump: Set correct vaddr for ELF dump (2019-02-06 15:51:12 +0100)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Jon Doron (1):
  dump: Set correct vaddr for ELF dump

 scripts/dump-guest-memory.py | 1 +
 dump.c                       | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

--=20
2.20.1.98.gecbdaf0899
