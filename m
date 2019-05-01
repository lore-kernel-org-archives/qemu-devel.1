Received: from eggs.gnu.org ([209.51.188.92]:59919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hLqxM-0007LB-C0
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:15:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hLqxJ-0002l2-Bu
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:15:36 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:33477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1hLqxJ-0002ka-34
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:15:33 -0400
Received: by mail-yw1-xc43.google.com with SMTP id q11so8538626ywb.0
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 08:15:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190501050536.15580-1-richard.henderson@linaro.org>
	<20190501050536.15580-30-richard.henderson@linaro.org>
In-Reply-To: <20190501050536.15580-30-richard.henderson@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 1 May 2019 08:15:20 -0700
Message-ID: <CAMo8BfKfSbukiqs9PNQu5ZmzG3-gGr-BAavBEcyHFazFi3DonA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 29/29] target/xtensa: Use tcg_gen_abs_i32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Tue, Apr 30, 2019 at 10:06 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/xtensa/translate.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
