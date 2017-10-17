Received: from eggs.gnu.org ([2001:4830:134:3::10]:55256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1e4STp-0005yo-HH
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:04:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1e4STj-0003ya-Hz
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:04:25 -0400
References: <20171017131708.1892-1-james.hogan@mips.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <d3216ad9-9dda-9658-2659-2311fb0c67ae@vivier.eu>
Date: Tue, 17 Oct 2017 16:03:04 +0200
MIME-Version: 1.0
In-Reply-To: <20171017131708.1892-1-james.hogan@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] Update James Hogan's email address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: James Hogan <james.hogan@mips.com>, qemu-devel@nongnu.org
Cc: James Hogan <jhogan@kernel.org>, Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org

Le 17/10/2017 à 15:17, James Hogan a écrit :
> From: James Hogan <jhogan@kernel.org>
> 
> Update my imgtec.com email address to my kernel.org one in MAINTAINERS
> as MIPS will soon no longer be part of Imagination Technologies, and add
> a mapping in .mailcap so get_maintainer.pl reports the right address.
> 
> Signed-off-by: James Hogan <jhogan@kernel.org>

I think it would be  better if you send the patch with your imgtec
address (if it is always available) as it identifies the current maintainer.

Thanks,
Laurent

> Cc: Michael Tokarev <mjt@tls.msk.ru>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-trivial@nongnu.org
> ---
>  .mailmap    | 1 +
>  MAINTAINERS | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 28defa1b2c57..5aec1bdf9f7d 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -8,6 +8,7 @@ Aurelien Jarno <aurelien@aurel32.net> aurel32 <aurel32@c046a42c-6fe2-441c-8c8c-7
>  Blue Swirl <blauwirbel@gmail.com> blueswir1 <blueswir1@c046a42c-6fe2-441c-8c8c-71466251a162>
>  Edgar E. Iglesias <edgar.iglesias@gmail.com> edgar_igl <edgar_igl@c046a42c-6fe2-441c-8c8c-71466251a162>
>  Fabrice Bellard <fabrice@bellard.org> bellard <bellard@c046a42c-6fe2-441c-8c8c-71466251a162>
> +James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
>  Jocelyn Mayer <l_indien@magic.fr> j_mayer <j_mayer@c046a42c-6fe2-441c-8c8c-71466251a162>
>  Paul Brook <paul@codesourcery.com> pbrook <pbrook@c046a42c-6fe2-441c-8c8c-71466251a162>
>  Thiemo Seufer <ths@networkno.de> ths <ths@c046a42c-6fe2-441c-8c8c-71466251a162>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9522d1b621bd..b01f5c46ef83 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -284,7 +284,7 @@ S: Maintained
>  F: target/arm/kvm.c
>  
>  MIPS
> -M: James Hogan <james.hogan@imgtec.com>
> +M: James Hogan <jhogan@kernel.org>
>  S: Maintained
>  F: target/mips/kvm.c
>  
> 
