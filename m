Received: from eggs.gnu.org ([2001:4830:134:3::10]:54843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfRit-00021w-GH
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:12:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfRir-00026k-TP
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:12:35 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-45-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ff2ef34e-39d2-9048-2ef5-7073b3606271@amsat.org>
Date: Wed, 9 Aug 2017 11:12:24 -0300
MIME-Version: 1.0
In-Reply-To: <20170728053610.15770-45-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 44/47] MAINTAINERS: add missing entry
 for tilegx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Chen Gang <gang.chen.5i5j@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

ping?

I suppose no answer/ping timeout confirms there is no maintainer for 
"Odd Fixes" so the "Orphan" status is correct.

On 07/28/2017 02:36 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   MAINTAINERS | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 453f5fb3d7..dc1a69051c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -283,6 +283,10 @@ F: hw/tricore/
>   F: include/hw/tricore/
>   F: default-configs/tricore-softmmu.mak
>   
> +TILE-Gx
> +S: Orphan
> +F: target/tilegx/
> +
>   Guest CPU Cores (KVM):
>   ----------------------
>   
> 
