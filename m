Received: from eggs.gnu.org ([2001:4830:134:3::10]:39669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1euFTb-0002A3-OS
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:42:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1euFTb-0001IG-1j
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:42:15 -0500
From: Amador Pahim <apahim@redhat.com>
Date: Fri,  9 Mar 2018 11:41:49 +0100
Message-Id: <20180309104151.2431-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] qemu-iotests fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, Amador Pahim <apahim@redhat.com>

- Skipping test 205 for unsupported formats.
- Setting execution permission on test files.

Amador Pahim (2):
  qemu-iotests: skip test 205 for unsupported formats
  qemu-iotests: set exec permission for tests lacking it

 tests/qemu-iotests/096 | 0
 tests/qemu-iotests/124 | 0
 tests/qemu-iotests/129 | 0
 tests/qemu-iotests/132 | 0
 tests/qemu-iotests/136 | 0
 tests/qemu-iotests/139 | 0
 tests/qemu-iotests/148 | 0
 tests/qemu-iotests/152 | 0
 tests/qemu-iotests/163 | 0
 tests/qemu-iotests/205 | 3 +++
 10 files changed, 3 insertions(+)
 mode change 100644 => 100755 tests/qemu-iotests/096
 mode change 100644 => 100755 tests/qemu-iotests/124
 mode change 100644 => 100755 tests/qemu-iotests/129
 mode change 100644 => 100755 tests/qemu-iotests/132
 mode change 100644 => 100755 tests/qemu-iotests/136
 mode change 100644 => 100755 tests/qemu-iotests/139
 mode change 100644 => 100755 tests/qemu-iotests/148
 mode change 100644 => 100755 tests/qemu-iotests/152
 mode change 100644 => 100755 tests/qemu-iotests/163
 mode change 100644 => 100755 tests/qemu-iotests/205

-- 
2.14.3
