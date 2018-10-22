Received: from eggs.gnu.org ([2001:4830:134:3::10]:52169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gEjwT-0008Ch-J4
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 19:49:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gEjm1-0001Sx-17
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 19:38:16 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:45174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gEjm0-0001Se-SB
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 19:38:12 -0400
Received: by mail-yb1-f194.google.com with SMTP id 131-v6so2150193ybe.12
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 16:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <1540209445-28831-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540209445-28831-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 23 Oct 2018 01:38:00 +0200
Message-ID: <CAAdtpL7b0ki5VRX3scG++W4kwVviFrxtqnefqjGjoAFHjhqm6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] target/mips: Two corrections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

On Mon, Oct 22, 2018 at 1:59 PM Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> This small series adds two corrections for issues reported recently.
>
> Aleksandar Markovic (2):
>   target/mips: Fix the title of translate.c
>   target/mips: Fix decoding of ALIGN and DALIGN instructions

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
