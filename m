Received: from eggs.gnu.org ([2001:4830:134:3::10]:56948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1fiFzq-0000Ph-Ux
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:22:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1fiFzn-000654-U1
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:22:14 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:37972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1fiFzn-00064A-Nc
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:22:11 -0400
Received: by mail-it0-x244.google.com with SMTP id v71-v6so7687045itb.3
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 02:22:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-WVfswDpDGoDCTqv-ZRege8kJ5hPjcy43DkODRKZfGZg@mail.gmail.com>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA-WVfswDpDGoDCTqv-ZRege8kJ5hPjcy43DkODRKZfGZg@mail.gmail.com>
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Wed, 25 Jul 2018 17:22:10 +0800
Message-ID: <CAHmQWvBG6QA9pn6cTUb2o5GzCbq2Xwt2WuKNZ_yZ7kH-uFMCOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/2] hw/arm: check fw_cfg return value
 before using it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>

On 25 July 2018 at 17:00, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 25 July 2018 at 06:30, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
>> The fw_cfg value returned from fw_cfg_find() may be NULL, so check it
>> before using.
>>
>> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
>
> Hi -- this patch series seems to be missing its cover letter.
> Please could you include a cover letter for any patchset
> with more than one patch -- some of our automated patch
> email handling tools rely on it.
>
Get it.
2/2 needs a v3 at least, so will remember to include the cover letter
in v3 then.

Thanks.

> thanks
> -- PMM
