Received: from eggs.gnu.org ([209.51.188.92]:44638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gkBfh-0006qR-CG
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:41:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gkBfg-000622-Ky
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:41:41 -0500
References: <20190117161355.18204-1-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e2f9de70-247c-79fb-20f8-3e3453536ae3@vivier.eu>
Date: Thu, 17 Jan 2019 18:41:22 +0100
MIME-Version: 1.0
In-Reply-To: <20190117161355.18204-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] MAINTAINERS: Fix utf-8
 mangling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 17/01/2019 17:13, Philippe Mathieu-Daudé wrote:
> Patch incorrectly applied as 15ffb43cbf4.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> Paolo can this be a patchew bug?
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index af339b86db..fd3d4de3fa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1639,7 +1639,7 @@ F: include/hw/display/edid.h
>   F: qemu-edid.c
>   
>   Firmware configuration (fw_cfg)
> -M: Philippe Mathieu-DaudÃ© <philmd@redhat.com>
> +M: Philippe Mathieu-Daudé <philmd@redhat.com>
>   R: Laszlo Ersek <lersek@redhat.com>
>   R: Gerd Hoffmann <kraxel@redhat.com>
>   S: Supported
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
