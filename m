Received: from eggs.gnu.org ([2001:4830:134:3::10]:58875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e08BM-0007D0-QJ
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:35:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e08BL-0002dT-KH
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:35:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1e08BL-0002ca-4X
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:35:27 -0400
References: <20171005151313.32015-1-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <15dac164-afa4-91d1-53f7-8ce828da340a@redhat.com>
Date: Thu, 5 Oct 2017 17:35:18 +0200
MIME-Version: 1.0
In-Reply-To: <20171005151313.32015-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x/MAINTAINERS: add mailing list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, david@redhat.com

On 05.10.2017 17:13, Cornelia Huck wrote:
> There's a new qemu-s390x@nongnu.org mailing list: add it to the
> s390 sections.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 772ac209e1..f1b096ca08 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -216,6 +216,7 @@ S: Maintained
>  F: target/s390x/
>  F: hw/s390x/
>  F: disas/s390.c
> +L: qemu-s390x@nongnu.org
>  
>  SH4
>  M: Aurelien Jarno <aurelien@aurel32.net>
> @@ -309,6 +310,7 @@ F: include/hw/s390x/s390_flic.h
>  F: gdb-xml/s390*.xml
>  T: git git://github.com/cohuck/qemu.git s390-next
>  T: git git://github.com/borntraeger/qemu.git s390-next
> +L: qemu-s390x@nongnu.org
>  
>  X86
>  M: Paolo Bonzini <pbonzini@redhat.com>
> @@ -807,6 +809,7 @@ F: pc-bios/s390-ccw.img
>  F: default-configs/s390x-softmmu.mak
>  T: git git://github.com/cohuck/qemu.git s390-next
>  T: git git://github.com/borntraeger/qemu.git s390-next
> +L: qemu-s390x@nongnu.org
>  
>  UniCore32 Machines
>  -------------
> @@ -1036,6 +1039,7 @@ F: hw/vfio/ccw.c
>  F: hw/s390x/s390-ccw.c
>  F: include/hw/s390x/s390-ccw.h
>  T: git git://github.com/cohuck/qemu.git s390-next
> +L: qemu-s390x@nongnu.org
>  
>  vhost
>  M: Michael S. Tsirkin <mst@redhat.com>
> @@ -1079,6 +1083,7 @@ S: Supported
>  F: hw/s390x/virtio-ccw.[hc]
>  T: git git://github.com/cohuck/qemu.git s390-next
>  T: git git://github.com/borntraeger/qemu.git s390-next
> +L: qemu-s390x@nongnu.org
>  
>  virtio-input
>  M: Gerd Hoffmann <kraxel@redhat.com>
> @@ -1709,6 +1714,7 @@ M: Richard Henderson <rth@twiddle.net>
>  S: Maintained
>  F: tcg/s390/
>  F: disas/s390.c
> +L: qemu-s390x@nongnu.org
>  
>  SPARC target
>  S: Odd Fixes

Reviewed-by: Thomas Huth <thuth@redhat.com>
