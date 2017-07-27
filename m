Received: from eggs.gnu.org ([2001:4830:134:3::10]:58303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dai2F-0003QF-4R
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 08:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dai2E-0001gv-Fk
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 08:36:59 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:35516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dai2E-0001fz-AQ
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 08:36:58 -0400
Received: by mail-wm0-x22b.google.com with SMTP id c184so103924561wmd.0
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 05:36:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170717133010.12784-1-f4bug@amsat.org>
References: <20170717133010.12784-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Jul 2017 13:36:36 +0100
Message-ID: <CAFEAcA_rhoCup57nYYW4HN6Qsz3sp-cxY-OwsK-x=fYtfJ31aQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/arm: use defined type name instead of
 hard-coded string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>

On 17 July 2017 at 14:30, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>
> Hi Peter, this patch is waiting the IDE queue to enters since it depends =
of
> commit de09efcc7b67ada3593354711b12a03dea23a9d0 to fix AHCI includes.

There's no commit with that hash in master -- do you have
a commit subject or something that I can use to find out
whether it's landed or not?

thanks
-- PMM
