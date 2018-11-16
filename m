Received: from eggs.gnu.org ([2001:4830:134:3::10]:36297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNgvw-00073l-TS
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:25:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNgvs-0001fT-Ol
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:25:26 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNgvq-0001ej-RY
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:25:23 -0500
Received: by mail-oi1-x244.google.com with SMTP id u18so1896490oie.10
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 08:25:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181112214224.31560-7-contrib@steffen-goertz.de>
References: <20181112214224.31560-1-contrib@steffen-goertz.de>
	<20181112214224.31560-7-contrib@steffen-goertz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Nov 2018 16:25:01 +0000
Message-ID: <CAFEAcA8sz-QpvR039dC0fEuRC4qkxTEwY-=3LpoXG27aFO1S9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 06/14] arm: Instantiate NRF51 special
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "open list:NRF51" <qemu-arm@nongnu.org>

On 12 November 2018 at 21:42, Steffen G=C3=B6rtz <contrib@steffen-goertz.de=
> wrote:
> Instantiates UICR, FICR, FLASH and NVMC in nRF51 SOC.
>
> Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
