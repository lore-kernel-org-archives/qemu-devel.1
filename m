Received: from eggs.gnu.org ([2001:4830:134:3::10]:32929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gFxX3-00052Z-Py
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 04:31:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gFxX0-0003FC-IY
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 04:31:49 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:52547)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gFxX0-0003Ax-9D
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 04:31:46 -0400
References: <1536150548-2797-1-git-send-email-liq3ea@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <537ead19-ec3a-ed4a-aab4-c51a8806d1bf@vivier.eu>
Date: Fri, 26 Oct 2018 09:31:22 +0100
MIME-Version: 1.0
In-Reply-To: <1536150548-2797-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] cpu.h: fix a typo in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, peter.maydell@linaro.org, richard.henderson@linaro.org
Cc: qemu-devel@nongnu.org

On 05/09/2018 13:29, Li Qiang wrote:
> Found by reading the code.
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  include/qom/cpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index dc130cd307..5bb94a9f86 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -852,7 +852,7 @@ extern CPUInterruptHandler cpu_interrupt_handler;
>  /**
>   * cpu_interrupt:
>   * @cpu: The CPU to set an interrupt on.
> - * @mask: The interupts to set.
> + * @mask: The interrupts to set.
>   *
>   * Invokes the interrupt handler.
>   */
> 

Applied

Thanks,
Laurent
