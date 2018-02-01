Received: from eggs.gnu.org ([2001:4830:134:3::10]:37148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ehCqk-0004jR-6V
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:16:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ehCqh-0003an-2o
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:16:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ehCqg-0003a8-T3
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:16:11 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  1 Feb 2018 12:16:04 +0100
Message-Id: <20180201111605.7392-1-marcandre.lureau@redhat.com>
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

The following changes since commit b05631954d6dfe93340d516660397e2c1a2a5d=
d6:

  Merge remote-tracking branch 'remotes/rth/tags/pull-hppa-20180131' into=
 staging (2018-01-31 15:50:29 +0000)

are available in the Git repository at:

  https://github.com/elmarco/qemu.git tags/dump-pull-request

for you to fetch changes up to ce6b9e421a9ab45d7e6c97af092a07c049954444:

  dump-guest-memory.py: skip vmcoreinfo section if not available (2018-02=
-01 12:13:52 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Marc-Andr=C3=A9 Lureau (1):
  dump-guest-memory.py: skip vmcoreinfo section if not available

 scripts/dump-guest-memory.py | 2 ++
 1 file changed, 2 insertions(+)

--=20
2.16.0.rc1.1.gef27df75a1
