Received: from eggs.gnu.org ([209.51.188.92]:49592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hG5zt-0007nq-KY
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 14:06:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hG5zs-0004Jv-LU
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 14:06:25 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:35356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hG5zs-0004Io-Cl
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 14:06:24 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Mon, 15 Apr 2019 20:06:17 +0200
Message-Id: <20190415180618.1450-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/1] slirp gcc9 build fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com, jan.kiszka@siemens.com

The following changes since commit afccfc0c4c6134a7bc9da6375996b3b91d291d=
e4:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into sta=
ging (2019-04-12 17:06:49 +0100)

are available in the Git repository at:

  https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault

for you to fetch changes up to 6fabae61a9393fd2bc703837e464b9c34ec5ef25:

  slirp: Gcc 9 -O3 fix (2019-04-15 20:01:18 +0200)

----------------------------------------------------------------
Slirp updates

Dr. David Alan Gilbert (1):
  slirp: Gcc 9 -O3 fix

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      slirp: Gcc 9 -O3 fix

 slirp/src/socket.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)
