Received: from eggs.gnu.org ([2001:4830:134:3::10]:54568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gJfKc-0000FT-I1
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:54:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gJfKV-0004wJ-Ia
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:54:17 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  5 Nov 2018 17:54:00 +0400
Message-Id: <20181105135400.18366-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] misc: fix spelling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index af7e9f09cc..4d2e2d9902 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4065,7 +4065,7 @@ arch_query_cpu_model_expansion(CpuModelExpansionTyp=
e type,
         x86_cpu_to_dict_full(xc, props);
     break;
     default:
-        error_setg(&err, "Unsupportted expansion type");
+        error_setg(&err, "Unsupported expansion type");
         goto out;
     }
=20
--=20
2.19.1.708.g4ede3d42df
