Received: from eggs.gnu.org ([2001:4830:134:3::10]:52447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6yAC-0006uw-4x
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 08:50:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6yAB-0001hs-Ja
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 08:50:48 -0400
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:41892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6yAB-0001hH-E9
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 08:50:47 -0400
Received: by mail-ot0-x231.google.com with SMTP id m22-v6so9701060otf.8
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 05:50:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180324192455.12254-11-mdavidsaver@gmail.com>
References: <20180324192455.12254-1-mdavidsaver@gmail.com>
	<20180324192455.12254-11-mdavidsaver@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Apr 2018 13:50:26 +0100
Message-ID: <CAFEAcA-xDcws3KfpRvocnGUUt4_BR6V8irBNqHhsEqyEqhfDzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 10/14] timer: rename file ds1338.c ->
 ds-rtc.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, Antoine Mathys <barsamin@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, QEMU Developers <qemu-devel@nongnu.org>

2018-03-24 19:24 GMT+00:00 Michael Davidsaver <mdavidsaver@gmail.com>:
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> ---
>  default-configs/arm-softmmu.mak | 2 +-
>  hw/timer/Makefile.objs          | 2 +-
>  hw/timer/{ds1338.c => ds-rtc.c} | 0
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  rename hw/timer/{ds1338.c => ds-rtc.c} (100%)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
