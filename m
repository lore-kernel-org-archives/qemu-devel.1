Received: from eggs.gnu.org ([2001:4830:134:3::10]:33289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUqeI-0007jX-Dt
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUqeE-0008DT-1C
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:36:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dUqeD-0008D9-RS
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:35:57 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 11 Jul 2017 09:35:50 +0100
Message-Id: <20170711083552.17433-1-stefanha@redhat.com>
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

The following changes since commit 6b06e3e49eb8c91cc286c16d6bf3181ac296f3=
3d:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2017-07-10-v2=
' into staging (2017-07-10 16:12:47 +0100)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to cbea0ac4fe4989ae70088e01ad8b5e99f7ce3846:

  backends: remove empty trace-events file (2017-07-11 09:35:11 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Daniel P. Berrange (1):
  backends: remove empty trace-events file

Llu=C3=ADs Vilanova (1):
  trace: Fix early setting of events with the "vcpu" property

 Makefile.objs          |  1 -
 trace/control-target.c | 10 +++++++---
 backends/trace-events  |  0
 3 files changed, 7 insertions(+), 4 deletions(-)
 delete mode 100644 backends/trace-events

--=20
2.9.4
