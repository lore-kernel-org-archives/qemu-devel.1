Received: from eggs.gnu.org ([2001:4830:134:3::10]:35126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqh1s-0005X4-1B
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:51:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqh1r-0000bh-BL
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:51:11 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:45930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqh1q-0000Yc-Rf
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:51:11 -0400
Received: by mail-oi0-x243.google.com with SMTP id q11-v6so14723140oic.12
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 08:51:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180809042206.15726-4-richard.henderson@linaro.org>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
	<20180809042206.15726-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Aug 2018 16:50:49 +0100
Message-ID: <CAFEAcA_DH6AymyxTHSaWP0JGwby8eMEUH-DBtJrAFQtZj8EiMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 03/20] target/arm: Define ID_AA64ZFR0_EL1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Desnogues <laurent.desnogues@gmail.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 9 August 2018 at 05:21, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Given that the only field defined for this new register may only
> be 0, we don't actually need to change anything except the name.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
