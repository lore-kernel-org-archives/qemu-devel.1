Received: from eggs.gnu.org ([2001:4830:134:3::10]:51215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d7isg-0006Xb-3k
	for qemu-devel@nongnu.org; Mon, 08 May 2017 09:39:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d7isc-0001Jp-8S
	for qemu-devel@nongnu.org; Mon, 08 May 2017 09:39:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1d7isc-0001Jh-2B
	for qemu-devel@nongnu.org; Mon, 08 May 2017 09:39:14 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon,  8 May 2017 09:39:07 -0400
Message-Id: <20170508133908.12196-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.9 0/1] Tracing patches
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

The following changes since commit dd1559bb267becbb838de41132ef60771d183e=
5d:

  Merge remote-tracking branch 'elmarco/tags/chr-tests-pull-request' into=
 staging (2017-05-05 17:07:55 +0100)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to f3fddaf60b9b983b82cd11e8087e7c8a3903ee14:

  trace: disallow more than 10 arguments per trace event (2017-05-08 09:3=
8:30 -0400)

----------------------------------------------------------------

----------------------------------------------------------------

Daniel P. Berrange (1):
  trace: disallow more than 10 arguments per trace event

 scripts/tracetool/__init__.py | 4 ++++
 1 file changed, 4 insertions(+)

--=20
2.9.3
