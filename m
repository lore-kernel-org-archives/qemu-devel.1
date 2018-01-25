Received: from eggs.gnu.org ([2001:4830:134:3::10]:49261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eekfk-0000Q8-Vx
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:46:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eekfk-0001si-9s
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:46:45 -0500
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:33428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eekfk-0001sc-4o
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:46:44 -0500
Received: by mail-ot0-x22f.google.com with SMTP id d7so7261111oti.0
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 08:46:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180117161435.28981-14-richard.henderson@linaro.org>
References: <20180117161435.28981-1-richard.henderson@linaro.org>
	<20180117161435.28981-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2018 16:46:22 +0000
Message-ID: <CAFEAcA_vCzyv4en7nB13G=gT1cHehfwzJbh3R4rag5YWThoUjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v10.5 13/20] target/arm: Use vector
 infrastructure for aa64 mov/not/neg
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
>  target/arm/translate-a64.c | 43 ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 38 insertions(+), 5 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
