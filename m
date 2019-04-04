Received: from eggs.gnu.org ([209.51.188.92]:60054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBy25-00025B-H3
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 04:47:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBy24-0006Gw-KP
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 04:47:37 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hBy24-0006ET-AH
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 04:47:36 -0400
Received: by mail-oi1-x243.google.com with SMTP id w139so1213252oie.9
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 01:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <1552644466-24625-1-git-send-email-hongbo.zhang@linaro.org>
	<1552644466-24625-2-git-send-email-hongbo.zhang@linaro.org>
	<CAKv+Gu-aZeYwegzFQ7pPqvm28ySR5xC6rZh8FBvQaWiNykgPEg@mail.gmail.com>
	<CAHmQWvD8byf+4=J7+rnU9CiGRKnuA4NnRPHRw1Zki4-m4anwOA@mail.gmail.com>
	<CAKv+Gu9cWgkH-ZTDQ42_HnN-LfAMoL-k7ysd1Hz07RrP+Pp94g@mail.gmail.com>
	<CAHmQWvArKFj9WPwaLjHs11x75iD0Rk9PBsTRq8mXrhm-LZt7=A@mail.gmail.com>
In-Reply-To: <CAHmQWvArKFj9WPwaLjHs11x75iD0Rk9PBsTRq8mXrhm-LZt7=A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Apr 2019 15:47:23 +0700
Message-ID: <CAFEAcA_gA0Z1+K=TiPHbNz2XaCexujYvuqWBm3BBXHTtip_2Kg@mail.gmail.com>
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
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Leif Lindholm <leif.lindholm@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>

On Thu, 4 Apr 2019 at 15:27, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
> I would like to wait for more days to see if there are any further
> comments, and if no I will send another iteration with memory map
> slightly changed.

This is on my to-review list, but I've been a bit busy with work for
the 4.0 release -- sorry I haven't been able to get to this yet. I'll
try to have at least a first look over the next day or so, but I can't
promise I'll manage that, so please go ahead and send out your next
iteration whenever you're ready to do that.

thanks
-- PMM
