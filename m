Received: from eggs.gnu.org ([2001:4830:134:3::10]:45609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fUqvF-0001Ju-Uf
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 05:58:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fUqvF-0003Ja-6k
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 05:58:06 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 18 Jun 2018 11:57:58 +0200
Message-Id: <20180618095758.5006-5-kraxel@redhat.com>
In-Reply-To: <20180618095758.5006-1-kraxel@redhat.com>
References: <20180618095758.5006-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 4/4] Add ramfb MAINTAINERS entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Message-id: 20180613122948.18149-5-kraxel@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0fb5f38f9f..da91501c7a 100644
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
