Received: from eggs.gnu.org ([2001:4830:134:3::10]:35416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKlgu-0000ZX-U7
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:53:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKlgt-0002t8-3p
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:53:52 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gKlgs-0002sV-UP
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:53:51 -0500
Received: by mail-oi1-x241.google.com with SMTP id w66-v6so17111621oiw.4
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 06:53:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <e261d51b-1dc7-95d1-c056-a7961048a2ac@redhat.com>
References: <20181108134139.31666-1-peter.maydell@linaro.org>
	<e261d51b-1dc7-95d1-c056-a7961048a2ac@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Nov 2018 14:53:29 +0000
Message-ID: <CAFEAcA_ZtRjKKypGze4WEe-DkxekCOdAraRD6Tv+VRiKuZoYQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: list myself as maintainer for
 various Arm boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Markus Armbruster <armbru@redhat.com>, "patches@linaro.org" <patches@linaro.org>, Beniamino Galvani <b.galvani@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>, Antony Pavlov <antonynpavlov@gmail.com>, Jan Kiszka <jan.kiszka@web.de>, Andrzej Zaborowski <balrogg@gmail.com>

On 8 November 2018 at 14:43, Thomas Huth <thuth@redhat.com> wrote:
> On 2018-11-08 14:41, Peter Maydell wrote:
>> In practice for most of the more-or-less orphan Arm board models,
>> I will review patches and put them in via the target-arm tree.
>> So list myself as an "Odd Fixes" status maintainer for them.
>>
>> This commit downgrades these boards to "Odd Fixes":
>>  * Allwinner-A10
>>  * Exynos
>>  * Calxeda Highbank
>>  * Canon DIGIC
>>  * Musicpal
>>  * nSeries
>>  * Palm
>>  * PXA2xx
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>
> FWIW:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
> While you're at it, could you maybe also add an entry for the
> "mcimx6ul-evk", "mcimx7d-sabre", "raspi2", "raspi3", "sabrelite",
> "vexpress-a15", "vexpress-a9" and "virt" boards? Or shall I assemble a
> patch?

If you want to do it that would be great.

thanks
-- PMM
