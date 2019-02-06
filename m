Received: from eggs.gnu.org ([209.51.188.92]:46980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grOSo-0000b8-BX
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 09:46:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grOSm-0000FE-4z
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 09:46:08 -0500
References: <20190201173655.4567-1-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <0c4d4eab-ef3e-3490-f9d3-dee31f5d3be6@vivier.eu>
Date: Wed, 6 Feb 2019 15:45:32 +0100
MIME-Version: 1.0
In-Reply-To: <20190201173655.4567-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] qemu-common.h: Update
 copyright string for 2019
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 01/02/2019 18:36, Peter Maydell wrote:
> Update the copyright string we use in version/help output,
> since we're well into the new year now.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Better than last year, where we didn't get round to doing
> the year bump until September :-)
> ---
>  include/qemu-common.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/qemu-common.h b/include/qemu-common.h
> index ed60ba251d8..a1022455199 100644
> --- a/include/qemu-common.h
> +++ b/include/qemu-common.h
> @@ -17,7 +17,7 @@
>  #define TFR(expr) do { if ((expr) != -1) break; } while (errno == EINTR)
>  
>  /* Copyright string for -version arguments, About dialogs, etc */
> -#define QEMU_COPYRIGHT "Copyright (c) 2003-2018 " \
> +#define QEMU_COPYRIGHT "Copyright (c) 2003-2019 " \
>      "Fabrice Bellard and the QEMU Project developers"
>  
>  /* Bug reporting information for --help arguments, About dialogs, etc */
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
