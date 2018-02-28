Received: from eggs.gnu.org ([2001:4830:134:3::10]:34683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eqwuj-0002aV-JB
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 03:16:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eqwuf-0004JB-2Y
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 03:16:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eqwue-0004Iw-QD
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 03:16:32 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1S8GPhH044495
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 03:16:31 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gdqaekb6k-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 03:16:31 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 28 Feb 2018 08:16:27 -0000
References: <20180227173251.17025-1-cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 28 Feb 2018 09:16:24 +0100
MIME-Version: 1.0
In-Reply-To: <20180227173251.17025-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <2d708050-88e1-a701-c3be-cefd604fde04@de.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] vfio-ccw: license text should
 indicate GPL v2 or later
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>

On 02/27/2018 06:32 PM, Cornelia Huck wrote:
> The license text currently specifies "any version" of the GPL. It
> is unlikely that GPL v1 was ever intended; change this to the
> standard "or any later version" text.
> 
> Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> Cc: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>  hw/vfio/ccw.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 16713f2c52..4e5855741a 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -6,8 +6,8 @@
>   *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
>   *            Pierre Morel <pmorel@linux.vnet.ibm.com>
>   *
> - * This work is licensed under the terms of the GNU GPL, version 2 or(at
> - * your option) any version. See the COPYING file in the top-level
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
>   * directory.
>   */
> 
