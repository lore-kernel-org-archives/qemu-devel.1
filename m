Received: from eggs.gnu.org ([2001:4830:134:3::10]:53627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gJhzm-0008No-Tz
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:44:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gJhzk-0001hL-LA
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:44:58 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  5 Nov 2018 17:43:39 +0100
Message-Id: <20181105164340.20707-6-cohuck@redhat.com>
In-Reply-To: <20181105164340.20707-1-cohuck@redhat.com>
References: <20181105164340.20707-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 5/6] MAINTAINERS: s390: Remove myself
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Collin Walling <walling@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: Alexander Graf <agraf@suse.de>

I haven't realistically maintained s390 related parts for quite a while
now, so let's remove my name from the MAINTAINERS file to reflect reality.

Signed-off-by: Alexander Graf <agraf@suse.de>
Message-Id: <20181030093715.18793-1-agraf@suse.de>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 MAINTAINERS | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 15709e099b..e0e8b5fb9e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -253,7 +253,6 @@ F: disas/riscv.c
 
 S390
 M: Richard Henderson <rth@twiddle.net>
-M: Alexander Graf <agraf@suse.de>
 M: David Hildenbrand <david@redhat.com>
 S: Maintained
 F: target/s390x/
@@ -349,7 +348,6 @@ F: target/ppc/kvm.c
 S390
 M: Christian Borntraeger <borntraeger@de.ibm.com>
 M: Cornelia Huck <cohuck@redhat.com>
-M: Alexander Graf <agraf@suse.de>
 S: Maintained
 F: target/s390x/kvm.c
 F: target/s390x/kvm_s390x.h
@@ -934,7 +932,6 @@ S390 Machines
 S390 Virtio-ccw
 M: Cornelia Huck <cohuck@redhat.com>
 M: Christian Borntraeger <borntraeger@de.ibm.com>
-M: Alexander Graf <agraf@suse.de>
 S: Supported
 F: hw/char/sclp*.[hc]
 F: hw/char/terminal3270.c
@@ -1998,7 +1995,6 @@ F: tcg/ppc/
 F: disas/ppc.c
 
 S390 target
-M: Alexander Graf <agraf@suse.de>
 M: Richard Henderson <rth@twiddle.net>
 S: Maintained
 F: tcg/s390/
-- 
2.14.5
