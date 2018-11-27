Received: from eggs.gnu.org ([2001:4830:134:3::10]:59453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRbf4-0002QN-2I
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:36:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRbez-0004zu-16
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:36:14 -0500
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-6-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <905e949b-eb1d-0f31-ffc2-21c3c3252917@vivier.eu>
Date: Tue, 27 Nov 2018 12:35:58 +0100
MIME-Version: 1.0
In-Reply-To: <20181125205000.10324-6-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH for-3.1 05/25] MAINTAINERS:
 Add missing entries for the Jazz machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 25/11/2018 21:49, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 007f89f126..4e396cbe71 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -835,6 +835,8 @@ M: Hervé Poussineau <hpoussin@reactos.org>
>  R: Stefan Markovic <smarkovic@wavecomp.com>
>  S: Maintained
>  F: hw/mips/mips_jazz.c
> +F: hw/display/jazz_led.c
> +F: hw/dma/rc4030.c
>  
>  Malta
>  M: Aurelien Jarno <aurelien@aurel32.net>
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
