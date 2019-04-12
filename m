Received: from eggs.gnu.org ([209.51.188.92]:57666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1hEuV2-0005EP-UQ
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:37:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1hEuV2-0003L0-1y
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:37:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1hEuV1-0003J0-QJ
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:37:39 -0400
From: Eduardo Otubo <otubo@redhat.com>
Date: Fri, 12 Apr 2019 13:37:29 +0200
Message-Id: <20190412113730.28828-1-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/1] seccomp branch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, deller@gmx.de, berrange@redhat.com, philmd@redhat.com

The following changes since commit 532cc6da74ec25b5ba6893b5757c977d545829=
49:

  Update version for v4.0.0-rc3 release (2019-04-10 15:38:59 +0100)

are available in the Git repository at:

  https://github.com/otubo/qemu.git tags/pull-seccomp-20190412

for you to fetch changes up to ee352b53b3e49ba9621149f9de7279a5cadd606c:

  configure: Relax check for libseccomp (2019-04-12 13:30:40 +0200)

----------------------------------------------------------------
pull-seccomp-20190412

----------------------------------------------------------------
Helge Deller (1):
      configure: Relax check for libseccomp

 configure | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

--=20
2.17.2
