Received: from eggs.gnu.org ([2001:4830:134:3::10]:41415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eLqnv-0003IK-Qz
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 08:29:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eLqns-0007W9-Nf
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 08:29:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35920
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eLqns-0007Vo-HV
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 08:29:00 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB4DOPCw008290
	for <qemu-devel@nongnu.org>; Mon, 4 Dec 2017 08:28:57 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2en46wa7wd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 04 Dec 2017 08:28:56 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 4 Dec 2017 11:18:38 -0000
References: <20171201143136.62497-1-pasic@linux.vnet.ibm.com>
	<20171201143136.62497-2-pasic@linux.vnet.ibm.com>
	<20171204121027.3acec545.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 4 Dec 2017 12:18:34 +0100
MIME-Version: 1.0
In-Reply-To: <20171204121027.3acec545.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <86403221-bb75-f2d2-0f74-919e329ae089@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] s390x/css: unrestrict cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org



On 12/04/2017 12:10 PM, Cornelia Huck wrote:
[..]
> 
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>

squashed or non-squashed:

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
