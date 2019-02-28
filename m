Received: from eggs.gnu.org ([209.51.188.92]:51277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzKnK-0001LB-Az
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzKnI-0007RC-RL
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:12084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gzKnI-0007Q4-Jb
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:08 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 28 Feb 2019 13:27:45 +0100
Message-Id: <1551356875-30676-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1551356875-30676-1-git-send-email-thuth@redhat.com>
References: <1551356875-30676-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/13] MAINTAINERS: Add missing entries for the
 QObject section
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

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a034f9..4e38864 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1940,10 +1940,14 @@ F: include/qapi/qmp/
 X: include/qapi/qmp/dispatch.h
 F: scripts/coccinelle/qobject.cocci
 F: tests/check-qdict.c
-F: tests/check-qnum.c
 F: tests/check-qjson.c
 F: tests/check-qlist.c
+F: tests/check-qlit.c
+F: tests/check-qnull.c
+F: tests/check-qnum.c
+F: tests/check-qobject.c
 F: tests/check-qstring.c
+F: qdict-test-data.txt
 T: git https://repo.or.cz/qemu/armbru.git qapi-next
=20
 QEMU Guest Agent
--=20
1.8.3.1
