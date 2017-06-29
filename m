Received: from eggs.gnu.org ([2001:4830:134:3::10]:42638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQNrY-0003yx-Iz
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 21:03:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQNrX-0006vC-Pg
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 21:03:16 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQNrX-0006v3-Kz
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 21:03:15 -0400
Received: by mail-qt0-x243.google.com with SMTP id w12so9571271qta.2
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 18:03:15 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 28 Jun 2017 22:02:53 -0300
Message-Id: <20170629010300.2848-2-f4bug@amsat.org>
In-Reply-To: <20170629010300.2848-1-f4bug@amsat.org>
References: <20170629010300.2848-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/8] MAINTAINERS: update TCG entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>, Stefan Weil <sw@weilnetz.de>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Yang Zhong <yang.zhong@intel.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

moved in a9ded601..244f1441 to accel/

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 839f7ca063..06006fc7df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -84,14 +84,10 @@ M: Paolo Bonzini <pbonzini@redhat.com>
 M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
 M: Richard Henderson <rth@twiddle.net>
 S: Maintained
-F: cpu-exec.c
-F: cpu-exec-common.c
 F: cpus.c
-F: cputlb.c
 F: exec.c
 F: softmmu_template.h
-F: translate-all.*
-F: translate-common.c
+F: accel/tcg/
 F: include/exec/cpu*.h
 F: include/exec/exec-all.h
 F: include/exec/helper*.h
-- 
2.13.1
