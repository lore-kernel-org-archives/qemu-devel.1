Received: from eggs.gnu.org ([2001:4830:134:3::10]:35512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ea2ra-0005wq-Us
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:11:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ea2rZ-0004ur-W9
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:11:30 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:40568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ea2rZ-0004ta-PO
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:11:29 -0500
Received: by mail-wr0-x241.google.com with SMTP id 100so5894364wrb.7
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 09:11:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1512682213-4354-9-git-send-email-minyard@acm.org>
References: <1512682213-4354-1-git-send-email-minyard@acm.org>
	<1512682213-4354-9-git-send-email-minyard@acm.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 12 Jan 2018 18:11:28 +0100
Message-ID: <CAJ+F1CK90yHrtcv2RtDUEHYiKybi38th2UGqkQ4RhMcNCJ7uVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 8/8] Add maintainer for the IPMI code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <minyard@acm.org>
Cc: QEMU <qemu-devel@nongnu.org>, Corey Minyard <cminyard@mvista.com>

On Thu, Dec 7, 2017 at 10:30 PM,  <minyard@acm.org> wrote:
> From: Corey Minyard <cminyard@mvista.com>
>
> Signed-off-by: Corey Minyard <cminyard@mvista.com>

Could be the first patch of the series!

Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks!

> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0255113..6483f79 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -924,6 +924,15 @@ F: tests/ahci-test.c
>  F: tests/libqos/ahci*
>  T: git git://github.com/jnsnow/qemu.git ide
>
> +IPMI
> +M: Corey Minyard <minyard@acm.org>
> +S: Maintained
> +F: include/hw/ipmi/*
> +F: hw/ipmi/*
> +F: hw/smbios/smbios_type_38.c
> +F: tests/ipmi*
> +T: git git://github.com/cminyard/qemu.git master-ipmi-rebase
> +
>  Floppy
>  M: John Snow <jsnow@redhat.com>
>  L: qemu-block@nongnu.org
> --
> 2.7.4
>
>



--=20
Marc-Andr=C3=A9 Lureau
