Received: from eggs.gnu.org ([2001:4830:134:3::10]:49147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnAyB-0005ni-V4
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 17:56:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnAyB-0007wl-7z
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 17:56:20 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 30 Aug 2017 18:55:21 -0300
Message-Id: <20170830215523.25278-16-f4bug@amsat.org>
In-Reply-To: <20170830215523.25278-1-f4bug@amsat.org>
References: <20170830215523.25278-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 15/17] MAINTAINERS: add missing Cryptography
 entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P . Berrange" <berrange@redhat.com>, Longpeng <longpeng2@huawei.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0b77590dc8..7a0c00550e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1526,6 +1526,7 @@ S: Maintained
 F: crypto/
 F: include/crypto/
 F: tests/test-crypto-*
+F: tests/benchmark-crypto-*
 F: qemu.sasl
 
 Coroutines
-- 
2.14.1
