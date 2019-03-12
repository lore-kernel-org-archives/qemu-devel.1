Received: from eggs.gnu.org ([209.51.188.92]:46134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h3WyW-0006Oj-7i
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 22:17:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h3WyV-0007Qe-GI
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 22:17:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1h3WyV-0007QE-8U
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 22:17:03 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 11 Mar 2019 23:16:58 -0300
Message-Id: <20190312021659.24197-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/1] qmp-shell: fix nested json regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>

The following changes since commit 336cfef495f0cd5b1606251c52628d0372e9a8=
09:

  Makefile: Don't install non-sphinx files in sphinx docs install (2019-0=
3-11 11:10:44 +0000)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/python-next-pull-request

for you to fetch changes up to b35203b227261961ff1da9b77b546c1919968bee:

  qmp-shell: fix nested json regression (2019-03-11 10:22:31 -0300)

----------------------------------------------------------------
qmp-shell: fix nested json regression

One small bug fix.

----------------------------------------------------------------

Marc-Andr=C3=A9 Lureau (1):
  qmp-shell: fix nested json regression

 scripts/qmp/qmp-shell | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--=20
2.18.0.rc1.1.g3f1ff2140
