Received: from eggs.gnu.org ([2001:4830:134:3::10]:50375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gX1ZH-0004sB-E9
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:16:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gX1ZF-0001bj-Gj
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:16:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gX1ZF-0001ah-AK
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:16:37 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 12 Dec 2018 10:16:30 +0000
Message-Id: <20181212101632.2600-1-stefanha@redhat.com>
MIME-Version: 1.0
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

The following changes since commit bb9bf94b3e8926553290bc9a7cb84315af4220=
86:

  Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-r=
equest' into staging (2018-12-11 19:18:58 +0000)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to 7ff5920717d413d8b7c3ba13d9a0805291b9e6ec:

  trace: simple style changes (2018-12-12 10:04:59 +0000)

----------------------------------------------------------------
Pull request

Minor tracing improvements.

----------------------------------------------------------------

Fabiano Rosas (1):
  tracetool: Include thread id information in log backend

Larry Dewey (1):
  trace: simple style changes

 trace/simple.c                   | 4 ++--
 scripts/tracetool/backend/log.py | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--=20
2.19.2
