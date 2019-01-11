Received: from eggs.gnu.org ([209.51.188.92]:54166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1ghzlm-0001h0-Ed
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:34:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1ghzll-0004U2-H3
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:34:54 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:46005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1ghzll-0004Tg-BZ
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:34:53 -0500
Received: by mail-oi1-x241.google.com with SMTP id y1so12647655oie.12
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 08:34:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20190107111129.2087-1-alex.bennee@linaro.org>
References: <20190107111129.2087-1-alex.bennee@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 11 Jan 2019 17:34:51 +0100
Message-ID: <CAL1e-=jZACpchHLoF_CtaLtLiySr0t527eao2wGci7Rsz1h2zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 0/3] gitdm updates
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

>
> Hi,
>
> Added a few more updates mostly of IBMers with non corporate emails.


Alex, it seems logical to me that you also create a section on gitdm in
MAINTAINERS, and set yourself as the maintainer for contrib/gitdm/*.

Alelsandar



> The year-end stats as per:
>
>  git log --numstat --after=3D"1/1/2018 00:00" \
>                    --before=3D"31/12/2018 23:59" | gitdm -n -l 10
>
> Are:
>
>   Top changeset contributors by employer
>   Red Hat                   3091 (43.3%)
>   Linaro                    1201 (16.8%)
>   (None)                     484 (6.8%)
>   IBM                        426 (6.0%)
>   Academics (various)        186 (2.6%)
>   Virtuozzo                  172 (2.4%)
>   Wave Computing             118 (1.7%)
>   Igalia                     109 (1.5%)
>   Xilinx                     102 (1.4%)
>   Cadence Design Systems      80 (1.1%)
>
>   Top lines changed by employer
>   Red Hat                   140523 (30.3%)
>   Cadence Design Systems    81010 (17.5%)
>   Linaro                    78098 (16.8%)
>   Wave Computing            33134 (7.1%)
>   IBM                       18918 (4.1%)
>   SiFive                    14436 (3.1%)
>   Academics (various)       11995 (2.6%)
>   (None)                    11458 (2.5%)
>   Virtuozzo                 10770 (2.3%)
>   Oracle                    6698 (1.4%)
>
> Alex Benn=C3=A9e (2):
>   contrib/gitdm: add Nokia and Proxmox to the domain-map
>   contrib/gitdm: add two more IBM'ers to group-map-ibm
>
> Joel Stanley (1):
>   contrib/gitdm: Add other IBMers
>
>  contrib/gitdm/domain-map    | 2 ++
>  contrib/gitdm/group-map-ibm | 7 +++++++
>  2 files changed, 9 insertions(+)
>
> --
> 2.17.1
>
>
>
