Received: from eggs.gnu.org ([2001:4830:134:3::10]:47478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=3460ce32a=anthony.perard@citrix.com>)
	id 1dQWrP-0000RT-Se
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:39:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=3460ce32a=anthony.perard@citrix.com>)
	id 1dQWrM-0008Ee-Mu
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:39:43 -0400
Received: from smtp.citrix.com ([66.165.176.89]:64682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=3460ce32a=anthony.perard@citrix.com>)
	id 1dQWrM-0008E5-GG
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:39:40 -0400
Date: Thu, 29 Jun 2017 11:39:36 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170629103936.GD1598@perard.uk.xensource.com>
References: <20170629010300.2848-1-f4bug@amsat.org>
	<20170629010300.2848-4-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170629010300.2848-4-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 3/8] MAINTAINERS: update Xen entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard
	Henderson <rth@twiddle.net>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>, Stefan Weil <sw@weilnetz.de>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Xu <anthony.xu@intel.com>

On Wed, Jun 28, 2017 at 10:02:55PM -0300, Philippe Mathieu-Daudé wrote:
> moved in 56e2cd24..28b99f47 to accel/

That is not accurate, files have been moved to hw/i386/xen/ as written
in both commits messages.

Beside that:
Acked-by: Anthony PERARD <anthony.perard@citrix.com>

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 86a08c5aac..530293044b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -323,7 +323,6 @@ M: Stefano Stabellini <sstabellini@kernel.org>
>  M: Anthony Perard <anthony.perard@citrix.com>
>  L: xen-devel@lists.xenproject.org
>  S: Supported
> -F: xen-*
>  F: */xen*
>  F: hw/9pfs/xen-9p-backend.c
>  F: hw/char/xen_console.c
> -- 
> 2.13.1
> 

-- 
Anthony PERARD
