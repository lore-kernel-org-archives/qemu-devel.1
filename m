Received: from eggs.gnu.org ([2001:4830:134:3::10]:52382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIEck-0001Lx-Nl
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIEck-0003Ak-1L
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:38:50 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:41518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIEcj-0003AS-SU
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:38:49 -0400
Received: by mail-oi0-x244.google.com with SMTP id 11-v6so10869275ois.8
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 07:38:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180512004311.9299-23-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
	<20180512004311.9299-23-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 15:38:28 +0100
Message-ID: <CAFEAcA8EaDO+UuR1p9JLGgshApdJ2hntTnmfom_k=uHr8jYaOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 22/27] fpu/softfloat: Use
 float*_silence_nan in propagateFloat*NaN
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

On 12 May 2018 at 01:43, Richard Henderson <richard.henderson@linaro.org> wrote:
> We have already checked the arguments for SNaN;
> we don't need to do it again.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
