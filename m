Received: from eggs.gnu.org ([2001:4830:134:3::10]:46436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1d8vxg-0004FQ-JF
	for qemu-devel@nongnu.org; Thu, 11 May 2017 17:49:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1d8vxf-0001UT-QG
	for qemu-devel@nongnu.org; Thu, 11 May 2017 17:49:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1d8vxf-0001Tx-JQ
	for qemu-devel@nongnu.org; Thu, 11 May 2017 17:49:27 -0400
Date: Thu, 11 May 2017 15:49:23 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170511154923.1ed1c6fe@w520.home>
In-Reply-To: <20170505020352.8984-14-bjsdjshi@linux.vnet.ibm.com>
References: <20170505020352.8984-1-bjsdjshi@linux.vnet.ibm.com>
	<20170505020352.8984-14-bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 13/13] MAINTAINERS: Add vfio-ccw
 maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, eric.auger@redhat.com

On Fri,  5 May 2017 04:03:52 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> Add Cornelia Huck as the vfio-ccw maintainer.
> 
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---


Acked-by: Alex Williamson <alex.williamson@redhat.com>


>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cae3b09..c1f9917 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -999,6 +999,11 @@ S: Supported
>  F: hw/vfio/*
>  F: include/hw/vfio/
>  
> +vfio-ccw
> +M: Cornelia Huck <cornelia.huck@de.ibm.com>
> +S: Supported
> +F: hw/vfio/ccw.c
> +
>  vhost
>  M: Michael S. Tsirkin <mst@redhat.com>
>  S: Supported
