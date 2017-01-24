Received: from eggs.gnu.org ([2001:4830:134:3::10]:40605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVxZv-0005pB-8p
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:39:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVxZn-0000i1-7D
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:39:51 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 24 Jan 2017 12:39:13 +0300
Message-Id: <2c8c477ec1fe80e2b060c396d4126c81822af893.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/31] object.h: spelling fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/qom/object.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 5ecc2d1..c5e6fc1 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -432,7 +432,7 @@ struct Object
  * @class_base_init: This function is called for all base classes after =
all
  *   parent class initialization has occurred, but before the class itse=
lf
  *   is initialized.  This is the function to use to undo the effects of
- *   memcpy from the parent class to the descendents.
+ *   memcpy from the parent class to the descendants.
  * @class_finalize: This function is called during class destruction and=
 is
  *   meant to release and dynamic parameters allocated by @class_init.
  * @class_data: Data to pass to the @class_init, @class_base_init and
--=20
2.1.4
