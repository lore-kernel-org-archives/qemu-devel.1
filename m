Received: from eggs.gnu.org ([2001:4830:134:3::10]:42844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gH9gq-0004on-7X
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gH9gp-0008IP-7I
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:42:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42548
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gH9go-00088R-TG
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:42:51 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9TFdm9C006694
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 11:42:35 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ne4q3hcqu-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 11:42:35 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 29 Oct 2018 09:42:34 -0600
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 29 Oct 2018 16:42:21 +0100
Message-Id: <1540827745-20795-1-git-send-email-borntraeger@de.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH 0/4] MAINTAINERS: s390: several updates
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

I discussed the following maintainer updates at the kvm forum with
Conny. This is the first set of changes.
Can the affected persons please Ack the relevant patches?

PS: Alex, do you still want to be listed?

Christian Borntraeger (4):
  MAINTAINERS: s390: more maintainers for vfio-ccw
  MAINTAINERS: s390/virtio-ccw: drop Christian add Halil
  MAINTAINERS: s390/pci: add Collin Walling as maintainer for zpci
  MAINTAINERS: s390/boot: the ipl code and the bios belong together

 MAINTAINERS | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

-- 
1.8.3.1
