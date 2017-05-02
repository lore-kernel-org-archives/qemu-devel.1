Received: from eggs.gnu.org ([2001:4830:134:3::10]:40845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1d5R7G-0003S4-NM
	for qemu-devel@nongnu.org; Tue, 02 May 2017 02:16:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1d5R7D-0002eT-Iw
	for qemu-devel@nongnu.org; Tue, 02 May 2017 02:16:54 -0400
Received: from mail.ispras.ru ([83.149.199.45]:49774)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1d5R7D-0002cc-BK
	for qemu-devel@nongnu.org; Tue, 02 May 2017 02:16:51 -0400
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Tue, 02 May 2017 09:16:49 +0300
Message-ID: <20170502061649.6668.93083.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] maintainers: add maintainer for replay* files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, dovgaluk@ispras.ru, armbru@redhat.com

Updating MAINTAINERS to set Pavel Dovgalyuk as record/replay maintainer.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 MAINTAINERS |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a1d2b3a4d3..8be1c74ac5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1546,6 +1546,15 @@ F: net/colo*
 F: net/filter-rewriter.c
 F: net/filter-mirror.c
 
+Record/replay
+M: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
+W: http://wiki.qemu.org/Features/record-replay
+S: Supported
+F: replay/*
+F: block/blkreplay.c
+F: net/filter-replay.c
+F: include/sysemu/replay.h
+
 Usermode Emulation
 ------------------
 Overall
