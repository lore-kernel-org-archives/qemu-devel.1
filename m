Received: from eggs.gnu.org ([2001:4830:134:3::10]:34922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRboy-00021w-7r
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:46:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRbou-0002f8-9i
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:46:28 -0500
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-17-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <8f9d5d00-eac3-55a6-9b42-1c6fea3c1dcc@vivier.eu>
Date: Tue, 27 Nov 2018 12:46:17 +0100
MIME-Version: 1.0
In-Reply-To: <20181125205000.10324-17-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH for-3.1 16/25] MAINTAINERS:
 Add missing entries for the MPS2 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-trivial@nongnu.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 25/11/2018 21:49, Philippe Mathieu-Daudé wrote:
> Missed in de343bb632a.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e04f2f1a44..2795135a09 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -587,6 +587,8 @@ F: hw/misc/mps2-*.c
>  F: include/hw/misc/mps2-*.h
>  F: hw/arm/iotkit.c
>  F: include/hw/arm/iotkit.h
> +F: hw/misc/iotkit-secctl.c
> +F: include/hw/misc/iotkit-secctl.h
>  F: hw/misc/iotkit-sysctl.c
>  F: include/hw/misc/iotkit-sysctl.h
>  F: hw/misc/iotkit-sysinfo.c
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
