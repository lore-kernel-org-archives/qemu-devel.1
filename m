Received: from eggs.gnu.org ([209.51.188.92]:48357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqff6-0001jM-Dy
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:55:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqff5-00085m-Di
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:55:52 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gqfew-0007kU-3D
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:55:47 -0500
Received: by mail-ot1-x342.google.com with SMTP id u16so159318otk.8
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 06:55:22 -0800 (PST)
MIME-Version: 1.0
References: <20190204052712.30833-1-richard.henderson@linaro.org>
	<20190204052712.30833-2-richard.henderson@linaro.org>
In-Reply-To: <20190204052712.30833-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Feb 2019 14:55:10 +0000
Message-ID: <CAFEAcA-Nep3JQEZL-_i6KNqGJKvki=DzR_u9XkmNj=FPZrOH0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/3] target/arm: Force result size into dp
 after operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Mon, 4 Feb 2019 at 05:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Rather than a complex set of cases testing for writeback,
> adjust DP after performing the operation.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
