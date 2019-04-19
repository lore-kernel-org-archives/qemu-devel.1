Received: from eggs.gnu.org ([209.51.188.92]:50739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hHQbR-0003B4-2R
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 06:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hHQbQ-0002ut-6M
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 06:18:41 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:50033
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1hHQbP-0002u3-Uz
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 06:18:40 -0400
From: KONRAD Frederic <frederic.konrad@adacore.com>
Date: Fri, 19 Apr 2019 12:18:12 +0200
Message-Id: <1555669092-10351-4-git-send-email-frederic.konrad@adacore.com>
In-Reply-To: <1555669092-10351-1-git-send-email-frederic.konrad@adacore.com>
References: <1555669092-10351-1-git-send-email-frederic.konrad@adacore.com>
Subject: [Qemu-devel] [PATCH V1 3/3] MAINTAINERS: add myself for leon3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com, philmd@redhat.com, chouteau@adacore.com, frederic.konrad@adacore.com

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 56139ac..3543035 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1151,6 +1151,7 @@ F: include/hw/timer/sun4v-rtc.h
 
 Leon3
 M: Fabien Chouteau <chouteau@adacore.com>
+M: KONRAD Frederic <frederic.konrad@adacore.com>
 S: Maintained
 F: hw/sparc/leon3.c
 F: hw/*/grlib*
-- 
1.8.3.1
