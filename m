Received: from eggs.gnu.org ([209.51.188.92]:60638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1h3ODO-0006uM-N7
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1h3ODM-0002tu-Rx
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:50 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45923)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1h3ODL-0002qq-82
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:48 -0400
Received: by mail-wr1-x442.google.com with SMTP id o7so5913287wrp.12
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 09:55:45 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 11 Mar 2019 16:55:38 +0000
Message-Id: <20190311165538.6623-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] scripts/qemugdb: re-license timers.py to GPLv2
 or later
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Greg Kurz <groug@kaod.org>

I'm the sole author (aside from a one line by Greg fixing encoding)
and I was asked nicely on IRC to bring it into line with the rest of
the files.

Cc: Greg Kurz <groug@kaod.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/qemugdb/timers.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/qemugdb/timers.py b/scripts/qemugdb/timers.py
index 51ea04b5e2..f0e132d27a 100644
--- a/scripts/qemugdb/timers.py
+++ b/scripts/qemugdb/timers.py
@@ -6,8 +6,10 @@
 #
 # Author: Alex Bennée <alex.bennee@linaro.org>
 #
-# This work is licensed under the terms of the GNU GPL, version 2.  See
-# the COPYING file in the top-level directory.
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
 
 # 'qemu timers' -- display the current timerlists
 
-- 
2.20.1
