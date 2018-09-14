Received: from eggs.gnu.org ([2001:4830:134:3::10]:49976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1g0noP-0000gj-0x
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 09:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1g0noL-0006ki-NV
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 09:07:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1g0noH-0006M6-RY
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 09:06:59 -0400
From: Eduardo Otubo <otubo@redhat.com>
Date: Fri, 14 Sep 2018 15:06:43 +0200
Message-Id: <20180914130644.15292-1-otubo@redhat.com>
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
Cc: peter.maydell@linaro.org, marcandre.lureau@redhat.com

The following changes since commit 19b599f7664b2ebfd0f405fb79c14dd2415574=
52:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-08-27=
-v2' into staging (2018-08-27 16:44:20 +0100)

are available in the Git repository at:

  https://github.com/otubo/qemu.git tags/pull-seccomp-20180914

for you to fetch changes up to d3228ed3829981047138bbaff332026f9d64f337:

  seccomp: check TSYNC host capability (2018-09-14 15:01:55 +0200)

----------------------------------------------------------------
pull-seccomp-20180914

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (1):
      seccomp: check TSYNC host capability

 qemu-seccomp.c | 19 ++++++++++++++++++-
 vl.c           |  4 ++--
 2 files changed, 20 insertions(+), 3 deletions(-)

--=20
2.17.1
