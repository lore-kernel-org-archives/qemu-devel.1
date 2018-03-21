Received: from eggs.gnu.org ([2001:4830:134:3::10]:36748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eyesT-0003qO-DA
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:38:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eyesQ-00017s-Bk
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:38:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34414 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eyesQ-00017d-6u
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:38:06 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 15:37:52 +0100
Message-Id: <20180321143754.5606-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Dump patches
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

The following changes since commit f1a63fcfcd92c88be8942b5ae71aef9749a4f1=
35:

  Update version for v2.12.0-rc0 release (2018-03-20 19:04:22 +0000)

are available in the Git repository at:

  https://github.com/elmarco/qemu.git tags/dump-pull-request

for you to fetch changes up to 4b17bc933fc26f7a4a306a43597f4d97e3c2dc38:

  dump-guest-memory: more descriptive lookup_type failure (2018-03-21 15:=
02:00 +0100)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Andrew Jones (1):
  dump-guest-memory: more descriptive lookup_type failure

Yasmin Beatriz (1):
  dump.c: allow fd_write_vmcore to return errno on failure

 scripts/dump-guest-memory.py |  7 ++++++-
 dump.c                       | 23 ++++++++++++++---------
 2 files changed, 20 insertions(+), 10 deletions(-)

--=20
2.16.2.521.g9aa15f885a
