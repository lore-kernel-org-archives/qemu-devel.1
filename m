Received: from eggs.gnu.org ([2001:4830:134:3::10]:37622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZwOR-0008Sc-7N
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:49:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZwOQ-00011N-HJ
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:49:15 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:39648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fZwOQ-00010u-AY
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:49:14 -0400
Received: by mail-oi0-x22f.google.com with SMTP id d189-v6so6772480oib.6
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 03:49:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1807021219520.6605@zero.eik.bme.hu>
References: <cover.1530047900.git.balaton@eik.bme.hu>
	<alpine.BSF.2.21.1806302231400.45338@zero.eik.bme.hu>
	<CAFEAcA_ymngY5i5BWQ6-xAveCWjs0QKrORSAy9nH1A8m9672Fg@mail.gmail.com>
	<alpine.BSF.2.21.1807021219520.6605@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Jul 2018 11:48:53 +0100
Message-ID: <CAFEAcA95syay_9TOvh6hrtvN4vcH74gSXsGif7cugcgWaHooyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/7] Misc sm501 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Sebastian Bauer <mail@sebastianbauer.info>, Magnus Damm <magnus.damm@gmail.com>, Philippe Mathieu-Daude <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>, David Gibson <david@gibson.dropbear.id.au>

On 2 July 2018 at 11:33, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> Thank you. Please agree on what should be the needed action here. It would
> be a pity if this missed 3.0 because of this. Could it be merged before the
> freeze if no obvious problems are found with that it can be removed later if
> it causes any trouble (I think that's unlikely as it's only touches rarely
> used parts).

These are bug fixes, so there is no strict requirement for them
to get in for the softfreeze deadline. I agree that we should
get these in for 3.0.

thanks
-- PMM
