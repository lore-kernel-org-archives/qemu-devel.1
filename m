Received: from eggs.gnu.org ([2001:4830:134:3::10]:34663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRbo4-0001Eu-0n
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:45:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRbo3-000294-98
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:45:31 -0500
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-16-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <8d624826-9dc0-472b-0b1a-d0695ef507d8@vivier.eu>
Date: Tue, 27 Nov 2018 12:45:18 +0100
MIME-Version: 1.0
In-Reply-To: <20181125205000.10324-16-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH for-3.1 15/25] MAINTAINERS:
 Add missing entries for the Canon DIGIC machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>, Antony Pavlov <antonynpavlov@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-trivial@nongnu.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 25/11/2018 21:49, Philippe Mathieu-Daudé wrote:
> This pattern now also matches:
> - include/hw/timer/digic-timer.h
> - include/hw/char/digic-uart.h
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index eab0fb9742..e04f2f1a44 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -527,6 +527,7 @@ L: qemu-arm@nongnu.org
>  S: Odd Fixes
>  F: include/hw/arm/digic.h
>  F: hw/*/digic*
> +F: include/hw/*/digic*
>  
>  Gumstix
>  M: Peter Maydell <peter.maydell@linaro.org>
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
