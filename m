Received: from eggs.gnu.org ([2001:4830:134:3::10]:38094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ehg4j-00078D-Fl
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 13:31:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ehg3P-00071W-Hy
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 13:28:37 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri,  2 Feb 2018 18:26:59 +0000
Message-Id: <20180202182659.32033-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] =?utf-8?q?=5BPATCH=5D_mailmap=3A_set_preferred_spell?=
 =?utf-8?q?ing_for_Daniel_Berrang=C3=A9?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 .mailmap | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.mailmap b/.mailmap
index ee81ac801e..cf689b9ec9 100644
--- a/.mailmap
+++ b/.mailmap
@@ -18,3 +18,7 @@ malc <av1474@comtv.ru> malc <malc@c046a42c-6fe2-441c-8c=
8c-71466251a162>
 # There is also a:
 #    (no author) <(no author)@c046a42c-6fe2-441c-8c8c-71466251a162>
 # for the cvs2svn initialization commit e63c3dc74bf.
+#
+# Also list preferred name forms where people have changed their
+# git author config
+Daniel P. Berrang=C3=A9 <berrange@redhat.com>
--=20
2.14.3
