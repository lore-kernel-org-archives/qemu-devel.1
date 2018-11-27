Received: from eggs.gnu.org ([2001:4830:134:3::10]:60107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRbh5-0003oj-CP
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:38:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRbh4-0005ox-Q5
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:38:19 -0500
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-7-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <bbd65041-d216-f063-8d94-a11db5d730c9@vivier.eu>
Date: Tue, 27 Nov 2018 12:37:53 +0100
MIME-Version: 1.0
In-Reply-To: <20181125205000.10324-7-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH for-3.1 06/25] MAINTAINERS:
 Add a missing entry for the Xilinx S3A-DSP 1800 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-trivial@nongnu.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 25/11/2018 21:49, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4e396cbe71..aa17e9bbd3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -822,6 +822,7 @@ petalogix_s3adsp1800
>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>  S: Maintained
>  F: hw/microblaze/petalogix_s3adsp1800_mmu.c
> +include/hw/char/xilinx_uartlite.h
>  
>  petalogix_ml605
>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> 

I've added the missing 'F:' field.

Applied to my trivial-patches branch.

Thanks,
Laurent
