Received: from eggs.gnu.org ([2001:4830:134:3::10]:50208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fOlbZ-0000Kb-Tn
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fOlbW-0006o5-2K
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:04:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57720 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fOlbV-0006mV-Tj
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:04:33 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  1 Jun 2018 16:04:27 +0100
Message-Id: <20180601150428.30896-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/1] Tracing patches
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

The following changes since commit e609fa71e89c81fbe2670411be62da95dfb093=
e0:

  Merge remote-tracking branch 'remotes/edgar/tags/edgar/xilinx-next-2018=
-05-29-v1.for-upstream' into staging (2018-05-29 13:01:11 +0100)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to eb7ccb3c0e14ae5b6ce3254165b91a7ed77527dd:

  trace: Sort trace-events-subdirs (2018-05-30 16:08:17 +0100)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Philippe Mathieu-Daud=C3=A9 (1):
  trace: Sort trace-events-subdirs

 Makefile.objs | 82 +++++++++++++++++++++++++--------------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

--=20
2.17.0
