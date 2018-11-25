Received: from eggs.gnu.org ([2001:4830:134:3::10]:40061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1Oe-0001J4-KQ
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 15:52:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1OZ-0006SC-It
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 15:52:52 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sun, 25 Nov 2018 21:49:53 +0100
Message-Id: <20181125205000.10324-19-philmd@redhat.com>
In-Reply-To: <20181125205000.10324-1-philmd@redhat.com>
References: <20181125205000.10324-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.1 18/25] MAINTAINERS: Add missing entries
 for the QObject section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 28e5038c73..ac5d25491f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1846,12 +1846,18 @@ S: Supported
 F: qobject/
 F: include/qapi/qmp/
 X: include/qapi/qmp/dispatch.h
+F: include/qemu/qdist.h
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
+F: tests/test-qdist.c
+F: qdict-test-data.txt
 T: git https://repo.or.cz/qemu/armbru.git qapi-next
=20
 QEMU Guest Agent
--=20
2.17.2
