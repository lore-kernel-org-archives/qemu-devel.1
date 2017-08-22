Received: from eggs.gnu.org ([2001:4830:134:3::10]:51262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dkBv0-0003yZ-5H
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 12:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dkBuy-0002qp-Rd
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 12:20:42 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:37483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dkBuy-0002qS-FE
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 12:20:40 -0400
Received: by mail-wm0-x230.google.com with SMTP id b189so1612436wmd.0
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 09:20:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <150283106173.12142.14640827565327335906@loki>
References: <150283106173.12142.14640827565327335906@loki>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Aug 2017 17:20:18 +0100
Message-ID: <CAFEAcA9eJ18cPj=MBhCftmVvOBPCmFtDqSKOM8aBH9d+uVuv4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 2.10.0-rc3 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 15 August 2017 at 22:04, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> Hello,
>
> On behalf of the QEMU Team, I'd like to announce the availability of the
> fourth release candidate for the QEMU 2.10 release.  This release is meant
> for testing purposes and should not be used in a production environment.
>
>   http://download.qemu-project.org/qemu-2.10.0-rc3.tar.xz
>   http://download.qemu-project.org/qemu-2.10.0-rc3.tar.xz.sig
>
> A note from the maintainer:
>
>   We don't currently know of any outstanding release critical bugs,
>   so unless any last minute showstoppers appear next week, we hope
>   to be able to release 2.10.0 on schedule on the 22nd. If any
>   further release critical bugs are fixed we'll release an rc4 on
>   the 22nd and the final release a week after that.

We've had a few late-breaking PPC host bugs that we need
to fix, so we'll tag rc3 either today or more likely tomorrow
and then have the final release next week.

thanks
-- PMM
