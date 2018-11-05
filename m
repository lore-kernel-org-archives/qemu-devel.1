Received: from eggs.gnu.org ([2001:4830:134:3::10]:55267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJi3n-0005BQ-5o
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:49:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJi3m-0006SS-9G
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:49:07 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:40367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gJi3m-0006Ro-3p
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:49:06 -0500
Received: by mail-ot1-x334.google.com with SMTP id m15so8590083otl.7
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 08:49:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181102170730.12432-4-contrib@steffen-goertz.de>
References: <20181102170730.12432-1-contrib@steffen-goertz.de>
	<20181102170730.12432-4-contrib@steffen-goertz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Nov 2018 16:48:45 +0000
Message-ID: <CAFEAcA9r1fMbFa2_-VOneP1J4-0azVXoEEKWnsqKknsGA_BwCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 03/13] hw/misc/nrf51_rng: Add NRF51
 random number generator peripheral
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>

On 2 November 2018 at 17:07, Steffen G=C3=B6rtz <contrib@steffen-goertz.de>=
 wrote:
> Add a model of the NRF51 random number generator peripheral.
> This is a simple random generator that continuously generates
> new random values after startup.
>
> Reference Manual: http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.pdf
>
> Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
