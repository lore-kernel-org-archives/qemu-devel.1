Received: from eggs.gnu.org ([2001:4830:134:3::10]:48676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dCHZy-0001jH-Ib
	for qemu-devel@nongnu.org; Sat, 20 May 2017 23:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dCHZx-0007Q6-I9
	for qemu-devel@nongnu.org; Sat, 20 May 2017 23:30:50 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:34014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dCHZx-0007Po-Dv
	for qemu-devel@nongnu.org; Sat, 20 May 2017 23:30:49 -0400
Received: by mail-oi0-x242.google.com with SMTP id w10so18060380oif.1
	for <qemu-devel@nongnu.org>; Sat, 20 May 2017 20:30:49 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 21 May 2017 00:29:55 -0300
Message-Id: <20170521032956.27446-24-f4bug@amsat.org>
In-Reply-To: <20170521032956.27446-1-f4bug@amsat.org>
References: <20170521032956.27446-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 23/24] MAINTAINERS: add Shippable automation
 platform URL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ef2ec58a94..33f47a989b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1857,6 +1857,7 @@ F: .travis.yml
 F: .shippable.yml
 F: tests/docker/
 W: https://travis-ci.org/qemu/qemu
+W: https://app.shippable.com/github/qemu/qemu
 W: http://patchew.org/QEMU/
 
 Documentation
-- 
2.11.0
