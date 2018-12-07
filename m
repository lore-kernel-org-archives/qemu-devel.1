Received: from eggs.gnu.org ([2001:4830:134:3::10]:60026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVJbP-00015e-OB
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 12:07:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVJbH-0000eK-SM
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 12:07:46 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri,  7 Dec 2018 11:07:33 -0600
Message-Id: <20181207170733.129532-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] maint: Grammar fix to mailmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, berrange@redhat.com

Make the sentence read better.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 .mailmap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index ed8faa57192..b8e08297c90 100644
--- a/.mailmap
+++ b/.mailmap
@@ -34,6 +34,6 @@ Justin Terry (VM) <juterry@microsoft.com> Justin Terry =
(VM) via Qemu-devel <qemu


 # Also list preferred name forms where people have changed their
-# git author config, or having utf8/latin1 encoding issues.
+# git author config, or had utf8/latin1 encoding issues.
 Daniel P. Berrang=C3=A9 <berrange@redhat.com>
 Reimar D=C3=B6ffinger <Reimar.Doeffinger@gmx.de>
--=20
2.17.2
