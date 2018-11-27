Received: from eggs.gnu.org ([2001:4830:134:3::10]:32860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRbjt-0006Kq-Ph
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:41:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRbjt-0007MW-3y
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:41:13 -0500
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-13-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <2d915b44-99a1-df2b-2531-b793cdde95c6@vivier.eu>
Date: Tue, 27 Nov 2018 12:41:00 +0100
MIME-Version: 1.0
In-Reply-To: <20181125205000.10324-13-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH for-3.1 12/25] MAINTAINERS:
 Add missing entries to the PC Chipset section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 25/11/2018 21:49, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9f89e37a1e..bfe71f2555 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1126,11 +1126,13 @@ F: hw/timer/hpet*
>  F: hw/timer/i8254*
>  F: hw/timer/mc146818rtc*
>  F: hw/watchdog/wdt_ib700.c
> +F: hw/watchdog/wdt_i6300esb.c
>  F: include/hw/display/vga.h
>  F: include/hw/char/parallel.h
>  F: include/hw/dma/i8257.h
>  F: include/hw/i2c/pm_smbus.h
>  F: include/hw/input/i8042.h
> +F: include/hw/isa/i8259_internal.h
>  F: include/hw/isa/superio.h
>  F: include/hw/timer/hpet.h
>  F: include/hw/timer/i8254*
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
