Received: from eggs.gnu.org ([2001:4830:134:3::10]:39250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1NU-0000Bo-2C
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 15:51:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1NT-0005hb-93
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 15:51:40 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sun, 25 Nov 2018 21:49:39 +0100
Message-Id: <20181125205000.10324-5-philmd@redhat.com>
In-Reply-To: <20181125205000.10324-1-philmd@redhat.com>
References: <20181125205000.10324-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.1 04/25] MAINTAINERS: Add missing entries
 for the Xilinx ZynqMP machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-arm@nongnu.org

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b9996ab2c..007f89f126 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -711,6 +711,9 @@ L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/*/xlnx*.c
 F: include/hw/*/xlnx*.h
+F: include/hw/ssi/xilinx_spips.h
+F: hw/display/dpcd.c
+F: include/hw/display/dpcd.h
=20
 ARM ACPI Subsystem
 M: Shannon Zhao <shannon.zhaosl@gmail.com>
--=20
2.17.2
