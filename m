Received: from eggs.gnu.org ([2001:4830:134:3::10]:53625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gJhzm-0008Ne-TY
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:44:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gJhzj-0001gh-Sl
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:44:58 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  5 Nov 2018 17:43:36 +0100
Message-Id: <20181105164340.20707-3-cohuck@redhat.com>
In-Reply-To: <20181105164340.20707-1-cohuck@redhat.com>
References: <20181105164340.20707-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 2/6] MAINTAINERS: s390: more maintainers for
 vfio-ccw
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

Eric and Farhan will help with maintaining vfio-ccw.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <1540827745-20795-2-git-send-email-borntraeger@de.ibm.com>
Acked-by: Eric Farman <farman@linux.ibm.com>
Acked-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 98a1856afc..2909cd05b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1205,6 +1205,8 @@ F: include/hw/vfio/
 
 vfio-ccw
 M: Cornelia Huck <cohuck@redhat.com>
+M: Eric Farman <farman@linux.ibm.com>
+M: Farhan Ali <alifm@linux.ibm.com>
 S: Supported
 F: hw/vfio/ccw.c
 F: hw/s390x/s390-ccw.c
-- 
2.14.5
