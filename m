Received: from eggs.gnu.org ([2001:4830:134:3::10]:40761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLfW-00082k-Vo
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:46:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLfU-0004Z8-Kq
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:46:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duLfU-0004YV-F9
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:46:40 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Sep 2017 18:43:37 +0200
Message-Id: <20170919164337.18555-39-cohuck@redhat.com>
In-Reply-To: <20170919164337.18555-1-cohuck@redhat.com>
References: <20170919164337.18555-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL v2 38/38] MAINTAINERS/s390x: add terminal3270.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: Christian Borntraeger <borntraeger@de.ibm.com>

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Message-Id: <20170918130455.144262-1-borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ef7c191dbb..3d735979ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -789,6 +789,7 @@ M: Christian Borntraeger <borntraeger@de.ibm.com>
 M: Alexander Graf <agraf@suse.de>
 S: Supported
 F: hw/char/sclp*.[hc]
+F: hw/char/terminal3270.c
 F: hw/s390x/
 F: include/hw/s390x/
 F: pc-bios/s390-ccw/
-- 
2.13.5
