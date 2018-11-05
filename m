Received: from eggs.gnu.org ([2001:4830:134:3::10]:53633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gJhzm-0008Nz-Uj
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:44:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gJhzl-0001iS-Dv
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:44:58 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  5 Nov 2018 17:43:38 +0100
Message-Id: <20181105164340.20707-5-cohuck@redhat.com>
In-Reply-To: <20181105164340.20707-1-cohuck@redhat.com>
References: <20181105164340.20707-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 4/6] MAINTAINERS: s390/pci: add Collin Walling
 as maintainer for zpci
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

From: Christian Borntraeger <borntraeger@de.ibm.com>

Collin will take over the maintainership from Yi Min. Let us add a
separate s390 pci section.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <1540827745-20795-4-git-send-email-borntraeger@de.ibm.com>
Acked-by: Collin Walling <walling@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b6f4a2f3f..15709e099b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -956,6 +956,12 @@ F: pc-bios/s390-ccw.img
 T: git git://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
 
+S390 PCI
+M: Collin Walling <walling@linux.ibm.com>
+S: Supported
+F: hw/s390x/s390-pci*
+L: qemu-s390x@nongnu.org
+
 UniCore32 Machines
 -------------
 PKUnity-3 SoC initramfs-with-busybox
-- 
2.14.5
