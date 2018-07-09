Received: from eggs.gnu.org ([2001:4830:134:3::10]:38170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcUQx-0004YF-Uf
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 07:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcUQx-0003bw-6G
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 07:34:23 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:39435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fcUQx-0003aF-15
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 07:34:23 -0400
Received: by mail-oi0-x244.google.com with SMTP id d189-v6so35210575oib.6
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 04:34:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180709074350.27086-1-david@gibson.dropbear.id.au>
References: <20180709074350.27086-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jul 2018 12:34:01 +0100
Message-ID: <CAFEAcA9xtsCpHmEuNO3bRaCHe_U7kWWCJuOK_nd6wrEgdc7u2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/16] ppc-for-3.0 queue 20180709
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, BALATON Zoltan <balaton@eik.bme.hu>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>

On 9 July 2018 at 08:43, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit 43a473993fd9378bf850dcafa68eb6dee8c300f8:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-07-06 18:18:08 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-3.0-20180709
>
> for you to fetch changes up to 51b0d834c414f494410cc94e56886b6584ae3c54:
>
>   sam460ex: Make sam460ex_load_device_tree() handle all errors internally (2018-07-09 14:38:45 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2018-07-09
>
> Here's a final pull request before tomorrow's hard freeze.
>
> There are a number of fixes and improvements to the sm501 display
> driver (not strictly ppc related, but used only on ppc and SH).
> There's also a handful of unrelated fixes.
>
> Whether all the sm501 changes are bugfixes is somewhat debatable, but
> Peter has indicated he's ok with merging those for 3.0.
>
> ----------------------------------------------------------------
Applied, thanks.

-- PMM
