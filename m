Received: from eggs.gnu.org ([2001:4830:134:3::10]:56914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fdbba-0001nE-6e
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:25:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fdbbV-0001A0-Oe
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:25:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47166 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1fdbbV-00019A-K0
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:25:53 -0400
From: Eduardo Otubo <otubo@redhat.com>
Date: Thu, 12 Jul 2018 15:25:37 +0200
Message-Id: <20180712132538.21921-1-otubo@redhat.com>
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

The following changes since commit c447afd5783b9237fa51b7a85777007d8d568b=
fc:

  Update version for v3.0.0-rc0 release (2018-07-10 18:19:50 +0100)

are available in the Git repository at:

  https://github.com/otubo/qemu.git tags/pull-seccomp-20180712

for you to fetch changes up to 056de1e894155fbb99e7b43c1c4382d4920cf437:

  seccomp: allow sched_setscheduler() with SCHED_IDLE policy (2018-07-12 =
14:52:39 +0200)

----------------------------------------------------------------
pull-seccomp-20180712

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (1):
      seccomp: allow sched_setscheduler() with SCHED_IDLE policy

 qemu-seccomp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--=20
2.17.1
