Received: from eggs.gnu.org ([2001:4830:134:3::10]:56216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ebp0X-0005ak-U8
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:48:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ebp0U-0005v7-Lt
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:48:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ebp0U-0005uO-Fo
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:48:02 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Jan 2018 15:47:55 +0100
Message-Id: <20180117144756.31049-1-marcandre.lureau@redhat.com>
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

The following changes since commit 8e5dc9ba49743b46d955ec7dacb04e42ae7ada=
7c:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180116' into =
staging (2018-01-16 17:36:39 +0000)

are available in the Git repository at:

  https://github.com/elmarco/qemu.git tags/dump-pull-request

for you to fetch changes up to 48fb74965a8d8f2916da30d9c5b9945df25142af:

  dump-guest-memory.py: fix python 2 support (2018-01-17 15:47:14 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Marc-Andr=C3=A9 Lureau (1):
  dump-guest-memory.py: fix python 2 support

 scripts/dump-guest-memory.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--=20
2.16.0.rc1.1.gef27df75a1
