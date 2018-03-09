Received: from eggs.gnu.org ([2001:4830:134:3::10]:34291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKlO-0001by-67
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKlM-0007Ww-UP
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:58 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:19:30 +0100
Message-Id: <20180309161933.8168-54-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 53/56] iotests: Mark all tests executable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

The majority of our iotests have the executable bit set; fix the
few outliers for consistency.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-id: 20180305161824.7188-1-eblake@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/096 | 0
 tests/qemu-iotests/124 | 0
 tests/qemu-iotests/129 | 0
 tests/qemu-iotests/132 | 0
 tests/qemu-iotests/136 | 0
 tests/qemu-iotests/139 | 0
 tests/qemu-iotests/148 | 0
 tests/qemu-iotests/152 | 0
 tests/qemu-iotests/163 | 0
 tests/qemu-iotests/205 | 0
 10 files changed, 0 insertions(+), 0 deletions(-)
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

diff --git a/tests/qemu-iotests/096 b/tests/qemu-iotests/096
old mode 100644
new mode 100755
diff --git a/tests/qemu-iotests/124 b/tests/qemu-iotests/124
old mode 100644
new mode 100755
diff --git a/tests/qemu-iotests/129 b/tests/qemu-iotests/129
old mode 100644
new mode 100755
diff --git a/tests/qemu-iotests/132 b/tests/qemu-iotests/132
old mode 100644
new mode 100755
diff --git a/tests/qemu-iotests/136 b/tests/qemu-iotests/136
old mode 100644
new mode 100755
diff --git a/tests/qemu-iotests/139 b/tests/qemu-iotests/139
old mode 100644
new mode 100755
diff --git a/tests/qemu-iotests/148 b/tests/qemu-iotests/148
old mode 100644
new mode 100755
diff --git a/tests/qemu-iotests/152 b/tests/qemu-iotests/152
old mode 100644
new mode 100755
diff --git a/tests/qemu-iotests/163 b/tests/qemu-iotests/163
old mode 100644
new mode 100755
diff --git a/tests/qemu-iotests/205 b/tests/qemu-iotests/205
old mode 100644
new mode 100755
-- 
2.13.6
