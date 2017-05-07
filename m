Received: from eggs.gnu.org ([2001:4830:134:3::10]:58094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d7Go1-0001Pg-Fa
	for qemu-devel@nongnu.org; Sun, 07 May 2017 03:40:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d7Gny-000727-DV
	for qemu-devel@nongnu.org; Sun, 07 May 2017 03:40:37 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun,  7 May 2017 10:02:24 +0300
Message-Id: <7f8393c41831e21228cf10e40c581826c90db4f7.1494140528.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
References: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
References: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/23] MAINTAINERS: Update paths for main loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Paolo Bonzini <pbonzini@redhat.com>

Moved by c2b38b2 ("block: move AioContext, QEMUTimer, main-loop to
libqemuutil"), let's update MAINTAINERS too.

Reported-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a1d2b3a4d3..e6822b23bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1305,8 +1305,8 @@ Main loop
 M: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: cpus.c
-F: main-loop.c
-F: qemu-timer.c
+F: util/main-loop.c
+F: util/qemu-timer.c
 F: vl.c
=20
 Human Monitor (HMP)
--=20
2.11.0
