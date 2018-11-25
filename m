Received: from eggs.gnu.org ([2001:4830:134:3::10]:39908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1OK-0000wj-Os
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 15:52:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1OK-0006Jz-2l
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 15:52:32 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sun, 25 Nov 2018 21:49:50 +0100
Message-Id: <20181125205000.10324-16-philmd@redhat.com>
In-Reply-To: <20181125205000.10324-1-philmd@redhat.com>
References: <20181125205000.10324-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.1 15/25] MAINTAINERS: Add missing entries
 for the Canon DIGIC machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Antony Pavlov <antonynpavlov@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-arm@nongnu.org

This pattern now also matches:
- include/hw/timer/digic-timer.h
- include/hw/char/digic-uart.h

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index eab0fb9742..e04f2f1a44 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -527,6 +527,7 @@ L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: include/hw/arm/digic.h
 F: hw/*/digic*
+F: include/hw/*/digic*
=20
 Gumstix
 M: Peter Maydell <peter.maydell@linaro.org>
--=20
2.17.2
