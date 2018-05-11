Received: from eggs.gnu.org ([2001:4830:134:3::10]:56944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fHCmf-0001Nv-HK
	for qemu-devel@nongnu.org; Fri, 11 May 2018 14:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fHCmb-0004GQ-Jt
	for qemu-devel@nongnu.org; Fri, 11 May 2018 14:28:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51420 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fHCmb-0004GG-FF
	for qemu-devel@nongnu.org; Fri, 11 May 2018 14:28:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 11 May 2018 19:28:40 +0100
Message-Id: <20180511182841.8920-1-stefanha@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

The following changes since commit e5cd695266c5709308aa95b1baae499e4b5d45=
44:

  Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' int=
o staging (2018-05-08 17:05:58 +0100)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to 0e07629297c9725e764b301dc03ab17cc1fb59e4:

  MAINTAINERS: Add trace-events and qemu-option-trace.texi to tracing sec=
tion (2018-05-10 11:55:33 +0100)

----------------------------------------------------------------
tracing patches

Just a MAINTAINERS file update for tracing files.

----------------------------------------------------------------

Thomas Huth (1):
  MAINTAINERS: Add trace-events and qemu-option-trace.texi to tracing
    section

 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

--=20
2.17.0
