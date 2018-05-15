Received: from eggs.gnu.org ([2001:4830:134:3::10]:40359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIXaX-00048V-Aq
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIXaW-0002sC-BH
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:53:49 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:33718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIXaW-0002ry-6J
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:53:48 -0400
Received: by mail-oi0-x244.google.com with SMTP id k5-v6so13541163oiw.0
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 03:53:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180514221219.7091-15-richard.henderson@linaro.org>
References: <20180514221219.7091-1-richard.henderson@linaro.org>
	<20180514221219.7091-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 11:53:27 +0100
Message-ID: <CAFEAcA977O0JTapcHWMcMaO_wU7v6Zc4G8juTMgN5RXtwpkSog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 14/28] fpu/softfloat: re-factor float to
 float conversions
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

On 14 May 2018 at 23:12, Richard Henderson <richard.henderson@linaro.org> w=
rote:
> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> This allows us to delete a lot of additional boilerplate
> code which is no longer needed.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
