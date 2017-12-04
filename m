Received: from eggs.gnu.org ([2001:4830:134:3::10]:51459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eLsUc-0007Og-0P
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:17:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eLsUX-0003Z8-SZ
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:17:13 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:3091)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1eLsUX-0003XJ-Iq
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:17:09 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Mon,  4 Dec 2017 16:17:04 +0100
Message-Id: <20171204151705.26028-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PULL 0/1] baum braille device update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, peter.maydell@linaro.org

warning: redirection vers https://people.debian.org/~sthibault/qemu.git/
The following changes since commit 7edaf99759017d3e175e37cffc3536e86a3bd380:

  Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' into staging (2017-11-13 13:54:59 +0000)

are available in the Git repository at:

  http://people.debian.org/~sthibault/qemu.git tags/samuel-thibault

for you to fetch changes up to 15405525fce773d43e7e5cabc2b9ac4b9d4d7672:

  baum: Truncate braille device size to 84x1 (2017-12-03 19:35:50 +0100)

----------------------------------------------------------------
baum updates

----------------------------------------------------------------
Samuel Thibault (1):
      baum: Truncate braille device size to 84x1

 chardev/baum.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)
