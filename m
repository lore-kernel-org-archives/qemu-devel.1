Received: from eggs.gnu.org ([2001:4830:134:3::10]:41725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sebott@linux.vnet.ibm.com>) id 1cr1SG-00066H-2T
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 08:03:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sebott@linux.vnet.ibm.com>) id 1cr1SC-0001Ar-7Y
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 08:03:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sebott@linux.vnet.ibm.com>)
	id 1cr1SB-00019R-Uc
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 08:02:56 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2NBxIng124645
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 08:02:54 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29c4yw169d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 08:02:53 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sebott@linux.vnet.ibm.com>;
	Thu, 23 Mar 2017 12:02:51 -0000
Date: Thu, 23 Mar 2017 13:02:46 +0100 (CET)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
In-Reply-To: <20170317031743.40128-3-bjsdjshi@linux.vnet.ibm.com>
References: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
	<20170317031743.40128-3-bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <alpine.LFD.2.20.1703231302221.3020@schleppi>
Subject: Re: [Qemu-devel] [PATCH v4 02/16] s390: cio: export more interfaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, Cornelia Huck <cornelia.huck@de.ibm.com>, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>

On Fri, 17 Mar 2017, Dong Jia Shi wrote:
> Export the common I/O interfaces those are needed by an I/O
> subchannel driver to actually talk to the subchannel.
> 
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>
> Cc: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
> ---

Acked-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
