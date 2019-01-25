Received: from eggs.gnu.org ([209.51.188.92]:52109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gn224-0003VM-5j
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:00:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gn221-0000fz-QU
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:00:31 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:45619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gn21x-0000Xs-O0
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:00:25 -0500
Received: by mail-wr1-x429.google.com with SMTP id t6so10367604wrr.12
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 06:00:22 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 25 Jan 2019 14:00:06 +0000
Message-Id: <20190125140017.6092-4-alex.bennee@linaro.org>
In-Reply-To: <20190125140017.6092-1-alex.bennee@linaro.org>
References: <20190125140017.6092-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 03/14] MAINTAINERS: Add an entry for
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The scripts/archive-source.sh is used by the VM tests, it makes
sense to add it in the "Build and test automation" section.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ddfb86bb2..f2f9a7b0c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2479,6 +2479,7 @@ F: scripts/travis/
 F: .shippable.yml
 F: tests/docker/
 F: tests/vm/
+F: scripts/archive-source.sh
 W: https://travis-ci.org/qemu/qemu
 W: https://app.shippable.com/github/qemu/qemu
 W: http://patchew.org/QEMU/
-- 
2.17.1
