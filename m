Received: from eggs.gnu.org ([2001:4830:134:3::10]:35107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMc9m-0006HH-MM
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 12:07:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMc1m-0000Be-Ah
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 11:59:02 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gMc1l-0000Ae-TK
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 11:59:02 -0500
Received: by mail-oi1-x243.google.com with SMTP id j202-v6so10909067oih.10
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 08:59:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181113165247.4806-2-sameo@linux.intel.com>
References: <20181113165247.4806-1-sameo@linux.intel.com>
	<20181113165247.4806-2-sameo@linux.intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Nov 2018 16:58:40 +0000
Message-ID: <CAFEAcA-npVS1Q0=or=p-kjP0Nf4h1n+qUL7y8+yYCdtuHa7Fxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/13] target: arm: Add copyright
 boilerplate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On 13 November 2018 at 16:52, Samuel Ortiz <sameo@linux.intel.com> wrote:
> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Robert Bradford <robert.bradford@intel.com>
> Reviewed-by: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  target/arm/helper.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 0da1424f72..3d4e9c5c8a 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -1,3 +1,10 @@
> +/*
> + * ARM generic helpers.
> + *
> + * This code is licensed under the GNU GPL v2.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */

The human readable text says "v2", but the SPDX tag says
"v2 or later". Which is right? (The top level LICENSE file says
source files with no specific license are 2-or-later).

thanks
-- PMM
