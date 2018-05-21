Received: from eggs.gnu.org ([2001:4830:134:3::10]:38006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1fKn5s-00049V-Jx
	for qemu-devel@nongnu.org; Mon, 21 May 2018 11:51:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1fKn5o-00047F-L9
	for qemu-devel@nongnu.org; Mon, 21 May 2018 11:51:28 -0400
Received: from ssl.serverraum.org ([213.133.101.245]:46643)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@walle.cc>) id 1fKn5o-00046Y-EW
	for qemu-devel@nongnu.org; Mon, 21 May 2018 11:51:24 -0400
From: Michael Walle <michael@walle.cc>
Date: Mon, 21 May 2018 17:49:51 +0200
Message-Id: <20180521154952.15421-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/1] target/lm32 BQL patch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>

The following changes since commit 81e9cbd0ca1131012b058df6804b1f626a6b73=
0c:

  lm32: take BQL before writing IP/IM register (2018-05-21 13:37:12 +0200=
)

are available in the git repository at:

  git://github.com/mwalle/qemu.git tags/lm32-queue/20180521

for you to fetch changes up to 81e9cbd0ca1131012b058df6804b1f626a6b730c:

  lm32: take BQL before writing IP/IM register (2018-05-21 13:37:12 +0200=
)

----------------------------------------------------------------

Michael Walle (1):
  lm32: take BQL before writing IP/IM register

 target/lm32/op_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

--=20
2.11.0
