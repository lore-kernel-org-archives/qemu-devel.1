Received: from eggs.gnu.org ([2001:4830:134:3::10]:53321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1d8ick-0007fA-70
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1d8icg-0002s3-7U
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:34:58 -0400
Received: from jessie.kos.to ([212.47.231.226]:54316 helo=pilvi.kos.to)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <voipio@kos.to>) id 1d8icg-0002qO-2L
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:34:54 -0400
Date: Thu, 11 May 2017 07:34:48 +0000
From: Riku Voipio <riku.voipio@iki.fi>
Message-ID: <20170511073448.GA11462@kos.to>
References: <20170510153950.29343-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170510153950.29343-1-laurent@vivier.eu>
Subject: Re: [Qemu-devel] [PATCH] maintainers: Add myself as linux-user
 reviewer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, May 10, 2017 at 05:39:50PM +0200, Laurent Vivier wrote:
> I volunteer to review linux-user patches.
> Adding myself will help to not miss some of them.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Acked-by: Riku Voipio <riku.voipio@linaro.org>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8224be0..c9eed8a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1577,6 +1577,7 @@ F: default-configs/*-bsd-user.mak
>  
>  Linux user
>  M: Riku Voipio <riku.voipio@iki.fi>
> +R: Laurent Vivier <laurent@vivier.eu>
>  S: Maintained
>  F: linux-user/
>  F: default-configs/*-linux-user.mak
> -- 
> 2.9.3
> 
