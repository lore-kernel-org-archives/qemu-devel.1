Received: from eggs.gnu.org ([208.118.235.92]:59138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfU6F-0003QZ-Uv
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 13:21:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfU6F-0008II-7W
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 13:21:39 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:43385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gfU6F-0008I1-2g
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 13:21:39 -0500
Received: by mail-ot1-x330.google.com with SMTP id a11so32789399otr.10
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 10:21:38 -0800 (PST)
MIME-Version: 1.0
References: <1546535297-11040-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<CAFEAcA-JCofFz44oaSaHMnAY-+ZjKVGBCw-hbsyW4upUQADErg@mail.gmail.com>
	<BN6PR2201MB12519B3FDAC3A43FC1B4BD91C68E0@BN6PR2201MB1251.namprd22.prod.outlook.com>
In-Reply-To: <BN6PR2201MB12519B3FDAC3A43FC1B4BD91C68E0@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jan 2019 18:21:27 +0000
Message-ID: <CAFEAcA9pNQVcGN6jTboo2boOfVQ0gSAbBk6+O70+BPCGS4xNWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v3 00/44] MIPS pull request for December
 2018 - v3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 4 Jan 2019 at 17:41, Aleksandar Markovic <amarkovic@wavecomp.com> wrote:
>
> > Applied, thanks.
> >
> > Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
> > for any user-visible changes.
>
> I updated the change log with a single item, as I mentioned in the pull
> request cover letter:
>
> https://wiki.qemu.org/ChangeLog/4.0#MIPS

That's fine, thanks. My 'applied this' emails for pull requests
are standard templates, so they'll always ask for changelog
updates even when that isn't necessarily applicable to a
particular pull. It's just intended as a reminder that
we're trying to do updates of the changelog as we go along
this release cycle.

-- PMM
