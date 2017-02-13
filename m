Received: from eggs.gnu.org ([2001:4830:134:3::10]:42160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cdJVd-0005PN-G3
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:29:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cdJVY-0006Mc-Pv
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:29:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cdJVY-0006Ln-Jo
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:29:44 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 13 Feb 2017 16:29:38 +0000
Message-Id: <20170213162940.13428-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Tracing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The following changes since commit 6311b19b5c650388745aafe1269489bd5afe4f=
2d:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
70210' into staging (2017-02-10 18:54:30 +0000)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to 6eab3544f47207e976df37a85c5855bf55754713:

  Makefile: Make "install" depend on "trace-events-all" (2017-02-13 13:38=
:31 +0000)

----------------------------------------------------------------

----------------------------------------------------------------

Fam Zheng (1):
  Makefile: Make "install" depend on "trace-events-all"

Philipp Gesang (1):
  docs: update manpage for stderr->log rename

 Makefile               | 2 +-
 qemu-option-trace.texi | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--=20
2.9.3
