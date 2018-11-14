Received: from eggs.gnu.org ([2001:4830:134:3::10]:49426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gMzgi-0005jt-4W
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 13:14:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gMzgf-0005iC-1o
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 13:14:52 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:35769)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1gMzge-0005aR-Oj
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 13:14:48 -0500
Received: by mail-pl1-x642.google.com with SMTP id v1-v6so1018198plo.2
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 10:14:40 -0800 (PST)
References: <20181108134139.31666-1-peter.maydell@linaro.org>
	<CAKmqyKMaW0Ye5E_PMZXpnUpYZRGdwCBEOf9Qr_bzJpPR=-_p2A@mail.gmail.com>
	<CAFEAcA-tct9gOM-mShPXhaZvMK1o14K4dcK-QbNxR5r36_DM2g@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Message-ID: <086b3ab4-6845-3884-bdd8-7c776d2e5d00@gmail.com>
Date: Wed, 14 Nov 2018 10:14:37 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-tct9gOM-mShPXhaZvMK1o14K4dcK-QbNxR5r36_DM2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Rob Herring <robh@kernel.org>, Thomas Huth <thuth@redhat.com>, Patch Tracking <patches@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Markus Armbruster <armbru@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, Jan Kiszka <jan.kiszka@web.de>, Antony Pavlov <antonynpavlov@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

On 14/11/2018 3:12 am, Peter Maydell wrote:
> On 13 November 2018 at 20:10, Alistair Francis <alistair23@gmail.com> wrote:
>> These two and the Xilinx boards seem a little out of place in this
>> patch. I agree they probably aren't maintained as well as they should
>> be, but the patch talks about orphaned boards and these four all have
>> active QEMU maintainers listed.
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

What about adding a "P:" tag for pull request sender?

Alistair

> 
> thanks
> -- PMM
> 
