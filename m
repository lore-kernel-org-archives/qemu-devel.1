Received: from eggs.gnu.org ([2001:4830:134:3::10]:39976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gMtGy-0003ub-96
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:23:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gMtGt-0006Bx-GK
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:23:52 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1gMtGt-0006B6-98
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:23:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id b13so16830850wrx.6
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 03:23:47 -0800 (PST)
MIME-Version: 1.0
References: <20181108134139.31666-1-peter.maydell@linaro.org>
	<CAKmqyKMaW0Ye5E_PMZXpnUpYZRGdwCBEOf9Qr_bzJpPR=-_p2A@mail.gmail.com>
	<CAFEAcA-tct9gOM-mShPXhaZvMK1o14K4dcK-QbNxR5r36_DM2g@mail.gmail.com>
In-Reply-To: <CAFEAcA-tct9gOM-mShPXhaZvMK1o14K4dcK-QbNxR5r36_DM2g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Wed, 14 Nov 2018 12:23:34 +0100
Message-ID: <CAP+75-X9TcSQxtTKvRqp4vAGG--139Qb8tQdmQHwP+Pw3=6UrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: list myself as maintainer for
 various Arm boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: alistair23@gmail.com, QEMU Developers <qemu-devel@nongnu.org>, Rob Herring <robh@kernel.org>, Thomas Huth <thuth@redhat.com>, patches@linaro.org, Igor Mitsyanko <i.mitsyanko@gmail.com>, Markus Armbruster <armbru@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, Jan Kiszka <jan.kiszka@web.de>, Antony Pavlov <antonynpavlov@gmail.com>

On Wed, Nov 14, 2018 at 12:13 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> On 13 November 2018 at 20:10, Alistair Francis <alistair23@gmail.com> wrote:
> > These two and the Xilinx boards seem a little out of place in this
> > patch. I agree they probably aren't maintained as well as they should
> > be, but the patch talks about orphaned boards and these four all have
> > active QEMU maintainers listed.
>
> Yeah, I was planning to improve the commit message,
> something along the lines of an extra para:
>
> "The Xilinx boards are maintained, but patches to
> them go via the target-arm tree, so add myself as a
> maintainer there too."
>
> Really this is because we're overloading "maintainer"
> to mean both "this person cares about and is the
> primary reviewer and yes/no decision for them" and
> also "this person is responsible for getting the
> patches into the tree". Perhaps we should instead
> define a new letter tag for the latter ?

What about changing the 'M:' tag description to the one you just suggested?
