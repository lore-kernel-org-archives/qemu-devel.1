Received: from eggs.gnu.org ([2001:4830:134:3::10]:59428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gHAMS-0000Fr-2U
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gHAMN-0007zh-Ca
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:25:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49708
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gHAMN-0007yj-2t
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:25:47 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9TGLIK7118078
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 12:25:44 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ne3brgpsx-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 12:25:44 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Mon, 29 Oct 2018 16:25:42 -0000
References: <1540827745-20795-1-git-send-email-borntraeger@de.ibm.com>
	<1540827745-20795-3-git-send-email-borntraeger@de.ibm.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Mon, 29 Oct 2018 17:25:35 +0100
MIME-Version: 1.0
In-Reply-To: <1540827745-20795-3-git-send-email-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <50c62050-aec5-327f-80a9-59dc2cc3ed5e@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] MAINTAINERS: s390/virtio-ccw: drop
 Christian add Halil
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>



On 10/29/2018 04:42 PM, Christian Borntraeger wrote:
> Halil does all the work anyway.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Acked-by: Halil Pasic <pasic@linux.ibm.com>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 10045b6..cb23555 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1262,7 +1262,7 @@ T: git git://github.com/stefanha/qemu.git block
>  
>  virtio-ccw
>  M: Cornelia Huck <cohuck@redhat.com>
> -M: Christian Borntraeger <borntraeger@de.ibm.com>
> +M: Halil Pasic <pasic@linux.ibm.com>
>  S: Supported
>  F: hw/s390x/virtio-ccw*.[hc]
>  F: hw/s390x/vhost-vsock-ccw.c
> 
