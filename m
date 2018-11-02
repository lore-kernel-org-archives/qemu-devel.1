Received: from eggs.gnu.org ([2001:4830:134:3::10]:50903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gId66-00023O-8H
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:19:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gId64-0004Hs-EI
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:19:01 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gId63-0002Zn-Qf
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:19:00 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gId3u-0003aI-5e
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 17:16:46 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Nov 2018 17:16:33 +0000
Message-Id: <20181102171638.24069-6-peter.maydell@linaro.org>
In-Reply-To: <20181102171638.24069-1-peter.maydell@linaro.org>
References: <20181102171638.24069-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/10] MAINTAINERS: Remove bouncing email in ARM
 ACPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Shannon Zhao's email at Huawei is bouncing: remove it.

    X-Failed-Recipients: zhaoshenglong@huawei.com
    ** Address not found **
    Your message wasn't delivered to zhaoshenglong@huawei.com because the address couldn't be found, or is unable to receive mail.

Note that the section still contains his personal email (see e59f13d76bb).

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Shannon Zhao <shannon.zhaosl@gmail.com>
Message-id: 20181029195931.8747-1-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 85f19f569ff..98a1856afc0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -627,7 +627,6 @@ F: hw/*/xlnx*.c
 F: include/hw/*/xlnx*.h
 
 ARM ACPI Subsystem
-M: Shannon Zhao <zhaoshenglong@huawei.com>
 M: Shannon Zhao <shannon.zhaosl@gmail.com>
 L: qemu-arm@nongnu.org
 S: Maintained
-- 
2.19.1
