Received: from eggs.gnu.org ([2001:4830:134:3::10]:49358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e4C57-0000q5-JJ
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:33:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e4C54-0001wy-2f
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:33:49 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 16 Oct 2017 23:33:30 +0300
Message-Id: <439e91af8f24c308e753b9417d6c599d6007595a.1508185933.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
References: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
References: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/14] gitignore: ignore check-qlit test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>

test introduced in 382176b4d78e070d119af8e0dcd00884c11bbec2

Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 tests/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/.gitignore b/tests/.gitignore
index cf6d99c91e..53cb2efaee 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -6,6 +6,7 @@ check-qdict
 check-qnum
 check-qjson
 check-qlist
+check-qlit
 check-qnull
 check-qstring
 check-qom-interface
--=20
2.11.0
