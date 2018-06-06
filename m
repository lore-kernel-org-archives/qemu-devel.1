Received: from eggs.gnu.org ([2001:4830:134:3::10]:56935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fQb6o-0000mL-S6
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 12:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fQb6n-0002IW-0n
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 12:16:26 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:35552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fQb6m-000286-QH
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 12:16:24 -0400
Date: Wed, 6 Jun 2018 15:14:07 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180606131407.c757uawwqjsp3hev@var.youpi.perso.aquilenet.fr>
References: <20180531194843.21172-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531194843.21172-1-samuel.thibault@ens-lyon.org>
Subject: Re: [Qemu-devel] [PATCH] slirp: Add Samuel Thibault's staging tree
 for slirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: jan.kiszka@siemens.com

Ping? I'm not sure who I am supposed to get a review from, or if I have
to have one at all?

Samuel

Samuel Thibault, le jeu. 31 mai 2018 21:48:43 +0200, a ecrit:
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 41cd3736a9..8822ae9b70 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1675,6 +1675,7 @@ S: Maintained
>  F: slirp/
>  F: net/slirp.c
>  F: include/net/slirp.h
> +T: git http://people.debian.org/~sthibault/qemu.git slirp
>  T: git git://git.kiszka.org/qemu.git queues/slirp
>  
>  Stubs
> -- 
> 2.17.0
> 
