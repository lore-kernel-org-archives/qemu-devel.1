Received: from eggs.gnu.org ([2001:4830:134:3::10]:39415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1NZ-0000H3-0E
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 15:51:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1NY-0005nk-6q
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 15:51:44 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sun, 25 Nov 2018 21:49:40 +0100
Message-Id: <20181125205000.10324-6-philmd@redhat.com>
In-Reply-To: <20181125205000.10324-1-philmd@redhat.com>
References: <20181125205000.10324-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.1 05/25] MAINTAINERS: Add missing entries
 for the Jazz machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 007f89f126..4e396cbe71 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -835,6 +835,8 @@ M: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
 R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Maintained
 F: hw/mips/mips_jazz.c
+F: hw/display/jazz_led.c
+F: hw/dma/rc4030.c
=20
 Malta
 M: Aurelien Jarno <aurelien@aurel32.net>
--=20
2.17.2
