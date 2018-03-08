Received: from eggs.gnu.org ([2001:4830:134:3::10]:56737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu4DF-0007KP-Lw
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:40:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu4DA-0004LA-P6
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:40:37 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:54868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu4DA-0004Ju-3l
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:40:32 -0500
Received: by mail-wm0-x242.google.com with SMTP id z81so691031wmb.4
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 14:40:31 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu,  8 Mar 2018 23:39:42 +0100
Message-Id: <20180308223946.26784-22-f4bug@amsat.org>
In-Reply-To: <20180308223946.26784-1-f4bug@amsat.org>
References: <20180308223946.26784-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 21/25] MAINTAINERS: Split the Alpha TCG/machine
 section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Marcel Apfelbaum <marcel@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexey Kardashevskiy <aik@ozlabs.ru>, Yongbok Kim <yongbok.kim@mips.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index facdab44e1..e806491d6c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -127,7 +127,6 @@ Alpha
 M: Richard Henderson <rth@twiddle.net>
 S: Maintained
 F: target/alpha/
-F: hw/alpha/
 F: tests/tcg/alpha/
 F: disas/alpha.c
 
@@ -402,6 +401,11 @@ F: include/*/*win32*
 X: qga/*win32*
 F: qemu.nsi
 
+Alpha Machines
+M: Richard Henderson <rth@twiddle.net>
+S: Maintained
+F: hw/alpha/
+
 ARM Machines
 ------------
 Allwinner-a10
-- 
2.16.2
