Received: from eggs.gnu.org ([2001:4830:134:3::10]:56093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cluKJ-00010w-BZ
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 04:25:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cluKG-0007kk-8r
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 04:25:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39024)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1cluKF-0007eS-Ul
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 04:25:36 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v299NbFZ023280
	for <qemu-devel@nongnu.org>; Thu, 9 Mar 2017 04:25:32 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 292gtfure7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 04:25:32 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Thu, 9 Mar 2017 04:25:31 -0500
Date: Thu, 9 Mar 2017 17:25:25 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170217082939.33208-1-bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170217082939.33208-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170309092525.GA10189@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 00/15] basic vfio-ccw infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com

* Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> [2017-02-17 09:29:24 +0100]:

> vfio-ccw: the basic infrastructure
> ==================================
> 
> Introduction
> ------------
> 
> Here we describe the vfio support for I/O subchannel devices for
> Linux/s390. Motivation for vfio-ccw is to passthrough subchannels to a
> virtual machine, while vfio is the means.
> 

Ping.

Any more comment for this version?

Thanks.

[...]

-- 
Dong Jia
