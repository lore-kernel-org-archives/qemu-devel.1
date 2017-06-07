Received: from eggs.gnu.org ([2001:4830:134:3::10]:42049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dIg7S-0003f3-Bl
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:55:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dIg7R-00074W-KI
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:55:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dIg7R-00074G-El
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:55:49 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  7 Jun 2017 19:55:39 +0100
Message-Id: <20170607185540.12767-1-stefanha@redhat.com>
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

The following changes since commit 0db1851becbefe3e50cfc03776fb1f75817376=
af:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.10-pull-re=
quest' into staging (2017-06-07 11:56:00 +0100)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to 249e9f792c4c6e52058570e83b550ec8310f621e:

  simpletrace: Improve the error message if event is not declared (2017-0=
6-07 14:34:19 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Jose Ricardo Ziviani (1):
  simpletrace: Improve the error message if event is not declared

 scripts/simpletrace.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--=20
2.9.4
