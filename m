Received: from eggs.gnu.org ([2001:4830:134:3::10]:57977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQayo-0001VD-3c
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:03:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQayn-0006kW-8H
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:03:38 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 29 Jun 2017 12:03:08 -0300
Message-Id: <20170629150308.22766-6-f4bug@amsat.org>
In-Reply-To: <20170629150308.22766-1-f4bug@amsat.org>
References: <20170629150308.22766-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 5/5] MAINTAINERS: add entry for
 "Unimplemented" device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Eric Blake <eblake@redhat.com>

Also voluntary myself as reviewer

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9bad523060..890c25f0a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1155,6 +1155,13 @@ F: docs/specs/vmgenid.txt
 F: tests/vmgenid-test.c
 F: stubs/vmgenid.c
 
+Unimplemented device
+M: Peter Maydell <peter.maydell@linaro.org>
+R: Philippe Mathieu-Daudé <f4bug@amsat.org>
+S: Maintained
+F: include/hw/misc/unimp.h
+F: hw/misc/unimp.c
+
 Subsystems
 ----------
 Audio
-- 
2.13.1
