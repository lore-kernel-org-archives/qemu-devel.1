Received: from eggs.gnu.org ([209.51.188.92]:46068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1h3PCr-0007kF-Gh
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:59:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1h3OzR-0003om-Ue
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:45:31 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:52994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1h3OzP-0003m2-Bg
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:45:28 -0400
Received: by mail-wm1-x329.google.com with SMTP id f65so11787wma.2
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 10:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+F1CKBRNdLPb_wOLhURdUJd-j1RHY2toKSTEhCBt_zs4Xk1w@mail.gmail.com>
In-Reply-To: <CAJ+F1CKBRNdLPb_wOLhURdUJd-j1RHY2toKSTEhCBt_zs4Xk1w@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 11 Mar 2019 18:45:12 +0100
Message-ID: <CAJ+F1CLQTOH_mY__hgqtGXu7w0pDyCYTuTuZN-u-txKjrF-RAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Clearing slirp/ license
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>

Hi

On Wed, Feb 13, 2019 at 12:03 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi,
>
> As we are trying to move slirp/ in a standalone project, which
> eventually could be installed as a shared library, we need to clear
> the license.
>
> slirp is supposed to be 3-Clause BSD license (according to
> https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D2f5f89963186d42a7ded253=
bc6cf5b32abb45cec)
> but it seems to be effectively a 2-Clause BSD (the third clause is not
> in COPYRIGHT)
>
> However, there are two units that are GPL-2:
>

Thanks Thomas & Cedric.

Since this mail was sent, slirp/src/vmstate.c was added, based on qemu
implementation, which is attributed to Juan Quintela/

Juan, Could you reply that you have no objection in relicensing the
vmstate files as 3-Clause BSD?

thanks!

--=20
Marc-Andr=C3=A9 Lureau
