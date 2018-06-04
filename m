Received: from eggs.gnu.org ([2001:4830:134:3::10]:41433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fPjdw-0006Ui-0l
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 03:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fPjds-0003Ik-1M
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 03:11:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53464 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fPjdr-0003IM-TA
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 03:10:59 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon,  4 Jun 2018 15:10:48 +0800
Message-Id: <20180604071050.12492-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Docker patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

The following changes since commit 392fba9f583223786f844dce9b2e7f9a0ce014=
7a:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-travis-updates-=
010618-1' into staging (2018-06-01 17:32:30 +0100)

are available in the Git repository at:

  git://github.com/famz/qemu.git tags/docker-pull-request

for you to fetch changes up to 63dba573fa65bf830ec3f78a8f3a6b0697ce1637:

  docker: Update fedora image to 28 (2018-06-04 14:39:18 +0800)

----------------------------------------------------------------

Hi Peter,

One improvement from Alex and one patch to track the Fedora latest
release.

----------------------------------------------------------------

Alex Benn=C3=A9e (1):
  tests/docker/Makefile.include: handle empty TARGET_LIST

Fam Zheng (1):
  docker: Update fedora image to 28

 rules.mak                              | 3 +++
 tests/docker/Makefile.include          | 2 +-
 tests/docker/dockerfiles/fedora.docker | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

--=20
2.17.0
