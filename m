Received: from eggs.gnu.org ([2001:4830:134:3::10]:58832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eBfSI-0004WK-Pp
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 06:20:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eBfSE-0002mi-S3
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 06:20:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eBfSE-0002m4-Le
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 06:20:34 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon,  6 Nov 2017 11:20:26 +0000
Message-Id: <20171106112027.10196-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/1] Block patches
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

The following changes since commit b33afc415622e5eb26e0f14fd27eb86e32a547=
2e:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-ci-updates-for-=
softfreeze-021117-2' into staging (2017-11-03 10:08:34 +0000)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to ef9115dd7c82a196b18cac46784724bdebf01fbc:

  aio-posix: drop QEMU_AIO_POLL_MAX_NS env var (2017-11-06 11:04:38 +0000=
)

----------------------------------------------------------------

----------------------------------------------------------------

Stefan Hajnoczi (1):
  aio-posix: drop QEMU_AIO_POLL_MAX_NS env var

 util/aio-posix.c | 7 -------
 1 file changed, 7 deletions(-)

--=20
2.13.6
