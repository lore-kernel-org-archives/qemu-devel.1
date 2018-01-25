Received: from eggs.gnu.org ([2001:4830:134:3::10]:36254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eelGe-0004Y3-SM
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:24:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eelGe-0001yq-3c
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:24:52 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:39921)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eelGd-0001yI-Uj
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:24:52 -0500
Received: by mail-ot0-x242.google.com with SMTP id d9so7357843oth.6
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 09:24:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180117161435.28981-19-richard.henderson@linaro.org>
References: <20180117161435.28981-1-richard.henderson@linaro.org>
	<20180117161435.28981-19-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2018 17:24:30 +0000
Message-ID: <CAFEAcA8KmFD4wbTXScjRE4K4Zo51==4gJ0kOkODW4ceGdptTPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v10.5 18/20] target/arm: Use vector
 infrastructure for aa64 orr/bic immediate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 17 January 2018 at 16:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 38 +++++++++++++++++---------------------
>  1 file changed, 17 insertions(+), 21 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
