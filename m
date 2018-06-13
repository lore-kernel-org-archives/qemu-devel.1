Received: from eggs.gnu.org ([2001:4830:134:3::10]:43371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fT4ub-0002ya-Ie
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fT4uY-0006OJ-Cr
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:30:05 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 13 Jun 2018 14:29:48 +0200
Message-Id: <20180613122948.18149-5-kraxel@redhat.com>
In-Reply-To: <20180613122948.18149-1-kraxel@redhat.com>
References: <20180613122948.18149-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v5 4/4] Add ramfb MAINTAINERS entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?L=C3=A1szl=C3=B3=20=C3=89rsek?= <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a94517e9e..2401028766 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1331,6 +1331,12 @@ F: hw/display/bochs-display.c
 F: include/hw/display/vga.h
 F: include/hw/display/bochs-vbe.h
 
+ramfb
+M: Gerd Hoffmann <kraxel@redhat.com>
+S: Maintained
+F: hw/display/ramfb*.c
+F: include/hw/display/ramfb.h
+
 virtio-gpu
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Maintained
-- 
2.9.3
