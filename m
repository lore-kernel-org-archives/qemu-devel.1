Received: from eggs.gnu.org ([2001:4830:134:3::10]:48878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZWE-0002NS-JP
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:23:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZWB-0006Tl-Ek
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:23:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1e3ZWB-0006SP-8l
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:23:11 -0400
Date: Sun, 15 Oct 2017 06:23:03 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1508036858-13479-10-git-send-email-mst@redhat.com>
References: <1508036858-13479-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1508036858-13479-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/26] MAINTAINERS: add Dump maintainers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Proposing myself, since I have some familiarity with the code now.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Acked-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 772ac20..9cff973 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1317,6 +1317,17 @@ S: Maintained
 F: device_tree.c
 F: include/sysemu/device_tree.h
=20
+Dump
+S: Supported
+M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+F: dump.c
+F: hw/misc/vmcoreinfo.c
+F: include/hw/misc/vmcoreinfo.h
+F: include/sysemu/dump-arch.h
+F: include/sysemu/dump.h
+F: scripts/dump-guest-memory.py
+F: stubs/dump.c
+
 Error reporting
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
--=20
MST
