Received: from eggs.gnu.org ([209.51.188.92]:51321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gw0u5-0000Gi-Oj
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:37:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gw0u4-0004Db-3E
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:37:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gw0u3-0004Cx-PM
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:37:24 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 623D91219D8
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 08:37:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 19 Feb 2019 09:36:55 +0100
Message-Id: <1550565421-10944-9-git-send-email-thuth@redhat.com>
In-Reply-To: <1550565421-10944-1-git-send-email-thuth@redhat.com>
References: <1550565421-10944-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 08/14] MAINTAINERS: Orphanize the 'GDB stub'
 subsystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
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
index 549f1f9..258ba5a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1811,8 +1811,7 @@ F: util/error.c
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
