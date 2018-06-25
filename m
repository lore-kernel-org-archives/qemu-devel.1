Received: from eggs.gnu.org ([2001:4830:134:3::10]:38403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXT7I-0001Vf-EB
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:09:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXT7H-0001Sf-Iw
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:09:20 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:34493)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXT7H-0001ST-CM
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:09:19 -0400
Received: by mail-oi0-x244.google.com with SMTP id c2-v6so1138107oic.1
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 08:09:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621015359.12018-5-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Jun 2018 16:08:58 +0100
Message-ID: <CAFEAcA9Fdu1HzdE2===5fiuhbCD4PTJho=ukcfsHokzVZjNkeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 04/35] target/arm: Implement SVE load
 and broadcast quadword
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

On 21 June 2018 at 02:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-sve.c | 52 ++++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      |  9 +++++++
>  2 files changed, 61 insertions(+)
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
