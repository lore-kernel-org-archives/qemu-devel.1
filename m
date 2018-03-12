Received: from eggs.gnu.org ([2001:4830:134:3::10]:54716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1evRE3-0004na-6v
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:27:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1evRDz-00028q-Eq
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:27:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38380 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1evRDz-00028g-AH
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:27:03 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 13 Mar 2018 01:26:39 +0800
Message-Id: <20180312172640.15647-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/1] Docker patches
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

The following changes since commit b16a54da0696efc5d91b6c3597a37a317abb5d=
e7:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180312-pull-requ=
est' into staging (2018-03-12 14:06:23 +0000)

are available in the Git repository at:

  git://github.com/famz/qemu.git tags/staging-pull-request

for you to fetch changes up to 02f769b7ee72aa962ee22de64c14414298237da5:

  tests: make docker-test-debug@fedora run sanitizers (2018-03-13 01:19:5=
6 +0800)

----------------------------------------------------------------

----------------------------------------------------------------

Marc-Andr=C3=A9 Lureau (1):
  tests: make docker-test-debug@fedora run sanitizers

 tests/docker/dockerfiles/fedora.docker | 2 +-
 tests/docker/test-debug                | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

--=20
2.14.3
