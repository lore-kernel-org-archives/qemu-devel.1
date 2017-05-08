Received: from eggs.gnu.org ([2001:4830:134:3::10]:36963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7qzh-0000Uf-Ty
	for qemu-devel@nongnu.org; Mon, 08 May 2017 18:19:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7qze-0007CD-7r
	for qemu-devel@nongnu.org; Mon, 08 May 2017 18:19:05 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7qze-0007C7-40
	for qemu-devel@nongnu.org; Mon, 08 May 2017 18:19:02 -0400
Received: by mail-qk0-x241.google.com with SMTP id y128so12143851qka.3
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 15:19:02 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 May 2017 19:17:58 -0300
Message-Id: <20170508221759.15616-21-f4bug@amsat.org>
In-Reply-To: <20170508221759.15616-1-f4bug@amsat.org>
References: <20170508221759.15616-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 20/21] MAINTAINERS: add Shippable automation
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
index efdec47319..6d0770fdd0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1833,6 +1833,7 @@ F: .travis.yml
 F: .shippable.yml
 F: tests/docker/
 W: https://travis-ci.org/qemu/qemu
+W: https://app.shippable.com/github/qemu/qemu
 W: http://patchew.org/QEMU/
 
 Documentation
-- 
2.11.0
