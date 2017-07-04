Received: from eggs.gnu.org ([2001:4830:134:3::10]:49209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dSKsT-00010r-PR
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 06:16:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dSKsO-00021Y-Si
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 06:16:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60406
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dSKsO-00021I-MD
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 06:16:12 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v64AE2qY119930
	for <qemu-devel@nongnu.org>; Tue, 4 Jul 2017 06:16:11 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bg6bgkhwh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 06:16:11 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 4 Jul 2017 06:16:10 -0400
References: <20170704092215.13742-1-cohuck@redhat.com>
	<20170704092215.13742-2-cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 4 Jul 2017 12:16:05 +0200
MIME-Version: 1.0
In-Reply-To: <20170704092215.13742-2-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <5b2264d5-eaa3-df0b-4a4c-95cf8fdd9f78@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] Update my email address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: agraf@suse.de

On 07/04/2017 11:22 AM, Cornelia Huck wrote:
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Thanks applied to my s390-next tree.


> ---
>  MAINTAINERS | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7df088259b..afc2b8b328 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -299,7 +299,7 @@ F: target/ppc/kvm.c
> 
>  S390
>  M: Christian Borntraeger <borntraeger@de.ibm.com>
> -M: Cornelia Huck <cornelia.huck@de.ibm.com>
> +M: Cornelia Huck <cohuck@redhat.com>
>  M: Alexander Graf <agraf@suse.de>
>  S: Maintained
>  F: target/s390x/kvm.c
> @@ -778,7 +778,7 @@ F: include/hw/sparc/grlib.h
>  S390 Machines
>  -------------
>  S390 Virtio-ccw
> -M: Cornelia Huck <cornelia.huck@de.ibm.com>
> +M: Cornelia Huck <cohuck@redhat.com>
>  M: Christian Borntraeger <borntraeger@de.ibm.com>
>  M: Alexander Graf <agraf@suse.de>
>  S: Supported
> @@ -1006,7 +1006,7 @@ F: hw/vfio/*
>  F: include/hw/vfio/
> 
>  vfio-ccw
> -M: Cornelia Huck <cornelia.huck@de.ibm.com>
> +M: Cornelia Huck <cohuck@redhat.com>
>  S: Supported
>  F: hw/vfio/ccw.c
>  F: hw/s390x/s390-ccw.c
> @@ -1048,7 +1048,7 @@ F: tests/virtio-blk-test.c
>  T: git git://github.com/stefanha/qemu.git block
> 
>  virtio-ccw
> -M: Cornelia Huck <cornelia.huck@de.ibm.com>
> +M: Cornelia Huck <cohuck@redhat.com>
>  M: Christian Borntraeger <borntraeger@de.ibm.com>
>  S: Supported
>  F: hw/s390x/virtio-ccw.[hc]
> 
