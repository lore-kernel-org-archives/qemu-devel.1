Received: from eggs.gnu.org ([2001:4830:134:3::10]:47297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1crDf8-0006iF-5z
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 21:05:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1crDf4-00046D-Pl
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 21:05:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1crDf4-00045u-Gi
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 21:05:02 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2O0wmoF059185
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 21:05:00 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29c4yx4mwk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 21:04:59 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Thu, 23 Mar 2017 19:04:59 -0600
Date: Fri, 24 Mar 2017 09:04:53 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
	<20170317031743.40128-3-bjsdjshi@linux.vnet.ibm.com>
	<alpine.LFD.2.20.1703231302221.3020@schleppi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1703231302221.3020@schleppi>
Message-Id: <20170324010453.GW10704@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 02/16] s390: cio: export more interfaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, Cornelia Huck <cornelia.huck@de.ibm.com>, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>

* Sebastian Ott <sebott@linux.vnet.ibm.com> [2017-03-23 13:02:46 +0100]:

> On Fri, 17 Mar 2017, Dong Jia Shi wrote:
> > Export the common I/O interfaces those are needed by an I/O
> > subchannel driver to actually talk to the subchannel.
> > 
> > Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> > Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>
> > Cc: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
> > ---
> 
> Acked-by: Sebastian Ott <sebott@linux.vnet.ibm.com>

Hi Sebastian,

Thanks for all of your acks!

-- 
Dong Jia Shi
