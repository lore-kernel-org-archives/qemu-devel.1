Received: from eggs.gnu.org ([2001:4830:134:3::10]:33341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e5W0z-0001df-69
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:03:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e5W0v-0007jA-D4
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:03:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1e5W0v-0007io-81
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:02:57 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 20 Oct 2017 14:02:34 +0200
Message-Id: <20171020120235.29142-1-stefanha@redhat.com>
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

The following changes since commit 063833a6ec2a6747e27c5f9866bb44c7e8de12=
65:

  Merge remote-tracking branch 'remotes/mcayland/tags/qemu-sparc-signed' =
into staging (2017-10-19 18:42:51 +0100)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to e947d47da0b16e80d237c510e9d2e80799578c7f:

  oslib-posix: Fix compiler warning and some data types (2017-10-20 11:16=
:27 +0200)

----------------------------------------------------------------

----------------------------------------------------------------

Stefan Weil (1):
  oslib-posix: Fix compiler warning and some data types

 util/oslib-posix.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

--=20
2.13.6
