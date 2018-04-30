Received: from eggs.gnu.org ([2001:4830:134:3::10]:42334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fD5Pf-0004h0-DI
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:48:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fD5Pc-0000Lr-8s
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:48:03 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:57225)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fD5Pb-0000LZ-VH
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:48:00 -0400
References: <20180430080404.7323-1-christophe.lyon@st.com>
	<CAFEAcA80NBYJ6BkTMsfBBZN91oJw3zE6A_a7uA2ESCkwb1Vgew@mail.gmail.com>
	<CAKdteOZt45ohyve_cgK6uarEiNiVOL2vVs=+GzENzFjg_1MM-w@mail.gmail.com>
	<CAFEAcA_Aoe0Jcyn0e6Eir5T+KXtVdfjz2c-+HrtVNtaxgmDYFw@mail.gmail.com>
	<CAKdteOY3FyXokDoViQWTL++EQ79sxNOuCgZeAxxakAQj8p2H5g@mail.gmail.com>
	<CAFEAcA-fOHNfBJnZfcPMj53v3Dc0anYptPcw7nyBBJBdFKUZpg@mail.gmail.com>
	<767f617b-82fc-f256-e339-6927d0c7ba59@vivier.eu>
	<CAFEAcA8c50N_32mru3Z-5QfMM5p5WzRqRjsuoqXnoD=552ifUg@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <b70e606e-950d-975c-473e-903e69ec322c@vivier.eu>
Date: Mon, 30 Apr 2018 11:47:45 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8c50N_32mru3Z-5QfMM5p5WzRqRjsuoqXnoD=552ifUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [ARM/FDPIC v4 0/4] FDPIC ABI for ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christophe Lyon <christophe.lyon@linaro.org>, Christophe Lyon <christophe.lyon@st.com>, QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

Le 30/04/2018 à 11:46, Peter Maydell a écrit :
> On 30 April 2018 at 10:28, Laurent Vivier <laurent@vivier.eu> wrote:
>> Le 30/04/2018 à 11:12, Peter Maydell a écrit :
>>> Great. Riku/Laurent -- I'm assuming you're going to take this set
>>> via the linux-user tree.
>>
>> I just sent a pull request without it...
>>
>> Do you prefer I update this one or I send another one later?
> 
> No, it can go into your next one I think. I see you've sent
> the signal.c refactoring, which this will conflict with,
> so either you or Christophe will need to rebase it anyway.

Yes, I will.

Thanks,
Laurent
