Received: from eggs.gnu.org ([2001:4830:134:3::10]:42030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fD5OT-0003tM-Ln
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:46:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fD5OS-0008Aa-SQ
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:46:49 -0400
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:35430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fD5OS-0008AC-Lg
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:46:48 -0400
Received: by mail-ot0-x22b.google.com with SMTP id h8-v6so8817618otb.2
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 02:46:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <767f617b-82fc-f256-e339-6927d0c7ba59@vivier.eu>
References: <20180430080404.7323-1-christophe.lyon@st.com>
	<CAFEAcA80NBYJ6BkTMsfBBZN91oJw3zE6A_a7uA2ESCkwb1Vgew@mail.gmail.com>
	<CAKdteOZt45ohyve_cgK6uarEiNiVOL2vVs=+GzENzFjg_1MM-w@mail.gmail.com>
	<CAFEAcA_Aoe0Jcyn0e6Eir5T+KXtVdfjz2c-+HrtVNtaxgmDYFw@mail.gmail.com>
	<CAKdteOY3FyXokDoViQWTL++EQ79sxNOuCgZeAxxakAQj8p2H5g@mail.gmail.com>
	<CAFEAcA-fOHNfBJnZfcPMj53v3Dc0anYptPcw7nyBBJBdFKUZpg@mail.gmail.com>
	<767f617b-82fc-f256-e339-6927d0c7ba59@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Apr 2018 10:46:27 +0100
Message-ID: <CAFEAcA8c50N_32mru3Z-5QfMM5p5WzRqRjsuoqXnoD=552ifUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [ARM/FDPIC v4 0/4] FDPIC ABI for ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Christophe Lyon <christophe.lyon@linaro.org>, Christophe Lyon <christophe.lyon@st.com>, QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 30 April 2018 at 10:28, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 30/04/2018 =C3=A0 11:12, Peter Maydell a =C3=A9crit :
>> Great. Riku/Laurent -- I'm assuming you're going to take this set
>> via the linux-user tree.
>
> I just sent a pull request without it...
>
> Do you prefer I update this one or I send another one later?

No, it can go into your next one I think. I see you've sent
the signal.c refactoring, which this will conflict with,
so either you or Christophe will need to rebase it anyway.

thanks
-- PMM
