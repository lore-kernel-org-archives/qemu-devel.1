Received: from eggs.gnu.org ([2001:4830:134:3::10]:59815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1eFO7b-0007a3-DD
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:38:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1eFO7Z-0003GC-GV
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:38:39 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 16 Nov 2017 12:38:08 -0500
Message-Id: <20171116173810.16457-9-crosa@redhat.com>
In-Reply-To: <20171116173810.16457-1-crosa@redhat.com>
References: <20171116173810.16457-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 08/10] qemu-iotests: clean up double comment
 characters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>

This is a syntactic only change, just to make it consistent with
the style used on all other tests.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/qemu-iotests/048 | 37 ++++++++++++++++++-------------------
 tests/qemu-iotests/074 | 40 ++++++++++++++++++++--------------------
 2 files changed, 38 insertions(+), 39 deletions(-)

diff --git a/tests/qemu-iotests/048 b/tests/qemu-iotests/048
index 531bed217c..3253d77c91 100755
--- a/tests/qemu-iotests/048
+++ b/tests/qemu-iotests/048
@@ -1,23 +1,22 @@
 #!/bin/bash
-##
-## qemu-img compare test
-##
-##
-## Copyright (C) 2013 Red Hat, Inc.
-##
-## This program is free software; you can redistribute it and/or modify
-## it under the terms of the GNU General Public License as published by
-## the Free Software Foundation; either version 2 of the License, or
-## (at your option) any later version.
-##
-## This program is distributed in the hope that it will be useful,
-## but WITHOUT ANY WARRANTY; without even the implied warranty of
-## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-## GNU General Public License for more details.
-##
-## You should have received a copy of the GNU General Public License
-## along with this program.  If not, see <http://www.gnu.org/licenses/>.
-##
+#
+# qemu-img compare test
+#
+#
+# Copyright (C) 2013 Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 # Creator/Owner: mrezanin@redhat.com
 #
diff --git a/tests/qemu-iotests/074 b/tests/qemu-iotests/074
index d454580067..d09c909bd8 100755
--- a/tests/qemu-iotests/074
+++ b/tests/qemu-iotests/074
@@ -1,24 +1,24 @@
 #!/bin/bash
-##
-## qemu-img compare test (qcow2 only ones)
-##
-##
-## Copyright (C) 2013 Red Hat, Inc.
-##
-## This program is free software; you can redistribute it and/or modify
-## it under the terms of the GNU General Public License as published by
-## the Free Software Foundation; either version 2 of the License, or
-## (at your option) any later version.
-##
-## This program is distributed in the hope that it will be useful,
-## but WITHOUT ANY WARRANTY; without even the implied warranty of
-## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-## GNU General Public License for more details.
-##
-## You should have received a copy of the GNU General Public License
-## along with this program.  If not, see <http://www.gnu.org/licenses/>.
-##
-## Creator/Owner: famz@redhat.com
+#
+# qemu-img compare test (qcow2 only ones)
+#
+#
+# Copyright (C) 2013 Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+# Creator/Owner: famz@redhat.com
 #
 
 seq=`basename $0`
-- 
2.13.6
