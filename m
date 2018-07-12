Received: from eggs.gnu.org ([2001:4830:134:3::10]:56223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdd2e-0002qe-PE
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdd2d-0001Ew-VA
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:58:00 -0400
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:46670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fdd2d-0001EU-PG
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:57:59 -0400
Received: by mail-oi0-x235.google.com with SMTP id y207-v6so56326001oie.13
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 07:57:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180712132538.21921-1-otubo@redhat.com>
References: <20180712132538.21921-1-otubo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jul 2018 15:57:38 +0100
Message-ID: <CAFEAcA_CG7JOXA2cKo+K92UStic5=RyZ_Gp3L44=heocCjy1yQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/1] seccomp branch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 12 July 2018 at 14:25, Eduardo Otubo <otubo@redhat.com> wrote:
> The following changes since commit c447afd5783b9237fa51b7a85777007d8d568b=
fc:
>
>   Update version for v3.0.0-rc0 release (2018-07-10 18:19:50 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/otubo/qemu.git tags/pull-seccomp-20180712
>
> for you to fetch changes up to 056de1e894155fbb99e7b43c1c4382d4920cf437:
>
>   seccomp: allow sched_setscheduler() with SCHED_IDLE policy (2018-07-12 =
14:52:39 +0200)
>
> ----------------------------------------------------------------
> pull-seccomp-20180712
>
> ----------------------------------------------------------------
> Marc-Andr=C3=A9 Lureau (1):
>       seccomp: allow sched_setscheduler() with SCHED_IDLE policy
>
>  qemu-seccomp.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)


Applied, thanks.

-- PMM
