Received: from eggs.gnu.org ([209.51.188.92]:52496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gvgqZ-00079z-Oo
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 06:12:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gvgqZ-0006vn-5x
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 06:12:27 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 18 Feb 2019 12:11:53 +0100
Message-Id: <20190218111153.22681-11-cohuck@redhat.com>
In-Reply-To: <20190218111153.22681-1-cohuck@redhat.com>
References: <20190218111153.22681-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 10/10] s390x: upgrade status of KVM cores to
 "supported"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

We are actually paid to look after this.

Message-Id: <20190213103519.32585-1-cohuck@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ffb029f63ac0..b1d786cfd87a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -375,7 +375,7 @@ S390
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Cornelia Huck <cohuck@redhat.com>
 M: Christian Borntraeger <borntraeger@de.ibm.com>
-S: Maintained
+S: Supported
 F: target/s390x/kvm.c
 F: target/s390x/kvm_s390x.h
 F: target/s390x/kvm-stub.c
-- 
2.17.2
