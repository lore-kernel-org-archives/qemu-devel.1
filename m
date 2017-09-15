Received: from eggs.gnu.org ([2001:4830:134:3::10]:60659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dsuau-0003o7-5m
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 13:40:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dsuaq-0005JJ-7W
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 13:40:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dsuaq-0005IG-1R
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 13:39:56 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 15 Sep 2017 18:39:49 +0100
Message-Id: <20170915173950.21404-1-stefanha@redhat.com>
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

The following changes since commit 3dabde1128b671f36ac6cb36b97b2731399644=
20:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20170914' =
into staging (2017-09-14 16:33:02 +0100)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to f99b38fc7c1bdf2dcc5e316478281c35b8c60f79:

  trace: Immediately apply per-vCPU state changes if a vCPU is being crea=
ted (2017-09-15 14:25:22 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Llu=C3=ADs Vilanova (1):
  trace: Immediately apply per-vCPU state changes if a vCPU is being
    created

 trace/control-target.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

--=20
2.13.5
