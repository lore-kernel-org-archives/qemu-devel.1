Received: from eggs.gnu.org ([2001:4830:134:3::10]:56505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gP9kH-0004N7-KK
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:23:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gP9kC-0003D7-FS
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:23:29 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 20 Nov 2018 18:22:50 +0100
Message-Id: <20181120172252.17800-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.1 0/2] iotests: More Python 3 fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org

Kevin Wolf (2):
  iotests: Replace time.clock() with Timeout
  iotests: Replace assertEquals() with assertEqual()

 tests/qemu-iotests/041        |  6 +++---
 tests/qemu-iotests/118        | 20 ++++++++------------
 tests/qemu-iotests/iotests.py |  2 +-
 3 files changed, 12 insertions(+), 16 deletions(-)

--=20
2.19.1
