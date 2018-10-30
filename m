Received: from eggs.gnu.org ([2001:4830:134:3::10]:38116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shannon.zhaosl@gmail.com>) id 1gHLfW-0003K5-Bl
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 00:30:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shannon.zhaosl@gmail.com>) id 1gHLfT-0002S3-50
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 00:30:16 -0400
References: <20181029195931.8747-1-philmd@redhat.com>
From: Shannon Zhao <shannon.zhaosl@gmail.com>
Message-ID: <fa65f06c-13dc-a73e-2bcd-2c7fcf7c3d30@gmail.com>
Date: Tue, 30 Oct 2018 12:30:00 +0800
MIME-Version: 1.0
In-Reply-To: <20181029195931.8747-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Remove bouncing email in ARM
 ACPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-arm@nongnu.org



On 2018/10/30 3:59, Philippe Mathieu-Daudé wrote:
> Shannon Zhao's email at Huawei is bouncing: remove it.
> 
>      X-Failed-Recipients: zhaoshenglong@huawei.com
>      ** Address not found **
>      Your message wasn't delivered to zhaoshenglong@huawei.com because the address couldn't be found, or is unable to receive mail.
> 
> Note that the section still contains his personal email (see e59f13d76bb).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Thanks Philippe.

Acked-by: Shannon Zhao <shannon.zhaosl@gmail.com>
> ---
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d794bd7a66..1aa2728aac 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -625,7 +625,6 @@ F: hw/*/xlnx*.c
>   F: include/hw/*/xlnx*.h
>   
>   ARM ACPI Subsystem
> -M: Shannon Zhao <zhaoshenglong@huawei.com>
>   M: Shannon Zhao <shannon.zhaosl@gmail.com>
>   L: qemu-arm@nongnu.org
>   S: Maintained
> 
