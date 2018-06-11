Received: from eggs.gnu.org ([2001:4830:134:3::10]:41797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSOfP-000112-FX
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSOfO-0003py-MM
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:23:35 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:37701)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fSOfO-0003pk-H5
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:23:34 -0400
Received: by mail-oi0-x241.google.com with SMTP id l22-v6so18235223oib.4
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 08:23:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180611142528.11730-1-ville.skytta@iki.fi>
References: <20180611142528.11730-1-ville.skytta@iki.fi>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Jun 2018 16:23:13 +0100
Message-ID: <CAFEAcA-wru_Sb8nd6+10yZUdOS-g5Mz+mEDTbWS44zFa0NS5dw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docs: Grammar and spelling fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Ville_Skytt=C3=A4?= <ville.skytta@iki.fi>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 11 June 2018 at 15:25, Ville Skytt=C3=A4 <ville.skytta@iki.fi> wrote:
> Signed-off-by: Ville Skytt=C3=A4 <ville.skytta@iki.fi>

> diff --git a/docs/specs/acpi_nvdimm.txt b/docs/specs/acpi_nvdimm.txt
> index 3f322e6f55..4da2d44534 100644
> --- a/docs/specs/acpi_nvdimm.txt
> +++ b/docs/specs/acpi_nvdimm.txt
> @@ -72,7 +72,7 @@ for NVDIMM ACPI.
>
>  Memory:
>     QEMU uses BIOS Linker/loader feature to ask BIOS to allocate a memory
> -   page and dynamically patch its into a int32 object named "MEMA" in AC=
PI.
> +   page and dynamically patch its into an int32 object named "MEMA" in A=
CPI.

Should this read "its address" ?

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
