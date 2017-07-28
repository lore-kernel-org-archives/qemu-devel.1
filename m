Received: from eggs.gnu.org ([2001:4830:134:3::10]:51505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1dayuV-0007xH-Ar
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 02:38:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1dayuS-0007ce-Ku
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 02:38:07 -0400
Date: Fri, 28 Jul 2017 15:37:58 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20170728063758.GA3031@lianli.shorne-pla.net>
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-28-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170728053610.15770-28-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 27/47] MAINTAINERS: add missing OpenRISC
 entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On Fri, Jul 28, 2017 at 02:35:50AM -0300, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a4df19d304..35a7253e22 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -207,6 +207,7 @@ S: Odd Fixes
>  F: target/openrisc/
>  F: hw/openrisc/
>  F: tests/tcg/openrisc/
> +F: default-configs/or1k-softmmu.mak

This looks fine,

Acked-by: Stafford Horne <shorne@gmail.com>

>  PowerPC
>  M: David Gibson <david@gibson.dropbear.id.au>
> -- 
> 2.13.3
> 
