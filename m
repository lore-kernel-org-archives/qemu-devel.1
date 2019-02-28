Received: from eggs.gnu.org ([209.51.188.92]:51425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzKni-0001h3-0q
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzKnd-0007aQ-5h
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gzKnc-0007aB-Uv
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:29 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 28 Feb 2019 13:27:49 +0100
Message-Id: <1551356875-30676-8-git-send-email-thuth@redhat.com>
In-Reply-To: <1551356875-30676-1-git-send-email-thuth@redhat.com>
References: <1551356875-30676-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/13] MAINTAINERS: Orphanize the 'GDB stub'
 subsystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Nobody is looking at those files, downgrade this subsystem as orphan.

Remove the qemu-devel@nongnu.org entry because the list is always
selected by the 'All patches CC here' section.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 30a3359..ee73486 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1815,8 +1815,7 @@ F: util/error.c
 F: util/qemu-error.c
=20
 GDB stub
-L: qemu-devel@nongnu.org
-S: Odd Fixes
+S: Orphan
 F: gdbstub*
 F: gdb-xml/
=20
--=20
1.8.3.1
