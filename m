Received: from eggs.gnu.org ([2001:4830:134:3::10]:39054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1NO-00005Y-7l
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 15:51:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1NM-0005bs-Uc
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 15:51:34 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sun, 25 Nov 2018 21:49:38 +0100
Message-Id: <20181125205000.10324-4-philmd@redhat.com>
In-Reply-To: <20181125205000.10324-1-philmd@redhat.com>
References: <20181125205000.10324-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.1 03/25] MAINTAINERS: Add missing entries
 to the X86 section (AMD SEV)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ae12323647..3b9996ab2c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -300,8 +300,10 @@ F: target/i386/
 F: tests/tcg/i386/
 F: tests/tcg/x86_64/
 F: hw/i386/
+F: include/sysemu/sev.h
 F: disas/i386.c
 F: docs/qemu-cpu-models.texi
+F: docs/amd-memory-encryption.txt
 T: git https://github.com/ehabkost/qemu.git x86-next
=20
 Xtensa
--=20
2.17.2
