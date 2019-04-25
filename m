Received: from eggs.gnu.org ([209.51.188.92]:47203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hJX3j-0003hD-Lc
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 01:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hJWzE-0006Ms-Ey
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 01:31:57 -0400
MIME-Version: 1.0
In-Reply-To: <73a7ce8a-1d73-95f7-84a6-f0960a397c22@linaro.org>
References: <mhng-4fc40e41-5464-469e-9334-1edc4f8294e3@palmer-si-x1e>
	<73a7ce8a-1d73-95f7-84a6-f0960a397c22@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 25 Apr 2019 07:31:49 +0200
Message-ID: <CAL1e-=gTwNJ94-ZdhPZR_THAi_TfiToox0KrxLZnhARbjUKLxw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.1 1/8] target/riscv: Name the
 argument sets for all of insn32 formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@sifive.com>

On Apr 25, 2019 7:17 AM, "Richard Henderson" <richard.henderson@linaro.org>
wrote:
>
> On 4/24/19 8:31 PM, Palmer Dabbelt wrote:
> >>  # Argument sets:
> >> +&empty
> >
> > If I understand decodetree correctly, this isn't used until patch 5.
> > Otherwise,
> >
>
> I think it's used as early as patch 3, but I haven't looked in detail to
be sure.
>
>
> r~
>

I think it is a very bad practice to leave the commit message empty, and,
in my view, the long-time contributor, like you, Richard, have the
obligation to always give examples of commit messages of good quality.
Leaving empty commit messages should not be a =E2=80=9Dprivelage=E2=80=9D t=
hat comes with
seniority, IMHO. On the contrary.

Sincerely,
Aleksandar
