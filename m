Received: from eggs.gnu.org ([2001:4830:134:3::10]:41292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eM7xn-0002mM-UV
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 02:48:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eM7xj-0002wD-Uq
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 02:48:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1eM7xj-0002w1-Lw
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 02:48:19 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB57mGpv095647
	for <qemu-devel@nongnu.org>; Tue, 5 Dec 2017 02:48:17 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2enq42gq27-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 02:48:16 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 5 Dec 2017 02:48:15 -0500
Date: Tue, 5 Dec 2017 15:48:10 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20171201143136.62497-1-pasic@linux.vnet.ibm.com>
	<20171201143136.62497-4-pasic@linux.vnet.ibm.com>
	<20171204122859.1a4fcd21.cohuck@redhat.com>
	<1108d0e7-318b-354f-31da-95d5efb8193c@linux.vnet.ibm.com>
	<20171204171124.4d877b22.cohuck@redhat.com>
	<20171205074300.GZ5859@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171205074300.GZ5859@bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20171205074810.GA5859@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] s390x: deprecate s390-squash-mcss
 machine prop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

* Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> [2017-12-05 15:43:00 +0800]:

> * Cornelia Huck <cohuck@redhat.com> [2017-12-04 17:11:24 +0100]:
> 
> [...]
> 
> This one looks good to me too, so:
> Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> 
BTW, since we are deprecating s390-squash-mcss, I think any more
improment on it (e.g. more accurate and helpful hint message) is not
worthy. So I will not send such pathes in future, if nobody disagrees.

[...]

-- 
Dong Jia Shi
