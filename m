Received: from eggs.gnu.org ([2001:4830:134:3::10]:41397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ealxr-00005z-FT
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 12:21:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ealxq-0002I9-NR
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 12:20:59 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1ealxq-0002Gj-GH
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 12:20:58 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 14 Jan 2018 18:20:50 +0100
Message-Id: <20180114172053.1051-3-samuel.thibault@ens-lyon.org>
In-Reply-To: <20180114172053.1051-1-samuel.thibault@ens-lyon.org>
References: <20180114172053.1051-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/5] slirp: remove unused header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/slirp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/slirp/slirp.h b/slirp/slirp.h
index 898ec9516d..06febfc78b 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -1,7 +1,6 @@
 #ifndef SLIRP_H
 #define SLIRP_H
=20
-#include "qemu/host-utils.h"
 #include "slirp_config.h"
=20
 #ifdef _WIN32
--=20
2.15.1
