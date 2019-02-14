Received: from eggs.gnu.org ([209.51.188.92]:35562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1guL75-0004c9-5F
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:47:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1guL73-0004JR-Ed
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:47:55 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:52303 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1guL6z-0004C6-Ds
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:47:51 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 14 Feb 2019 18:47:16 +0100
Message-Id: <1550166444-22882-8-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550166444-22882-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1550166444-22882-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/15] tests/tcg: target/mips: Remove an
 unnecessary file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Remove a file that was added long time ago by mistake. The commit
that introduced this file was commit d70080c4 (from 2012).

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/tcg/mips/mips64-dspr2/.directory | 2 --
 1 file changed, 2 deletions(-)
 delete mode 100644 tests/tcg/mips/mips64-dspr2/.directory

diff --git a/tests/tcg/mips/mips64-dspr2/.directory b/tests/tcg/mips/mips=
64-dspr2/.directory
deleted file mode 100644
index c75a914..0000000
--- a/tests/tcg/mips/mips64-dspr2/.directory
+++ /dev/null
@@ -1,2 +0,0 @@
-[Dolphin]
-Timestamp=3D2012,8,3,16,41,52
--=20
2.7.4
