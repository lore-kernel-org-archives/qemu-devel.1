Received: from eggs.gnu.org ([209.51.188.92]:40949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1groYf-0000Du-Pb
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:37:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1groYe-0007S0-7M
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:37:57 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:38980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1groYc-0007JI-3C
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:37:56 -0500
Received: by mail-wm1-x335.google.com with SMTP id f16so931511wmh.4
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 10:37:51 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  7 Feb 2019 18:37:33 +0000
Message-Id: <20190207183744.5054-6-alex.bennee@linaro.org>
In-Reply-To: <20190207183744.5054-1-alex.bennee@linaro.org>
References: <20190207183744.5054-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 05/16] MAINTAINERS: Add an entry for
 scripts/archive-source.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The scripts/archive-source.sh is used by the VM tests, it makes
sense to add it in the "Build and test automation" section.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

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
