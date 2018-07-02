Received: from eggs.gnu.org ([2001:4830:134:3::10]:38244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fZwSB-0001zO-Gf
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fZwS8-0002lk-BF
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:53:07 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:62994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1fZwS8-0002lQ-2g
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:53:04 -0400
Date: Mon, 2 Jul 2018 12:53:02 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA95syay_9TOvh6hrtvN4vcH74gSXsGif7cugcgWaHooyg@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.1807021250310.6605@zero.eik.bme.hu>
References: <cover.1530047900.git.balaton@eik.bme.hu>
	<alpine.BSF.2.21.1806302231400.45338@zero.eik.bme.hu>
	<CAFEAcA_ymngY5i5BWQ6-xAveCWjs0QKrORSAy9nH1A8m9672Fg@mail.gmail.com>
	<alpine.BSF.2.21.1807021219520.6605@zero.eik.bme.hu>
	<CAFEAcA95syay_9TOvh6hrtvN4vcH74gSXsGif7cugcgWaHooyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH v2 0/7] Misc sm501 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Sebastian Bauer <mail@sebastianbauer.info>, Magnus Damm <magnus.damm@gmail.com>, Philippe Mathieu-Daude <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>, David Gibson <david@gibson.dropbear.id.au>

On Mon, 2 Jul 2018, Peter Maydell wrote:
> On 2 July 2018 at 11:33, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> Thank you. Please agree on what should be the needed action here. It would
>> be a pity if this missed 3.0 because of this. Could it be merged before the
>> freeze if no obvious problems are found with that it can be removed later if
>> it causes any trouble (I think that's unlikely as it's only touches rarely
>> used parts).
>
> These are bug fixes, so there is no strict requirement for them
> to get in for the softfreeze deadline. I agree that we should
> get these in for 3.0.

Some of them do implement new features of sm501 previously not emulated so 
it depends on your judgement but if we get a green card from you that 
these can get in as bugfixes before hard freeze then I'm not worried that 
much. :-)

Thank you,
BALATON Zoltan
