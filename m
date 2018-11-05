Received: from eggs.gnu.org ([2001:4830:134:3::10]:55796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJi5R-0006P7-B4
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:50:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJi5P-000296-3z
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:50:48 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gJi5L-00011e-Rl
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:50:45 -0500
Received: by mail-ot1-x342.google.com with SMTP id t5so4985034otk.1
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 08:50:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181102170730.12432-7-contrib@steffen-goertz.de>
References: <20181102170730.12432-1-contrib@steffen-goertz.de>
	<20181102170730.12432-7-contrib@steffen-goertz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Nov 2018 16:50:04 +0000
Message-ID: <CAFEAcA8VeaitLr7q7yFgJu0+k=z9wKG3V+_sbgwwBF7o5ryw7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 06/13] arm: Instantiate NRF51 special
 NVM's and NVMC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, "open list:NRF51" <qemu-arm@nongnu.org>

On 2 November 2018 at 17:07, Steffen G=C3=B6rtz <contrib@steffen-goertz.de>=
 wrote:
> Instantiates UICR, FICR and NVMC in nRF51 SOC.
>
> Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/arm/nrf51_soc.c         | 37 ++++++++++++++++++++++++++++++++++---
>  include/hw/arm/nrf51_soc.h |  2 ++
>  2 files changed, 36 insertions(+), 3 deletions(-)


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
