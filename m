Received: from eggs.gnu.org ([2001:4830:134:3::10]:38298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eczN1-0005y6-Di
	for qemu-devel@nongnu.org; Sat, 20 Jan 2018 15:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eczMy-0003ju-Ax
	for qemu-devel@nongnu.org; Sat, 20 Jan 2018 15:04:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eczMy-0003gc-4t
	for qemu-devel@nongnu.org; Sat, 20 Jan 2018 15:04:04 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 20 Jan 2018 21:03:57 +0100
Message-Id: <20180120200358.19991-1-marcandre.lureau@redhat.com>
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
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The following changes since commit b384cd95eb9c6f73ad84ed1bb0717a26e29cc7=
8f:

  Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-r=
equest' into staging (2018-01-19 16:35:25 +0000)

are available in the Git repository at:

  https://github.com/elmarco/qemu.git tags/dump-pull-request

for you to fetch changes up to 6f49ec4034e55dfb675a56a62c9579384f7fb8cc:

  dump-guest-memory.py: fix python 2 support (2018-01-20 20:59:00 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Marc-Andr=C3=A9 Lureau (1):
  dump-guest-memory.py: fix python 2 support

 scripts/dump-guest-memory.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--=20
2.16.0.rc1.1.gef27df75a1
