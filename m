Received: from eggs.gnu.org ([2001:4830:134:3::10]:39925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGowU-00050f-Vu
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGowT-0000eu-VA
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:01:22 -0400
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:38175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fGowT-0000eQ-Qw
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:01:21 -0400
Received: by mail-ot0-x22a.google.com with SMTP id n3-v6so3097554ota.5
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 10:01:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180502221552.3873-13-richard.henderson@linaro.org>
References: <20180502221552.3873-1-richard.henderson@linaro.org>
	<20180502221552.3873-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 May 2018 18:01:00 +0100
Message-ID: <CAFEAcA9xJMmi2NqdsmtaMu36+tvBu7Ang3jRmSJrU8Y=iQTNNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 12/14] target/arm: Implement FCSEL for
 fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-stable <qemu-stable@nongnu.org>

On 2 May 2018 at 23:15, Richard Henderson <richard.henderson@linaro.org> wr=
ote:
> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> These were missed out from the rest of the half-precision work.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> [rth: Fix erroneous check vs type]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
