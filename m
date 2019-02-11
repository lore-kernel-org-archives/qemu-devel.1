Received: from eggs.gnu.org ([209.51.188.92]:50644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gtBHf-0007Wf-2d
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:06:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gtBHd-0004DI-7M
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:06:02 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:40398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gtBHb-0003lY-2o
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:06:00 -0500
Received: by mail-wr1-x42b.google.com with SMTP id q1so4620701wrp.7
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 05:05:15 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 11 Feb 2019 13:04:54 +0000
Message-Id: <20190211130507.8710-6-alex.bennee@linaro.org>
In-Reply-To: <20190211130507.8710-1-alex.bennee@linaro.org>
References: <20190211130507.8710-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/18] MAINTAINERS: Add an entry for
 scripts/archive-source.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The scripts/archive-source.sh is used by the VM tests, it makes
sense to add it in the "Build and test automation" section.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index eecfafad56..a2da141a92 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2471,6 +2471,7 @@ F: scripts/travis/
 F: .shippable.yml
 F: tests/docker/
 F: tests/vm/
+F: scripts/archive-source.sh
 W: https://travis-ci.org/qemu/qemu
 W: https://app.shippable.com/github/qemu/qemu
 W: http://patchew.org/QEMU/
-- 
2.20.1
