Received: from eggs.gnu.org ([2001:4830:134:3::10]:41168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZzaJ-0007P1-9D
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:41:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZzaI-00035e-Ff
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:41:27 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:42262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZzaI-00034p-A6
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:41:26 -0500
Received: by mail-ot0-x243.google.com with SMTP id s3so5050368otc.9
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 05:41:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180109122252.17670-2-alex.bennee@linaro.org>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-2-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2018 13:41:05 +0000
Message-ID: <CAFEAcA-Z5ASNMPsy2q6aDzJ0xBSMGD6qUaU=iTjDfZzR8pTacg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/20] fpu/softfloat: implement
 float16_squash_input_denormal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, bharata@linux.vnet.ibm.com, Andrew Dutcher <andrew@andrewdutcher.com>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 9 January 2018 at 12:22, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote=
:
> This will be required when expanding the MINMAX() macro for 16
> bit/half-precision operations.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
