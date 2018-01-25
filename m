Received: from eggs.gnu.org ([2001:4830:134:3::10]:35826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eelFq-0003tR-Kh
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:24:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eelFp-0001CN-Po
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:24:02 -0500
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:38917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eelFp-0001C9-Kl
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:24:01 -0500
Received: by mail-ot0-x233.google.com with SMTP id d9so7355541oth.6
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 09:24:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180117161435.28981-18-richard.henderson@linaro.org>
References: <20180117161435.28981-1-richard.henderson@linaro.org>
	<20180117161435.28981-18-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2018 17:23:40 +0000
Message-ID: <CAFEAcA_iY2Q-FKVzzUVW1wuo-m_yWeMLvhKzc8JB3comML-8yw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v10.5 17/20] target/arm: Use vector
 infrastructure for aa64 multiplies
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
>  target/arm/translate-a64.c | 171 ++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 138 insertions(+), 33 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
