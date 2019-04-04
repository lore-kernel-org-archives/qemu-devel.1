Received: from eggs.gnu.org ([209.51.188.92]:33326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1hBy8K-0004kW-DQ
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 04:54:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1hBy8J-00075C-ES
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 04:54:04 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:43459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1hBy8J-00070h-1X
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 04:54:03 -0400
Received: by mail-lf1-x142.google.com with SMTP id g7so1165164lfh.10
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 01:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <1552644466-24625-1-git-send-email-hongbo.zhang@linaro.org>
	<1552644466-24625-2-git-send-email-hongbo.zhang@linaro.org>
	<CAKv+Gu-aZeYwegzFQ7pPqvm28ySR5xC6rZh8FBvQaWiNykgPEg@mail.gmail.com>
	<CAHmQWvD8byf+4=J7+rnU9CiGRKnuA4NnRPHRw1Zki4-m4anwOA@mail.gmail.com>
	<CAKv+Gu9cWgkH-ZTDQ42_HnN-LfAMoL-k7ysd1Hz07RrP+Pp94g@mail.gmail.com>
	<CAHmQWvArKFj9WPwaLjHs11x75iD0Rk9PBsTRq8mXrhm-LZt7=A@mail.gmail.com>
	<CAFEAcA_gA0Z1+K=TiPHbNz2XaCexujYvuqWBm3BBXHTtip_2Kg@mail.gmail.com>
In-Reply-To: <CAFEAcA_gA0Z1+K=TiPHbNz2XaCexujYvuqWBm3BBXHTtip_2Kg@mail.gmail.com>
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Thu, 4 Apr 2019 16:53:46 +0800
Message-ID: <CAHmQWvDfpz2bRYfg9Ww-hYGhK-M1Tm2HTcg=ZAnsGKaE1w4+bA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 1/2] hw/arm: Add arm SBSA reference
 machine, skeleton part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Leif Lindholm <leif.lindholm@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>

On Thu, 4 Apr 2019 at 16:47, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 4 Apr 2019 at 15:27, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
> > I would like to wait for more days to see if there are any further
> > comments, and if no I will send another iteration with memory map
> > slightly changed.
>
> This is on my to-review list, but I've been a bit busy with work for
> the 4.0 release -- sorry I haven't been able to get to this yet. I'll
> try to have at least a first look over the next day or so, but I can't
> promise I'll manage that, so please go ahead and send out your next
> iteration whenever you're ready to do that.
>
Understand, thanks.

> thanks
> -- PMM
