Received: from eggs.gnu.org ([2001:4830:134:3::10]:59944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ejl1m-0006OD-0Z
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 07:10:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ejl1h-0007fW-ID
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 07:10:09 -0500
References: <20180207155531.28446-1-cohuck@redhat.com>
	<20180207155531.28446-4-cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ae6ace58-ea78-f254-1f5d-4d0d8987bcc0@redhat.com>
Date: Thu, 8 Feb 2018 13:09:52 +0100
MIME-Version: 1.0
In-Reply-To: <20180207155531.28446-4-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] MAINTAINERS: add David as additional
 tcg/s390 maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, thuth@redhat.com

On 07.02.2018 16:55, Cornelia Huck wrote:
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bd2dc7ed7c..b30d2ca23a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -236,6 +236,7 @@ F: disas/ppc.c
>  S390
>  M: Richard Henderson <rth@twiddle.net>
>  M: Alexander Graf <agraf@suse.de>
> +M: David Hildenbrand <david@redhat.com>
>  S: Maintained
>  F: target/s390x/
>  F: hw/s390x/
> 

Thanks for the trust!

Acked-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
