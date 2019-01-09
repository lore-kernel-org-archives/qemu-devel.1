Received: from eggs.gnu.org ([209.51.188.92]:39398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1ghMXF-0004Ty-Ap
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 17:41:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1ghMXA-0000R3-Af
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 17:41:16 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1ghMX8-0000Jg-6G
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 17:41:12 -0500
Received: by mail-ot1-x343.google.com with SMTP id 32so8184040ota.12
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 14:41:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20190107111129.2087-2-alex.bennee@linaro.org>
References: <20190107111129.2087-1-alex.bennee@linaro.org>
	<20190107111129.2087-2-alex.bennee@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 9 Jan 2019 23:41:08 +0100
Message-ID: <CAL1e-=gtLHQWBg2c_v-Gw0-e6dkO_7DWtgCft-F87UEnYYzg7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 1/3] contrib/gitdm: add Nokia and
 Proxmox to the domain-map
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "cota@braap.org" <cota@braap.org>

On Monday, January 7, 2019, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote=
:

> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  contrib/gitdm/domain-map | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
> index 8cbbcfe93d..0ab41ee27a 100644
> --- a/contrib/gitdm/domain-map
> +++ b/contrib/gitdm/domain-map
> @@ -9,7 +9,9 @@ greensocs.com   GreenSocs
>  ibm.com         IBM
>  igalia.com      Igalia
>  linaro.org      Linaro
> +nokia.com       Nokia
>  oracle.com      Oracle
> +proxmox.com     Proxmox
>  redhat.com      Red Hat
>  siemens.com     Siemens
>  sifive.com      SiFive
> --
> 2.17.1
>
>
>
 Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
