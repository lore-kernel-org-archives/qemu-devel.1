Received: from eggs.gnu.org ([2001:4830:134:3::10]:52167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <raimue@codingfarm.de>) id 1f2flR-0001JJ-Aj
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 12:23:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <raimue@codingfarm.de>) id 1f2flQ-00018F-Ff
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 12:23:29 -0400
Received: from donkey.codingfarm.de ([2a01:4f8:190:12cf::d:1]:37494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <raimue@codingfarm.de>)
	id 1f2flQ-00017T-99
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 12:23:28 -0400
From: =?UTF-8?q?Rainer=20M=C3=BCller?= <raimue@macports.org>
Date: Sun,  1 Apr 2018 18:22:58 +0200
Message-Id: <20180401162258.36206-1-raimue@macports.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [qemu-web PATCH] download: Add instructions for
 MacPorts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Rainer=20M=C3=BCller?= <raimue@macports.org>

Signed-off-by: Rainer M=C3=BCller <raimue@macports.org>
---
 _download/macos.md | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/_download/macos.md b/_download/macos.md
index dbb312c..06aa811 100644
--- a/_download/macos.md
+++ b/_download/macos.md
@@ -1,6 +1,10 @@
-QEMU can be installed from Homebrew:
+QEMU can be installed from <strong>Homebrew</strong>:
=20
 <pre>brew install qemu</pre>
=20
+QEMU can be installed from <strong>MacPorts</strong>:
+
+<pre>sudo port install qemu</pre>
+
 QEMU requires Mac OS X 10.5 or later, but it is recommended
 to use Mac OS X 10.7 or later.
--=20
2.16.3
