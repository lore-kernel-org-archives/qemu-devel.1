Received: from eggs.gnu.org ([2001:4830:134:3::10]:56273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHUHT-0001Pr-6N
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:42:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHUHQ-0004lv-T3
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:42:03 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44213)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gHUHN-0004cw-9d
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:41:58 -0400
Received: by mail-ot1-x341.google.com with SMTP id p23so11078614otf.11
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 06:41:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181029195931.8747-1-philmd@redhat.com>
References: <20181029195931.8747-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Oct 2018 13:41:34 +0000
Message-ID: <CAFEAcA_JXyRqy2c7C6GqGYFoDPYRmccCorP7-f2U+tDtW2ZiUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 29 October 2018 at 19:59, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
> Shannon Zhao's email at Huawei is bouncing: remove it.
>
>     X-Failed-Recipients: zhaoshenglong@huawei.com
>     ** Address not found **
>     Your message wasn't delivered to zhaoshenglong@huawei.com because the=
 address couldn't be found, or is unable to receive mail.
>
> Note that the section still contains his personal email (see e59f13d76bb)=
.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d794bd7a66..1aa2728aac 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -625,7 +625,6 @@ F: hw/*/xlnx*.c
>  F: include/hw/*/xlnx*.h
>
>  ARM ACPI Subsystem
> -M: Shannon Zhao <zhaoshenglong@huawei.com>
>  M: Shannon Zhao <shannon.zhaosl@gmail.com>
>  L: qemu-arm@nongnu.org
>  S: Maintained



Applied to target-arm.next, thanks.

-- PMM
