Received: from eggs.gnu.org ([209.51.188.92]:36808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI47-000836-1L
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:21:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI45-0000Uh-I6
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:21:10 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Feb 2019 16:19:43 +0100
Message-Id: <20190225152053.15976-2-kwolf@redhat.com>
In-Reply-To: <20190225152053.15976-1-kwolf@redhat.com>
References: <20190225152053.15976-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/71] MAINTAINERS: Replace myself with John
 Snow for block jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Jeff Cody <jcody@redhat.com>

I'll not be involved with day-to-day qemu development, and John
Snow is a block jobs wizard.  Have him take over block job
maintainership duties.

Signed-off-by: Jeff Cody <jcody@redhat.com>
Acked-by: John Snow <jsnow@redhat.com>
Message-Id: <d56d7c6592e7d68aa72764e9616878394bffbc14.1537984851.git.jcod=
y@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6ae55ff732..bb4d9829a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1698,7 +1698,7 @@ F: include/scsi/*
 F: scsi/*
=20
 Block Jobs
-M: Jeff Cody <jcody@redhat.com>
+M: John Snow <jsnow@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
 F: blockjob.c
@@ -1711,7 +1711,7 @@ F: block/commit.c
 F: block/stream.c
 F: block/mirror.c
 F: qapi/job.json
-T: git https://github.com/codyprime/qemu-kvm-jtc.git block
+T: git https://github.com/jnsnow/qemu.git jobs
=20
 Block QAPI, monitor, command line
 M: Markus Armbruster <armbru@redhat.com>
--=20
2.20.1
