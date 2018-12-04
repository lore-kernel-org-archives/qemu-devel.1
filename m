Received: from eggs.gnu.org ([208.118.235.92]:43656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gUCCl-0005nr-Et
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:01:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gUCCf-00006R-Pu
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:01:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24421
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gUCCf-000061-F0
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:01:37 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB4Ex43n119255
	for <qemu-devel@nongnu.org>; Tue, 4 Dec 2018 10:01:36 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p5ur3gmrp-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 10:01:31 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Tue, 4 Dec 2018 15:01:29 -0000
Date: Tue, 4 Dec 2018 16:01:24 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20181204133802.100998-1-borntraeger@de.ibm.com>
References: <20181204133802.100998-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20181204160124.48a32fbe@oc2783563651>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] s390/MAINTAINERS: Add Halil
 as kvm and machine maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>

On Tue,  4 Dec 2018 14:38:02 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Halil does more work in this area than I do right now. Lets add Halil.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Acked-by: Halil Pasic <pasic@linux.ibm.com>

> ---
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 63effdc473..76fbf1331a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -365,8 +365,9 @@ S: Maintained
>  F: target/ppc/kvm.c
>  
>  S390
> -M: Christian Borntraeger <borntraeger@de.ibm.com>
> +M: Halil Pasic <pasic@linux.ibm.com>
>  M: Cornelia Huck <cohuck@redhat.com>
> +M: Christian Borntraeger <borntraeger@de.ibm.com>
>  S: Maintained
>  F: target/s390x/kvm.c
>  F: target/s390x/kvm_s390x.h
> @@ -1057,6 +1058,7 @@ S390 Machines
>  -------------
>  S390 Virtio-ccw
>  M: Cornelia Huck <cohuck@redhat.com>
> +M: Halil Pasic <pasic@linux.ibm.com>
>  M: Christian Borntraeger <borntraeger@de.ibm.com>
>  S: Supported
>  F: hw/char/sclp*.[hc]
