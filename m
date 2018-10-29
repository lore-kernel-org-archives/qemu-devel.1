Received: from eggs.gnu.org ([2001:4830:134:3::10]:40442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gHDCV-0007bz-KG
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 15:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gHDCS-0004j4-9W
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 15:27:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1gHDCO-0004Se-Ts
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 15:27:42 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9TJOZWj025597
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 15:27:20 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ne53qsadf-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 15:27:20 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Mon, 29 Oct 2018 15:27:18 -0400
References: <1540827745-20795-1-git-send-email-borntraeger@de.ibm.com>
	<1540827745-20795-2-git-send-email-borntraeger@de.ibm.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Mon, 29 Oct 2018 15:27:10 -0400
MIME-Version: 1.0
In-Reply-To: <1540827745-20795-2-git-send-email-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <b8ec6e13-0837-7855-cdaa-736e095f13e6@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] MAINTAINERS: s390: more maintainers
 for vfio-ccw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>



On 10/29/2018 11:42 AM, Christian Borntraeger wrote:
> Eric and Farhan will help with maintaining vfio-ccw.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d794bd7..10045b6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1204,6 +1204,8 @@ F: include/hw/vfio/
>   
>   vfio-ccw
>   M: Cornelia Huck <cohuck@redhat.com>
> +M: Eric Farman <farman@linux.ibm.com>
> +M: Farhan Ali <alifm@linux.ibm.com>
>   S: Supported
>   F: hw/vfio/ccw.c
>   F: hw/s390x/s390-ccw.c
> 

Acked-by: Farhan Ali <alifm@linux.ibm.com>
