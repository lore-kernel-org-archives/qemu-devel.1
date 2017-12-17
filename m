Received: from eggs.gnu.org ([2001:4830:134:3::10]:58239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQn8q-00089z-9a
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 23:35:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQn8l-0003e7-Ol
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 23:35:04 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 18 Dec 2017 00:27:30 +0300
Message-Id: <7e1f73ae1a9b7539368a32f6828eec4ca63bc1cc.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 25/61] MAINTAINERS: add an entry for
 input/pckbd.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

and fix a typo in the "PC Chipset" section

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2122a2a024..baeec72802 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -863,12 +863,13 @@ F: hw/misc/sga.c
 PC Chipset
 M: Michael S. Tsirkin <mst@redhat.com>
 M: Paolo Bonzini <pbonzini@redhat.com>
-S: Support
+S: Supported
 F: hw/char/debugcon.c
 F: hw/char/parallel.c
 F: hw/char/serial*
 F: hw/dma/i8257*
 F: hw/i2c/pm_smbus.c
+F: hw/input/pckbd.c
 F: hw/intc/apic*
 F: hw/intc/ioapic*
 F: hw/intc/i8259*
--=20
2.11.0
