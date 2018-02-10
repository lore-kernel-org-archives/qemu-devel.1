Received: from eggs.gnu.org ([2001:4830:134:3::10]:43943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ekQ0F-0002e7-Ty
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 02:55:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ekQ0B-0000e7-VF
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 02:55:19 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sat, 10 Feb 2018 10:55:00 +0300
Message-Id: <57bf554cf4f486d2e89860cf285cc8502ef61d63.1518249254.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
References: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
References: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] =?utf-8?q?=5BPULL_05/17=5D_mailmap=3A_set_preferred_?=
 =?utf-8?q?spelling_for_Daniel_Berrang=C3=A9?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
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
2.11.0
