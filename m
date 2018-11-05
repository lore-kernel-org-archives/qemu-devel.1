Received: from eggs.gnu.org ([2001:4830:134:3::10]:35058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJiPF-000500-4s
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 12:11:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJiBm-0003Bk-Nv
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:57:29 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:44860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gJiBh-0002wW-4L
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:57:18 -0500
Received: by mail-oi1-x242.google.com with SMTP id k19-v6so8053693oic.11
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 08:57:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181102170730.12432-13-contrib@steffen-goertz.de>
References: <20181102170730.12432-1-contrib@steffen-goertz.de>
	<20181102170730.12432-13-contrib@steffen-goertz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Nov 2018 16:56:54 +0000
Message-ID: <CAFEAcA8mW6PehY7NVDJ0G+B6aU2ChpmijgAfmvo6j+YiLhnj5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 12/13] arm: Instantiate NRF51 Timers
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
> Instantiates TIMER0 - TIMER2
>
> Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/arm/nrf51_soc.c         | 27 +++++++++++++++++++++++++++
>  include/hw/arm/nrf51_soc.h |  4 ++++
>  2 files changed, 31 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
