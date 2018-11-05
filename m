Received: from eggs.gnu.org ([2001:4830:134:3::10]:56284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJi6d-0007II-9o
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:52:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJi6Z-0003ub-AS
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:52:01 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:44822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gJi6T-0003tA-Qn
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:51:57 -0500
Received: by mail-oi1-x241.google.com with SMTP id k19-v6so8036115oic.11
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 08:51:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181102170730.12432-10-contrib@steffen-goertz.de>
References: <20181102170730.12432-1-contrib@steffen-goertz.de>
	<20181102170730.12432-10-contrib@steffen-goertz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Nov 2018 16:51:31 +0000
Message-ID: <CAFEAcA9ZFbS5ixv-Sf2yOgF-r7oK=rW8EmG4983PMUbEPh9D_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 09/13] arm: Instantiate NRF51 general
 purpose I/O
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
> Instantiates GPIO peripheral model
>
> Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/arm/nrf51_soc.c         | 16 ++++++++++++++++
>  include/hw/arm/nrf51_soc.h |  2 ++
>  2 files changed, 18 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
