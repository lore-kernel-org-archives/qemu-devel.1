Received: from eggs.gnu.org ([2001:4830:134:3::10]:55426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ccEN6-0000JF-OO
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 11:48:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ccEN2-0001Sy-3G
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 11:48:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1ccEN1-0001Sb-TY
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 11:48:28 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 10 Feb 2017 11:48:24 -0500
Message-Id: <20170210164825.9241-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] Ide patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com

The following changes since commit 61eedf7aec0e2395aabd628cc055096909a3ea15:

  tests/prom-env: Ease time-out problems on slow hosts (2017-02-10 15:44:53 +0000)

are available in the git repository at:

  https://github.com/jnsnow/qemu.git tags/ide-pull-request

for you to fetch changes up to 98cb5dccb192b0082626080890dac413473573c6:

  ahci: advertise HOST_CAP_64 (2017-02-10 11:47:11 -0500)

----------------------------------------------------------------

----------------------------------------------------------------

Ladi Prosek (1):
  ahci: advertise HOST_CAP_64

 hw/ide/ahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.9.3
