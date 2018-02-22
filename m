Received: from eggs.gnu.org ([2001:4830:134:3::10]:58825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eoqWN-0008GG-Dx
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 08:02:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eoqWJ-00052U-PQ
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 08:02:47 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:33158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eoqWJ-000527-Kh
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 08:02:43 -0500
Received: by mail-ot0-x244.google.com with SMTP id k7so3833845otj.0
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 05:02:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180215220540.6556-10-f4bug@amsat.org>
References: <20180215220540.6556-1-f4bug@amsat.org>
	<20180215220540.6556-10-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 13:02:22 +0000
Message-ID: <CAFEAcA8YipVxDHsKHYE=8kN+Nrsvs1Cp7OavYL2Am=6gozh_AA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 09/11] sdcard: display protocol used
 when tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Andrzej Zaborowski <balrogg@gmail.com>

On 15 February 2018 at 22:05, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> put the function in sdmmc-common.c since we will reuse it in hw/sd/core.c
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Commit message talks about a function but the patch doesn't
add any new functions ? (Also, sentences should start with
a capital letter and end with a full stop, please.)

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
