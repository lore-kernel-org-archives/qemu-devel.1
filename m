Received: from eggs.gnu.org ([2001:4830:134:3::10]:52855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fOqTJ-0003lm-E2
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 16:16:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fOqTE-0005Ry-4t
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 16:16:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51144
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1fOqTD-0005Of-TZ
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 16:16:20 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w51KEpil011902
	for <qemu-devel@nongnu.org>; Fri, 1 Jun 2018 16:16:19 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2jbbqh31gr-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 16:16:18 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Fri, 1 Jun 2018 16:16:18 -0400
References: <1527671818-23809-1-git-send-email-thuth@redhat.com>
	<1527671818-23809-4-git-send-email-thuth@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Fri, 1 Jun 2018 16:16:14 -0400
MIME-Version: 1.0
In-Reply-To: <1527671818-23809-4-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <7b423e5f-2825-9a7c-8d3f-468559ec4954@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] pc-bios/s390-ccw/net: Try to load
 pxelinux.cfg file accoring to the UUID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>


Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
