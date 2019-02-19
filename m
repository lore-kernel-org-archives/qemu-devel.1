Received: from eggs.gnu.org ([209.51.188.92]:51339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gw0u9-0000L1-LS
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:37:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gw0u7-0004Ej-OS
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:37:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gw0u5-0004E0-Pt
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:37:27 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 19 Feb 2019 09:36:57 +0100
Message-Id: <1550565421-10944-11-git-send-email-thuth@redhat.com>
In-Reply-To: <1550565421-10944-1-git-send-email-thuth@redhat.com>
References: <1550565421-10944-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/14] MAINTAINERS: Add maintainer to the
 TCG/i386 subsystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Richard Henderson <rth@twiddle.net>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Richard obviously maintains this subdirectory, make this official :)

Remove the qemu-devel@nongnu.org entry because the list is always
selected by the 'All patches CC here' section.

Cc: Richard Henderson <rth@twiddle.net>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e6e08c2..b00caaf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2213,7 +2213,7 @@ F: tcg/arm/
 F: disas/arm.c
=20
 i386 target
-L: qemu-devel@nongnu.org
+M: Richard Henderson <rth@twiddle.net>
 S: Maintained
 F: tcg/i386/
 F: disas/i386.c
--=20
1.8.3.1
