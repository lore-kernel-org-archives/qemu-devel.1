Received: from eggs.gnu.org ([209.51.188.92]:51725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gudws-0005D7-JS
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:54:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gudwq-00031H-I7
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:54:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gudwo-0002aw-IA
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:54:36 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1FDi9JE122161
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 08:54:20 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qnwn7jyje-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 08:54:19 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Fri, 15 Feb 2019 13:54:17 -0000
Date: Fri, 15 Feb 2019 14:54:14 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20190213103519.32585-1-cohuck@redhat.com>
References: <20190213103519.32585-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190215145414.6f29423d@oc2783563651>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] s390x: upgrade status of KVM
 cores to "supported"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Wed, 13 Feb 2019 11:35:19 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> We are actually paid to look after this.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Acked-by: Halil Pasic <pasic@linux.ibm.com>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9a76845581b1..73ff5915638e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -377,7 +377,7 @@ S390
>  M: Halil Pasic <pasic@linux.ibm.com>
>  M: Cornelia Huck <cohuck@redhat.com>
>  M: Christian Borntraeger <borntraeger@de.ibm.com>
> -S: Maintained
> +S: Supported
>  F: target/s390x/kvm.c
>  F: target/s390x/kvm_s390x.h
>  F: target/s390x/kvm-stub.c
