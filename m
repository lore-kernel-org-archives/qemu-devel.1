Received: from eggs.gnu.org ([2001:4830:134:3::10]:50849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dtw07-0003T4-41
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dtw01-0005kc-Ig
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:22:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dtw01-0005kD-Bv
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:22:09 -0400
Date: Mon, 18 Sep 2017 15:22:05 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170918152205.02b77fb6.cohuck@redhat.com>
In-Reply-To: <20170918130455.144262-1-borntraeger@de.ibm.com>
References: <20170918130455.144262-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS/s390x: add terminal3270.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Mon, 18 Sep 2017 15:04:55 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4bd1797..3cdaa52 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -789,6 +789,7 @@ M: Christian Borntraeger <borntraeger@de.ibm.com>
>  M: Alexander Graf <agraf@suse.de>
>  S: Supported
>  F: hw/char/sclp*.[hc]
> +F: hw/char/terminal3270.c
>  F: hw/s390x/
>  F: include/hw/s390x/
>  F: pc-bios/s390-ccw/

Thanks, applied.
