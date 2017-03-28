Received: from eggs.gnu.org ([2001:4830:134:3::10]:38083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1csmou-0006m9-Ml
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1csmor-0005qT-LJ
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:49:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59033)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1csmor-0005pK-CO
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:49:37 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2S8mnoS062215
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 04:49:36 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29fmmrg39b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 04:49:35 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 28 Mar 2017 04:49:34 -0400
Date: Tue, 28 Mar 2017 16:49:28 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
	<20170317031743.40128-15-bjsdjshi@linux.vnet.ibm.com>
	<20170321124716.19f90fd6@t450s.home>
	<20170322023422.GP10704@bjsdjshi@linux.vnet.ibm.com>
	<20170328101623.1b07cf1f.cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170328101623.1b07cf1f.cornelia.huck@de.ibm.com>
Message-Id: <20170328084928.GC22108@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 14/16] docs: add documentation for
 vfio-ccw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

* Cornelia Huck <cornelia.huck@de.ibm.com> [2017-03-28 10:16:23 +0200]:

[...]
> > 
> > @Conny, please correct me if my understanding is not right.
> 
> No, it's fine.
Thanks!

> 
> FWIW:
> https://virtualpenguins.blogspot.com/2017/02/channel-io-demystified.html
> 
> (I plan to write more in the future.)
That's a very good sharing.

> 
[...]

-- 
Dong Jia Shi
