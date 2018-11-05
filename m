Received: from eggs.gnu.org ([2001:4830:134:3::10]:53732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gJhzp-0000Ig-4t
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:45:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gJhzo-0001mv-A6
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:45:00 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  5 Nov 2018 17:43:37 +0100
Message-Id: <20181105164340.20707-4-cohuck@redhat.com>
In-Reply-To: <20181105164340.20707-1-cohuck@redhat.com>
References: <20181105164340.20707-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 3/6] MAINTAINERS: s390/virtio-ccw: drop
 Christian, add Halil
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

Halil does all the work anyway.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <1540827745-20795-3-git-send-email-borntraeger@de.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2909cd05b3..5b6f4a2f3f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1263,7 +1263,7 @@ T: git git://github.com/stefanha/qemu.git block
 
 virtio-ccw
 M: Cornelia Huck <cohuck@redhat.com>
-M: Christian Borntraeger <borntraeger@de.ibm.com>
+M: Halil Pasic <pasic@linux.ibm.com>
 S: Supported
 F: hw/s390x/virtio-ccw*.[hc]
 F: hw/s390x/vhost-vsock-ccw.c
-- 
2.14.5
