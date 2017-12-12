Received: from eggs.gnu.org ([2001:4830:134:3::10]:36740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eOov2-0001zU-Uu
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 13:04:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eOov1-0000zd-TU
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 13:04:41 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:35397)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eOov1-0000xp-OR
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 13:04:39 -0500
Received: by mail-ot0-x242.google.com with SMTP id q3so18554354oth.2
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 10:04:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1513058845-9768-1-git-send-email-zhaoshenglong@huawei.com>
References: <1513058845-9768-1-git-send-email-zhaoshenglong@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Dec 2017 18:04:16 +0000
Message-ID: <CAFEAcA8XxVAU-U0fDGUfHbYCDnGbWUgiQd7W29+bMzNdyBme2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] MAINTAINERS: replace the
 unavailable email address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 12 December 2017 at 06:07, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> From: Zhaoshenglong <zhaoshenglong@huawei.com>
>
> Since I'm not working as an assignee in Linaro, replace the Linaro email
> address with my personal one.
>
> Signed-off-by: Zhaoshenglong <zhaoshenglong@huawei.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0255113..45e2e20 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -543,7 +543,7 @@ F: include/hw/*/xlnx*.h
>
>  ARM ACPI Subsystem
>  M: Shannon Zhao <zhaoshenglong@huawei.com>
> -M: Shannon Zhao <shannon.zhao@linaro.org>
> +M: Shannon Zhao <shannon.zhaosl@gmail.com>
>  L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/arm/virt-acpi-build.c
> --
> 2.0.4

Thanks; applied to target-arm.next for 2.12.

-- PMM
