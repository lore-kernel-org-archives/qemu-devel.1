Received: from eggs.gnu.org ([209.51.188.92]:53143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1ghzhB-000701-LU
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:30:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1ghzh8-0002DS-FR
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:30:09 -0500
MIME-Version: 1.0
In-Reply-To: <20190111155555.8270-1-philmd@redhat.com>
References: <20190111155555.8270-1-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 11 Jan 2019 17:29:57 +0100
Message-ID: <CAL1e-=hmJegfALunXYQLCMAutu9RS_61Te9azVpkqhgYCDU-xA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] contrib/gitdm: Fix a typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Friday, January 11, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
>
wrote:

> Typo comes from upstream git://git.lwn.net/gitdm.git.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  contrib/gitdm/filetypes.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/gitdm/filetypes.txt b/contrib/gitdm/filetypes.txt
> index 15d6f803b9..165b71b3f9 100644
> --- a/contrib/gitdm/filetypes.txt
> +++ b/contrib/gitdm/filetypes.txt
> @@ -4,7 +4,7 @@
>  # This program is free software; you can redistribute it and/or modify
>  # it under the terms of the GNU General Public License as published by
>  # the Free Software Foundation; either version 2 of the License, or
> -# (at your option  any later version.
> +# (at your option) any later version.
>  #
>  # This program is distributed in the hope that it will be useful,
>  # but WITHOUT ANY WARRANTY; without even the implied warranty of


Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>


> --
> 2.17.2
>
>
>
