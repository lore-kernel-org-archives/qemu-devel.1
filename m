Received: from eggs.gnu.org ([2001:4830:134:3::10]:42981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gH9gu-0004tG-Kr
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:42:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gH9go-0008IB-Oh
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:42:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gH9go-0008Bk-E6
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:42:50 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9TFdlU8078821
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 11:42:42 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ne3kmd7qm-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 11:42:41 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 29 Oct 2018 09:42:41 -0600
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 29 Oct 2018 16:42:23 +0100
In-Reply-To: <1540827745-20795-1-git-send-email-borntraeger@de.ibm.com>
References: <1540827745-20795-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1540827745-20795-3-git-send-email-borntraeger@de.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH 2/4] MAINTAINERS: s390/virtio-ccw: drop
 Christian add Halil
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Halil does all the work anyway.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 10045b6..cb23555 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1262,7 +1262,7 @@ T: git git://github.com/stefanha/qemu.git block
=20
 virtio-ccw
 M: Cornelia Huck <cohuck@redhat.com>
-M: Christian Borntraeger <borntraeger@de.ibm.com>
+M: Halil Pasic <pasic@linux.ibm.com>
 S: Supported
 F: hw/s390x/virtio-ccw*.[hc]
 F: hw/s390x/vhost-vsock-ccw.c
--=20
1.8.3.1
