Received: from eggs.gnu.org ([2001:4830:134:3::10]:42751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gNEJT-0005qv-Dk
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 04:51:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gNEJO-000274-IN
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 04:51:50 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36839)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gNEJO-00025o-CE
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 04:51:46 -0500
Received: by mail-wr1-x442.google.com with SMTP id z13-v6so20465338wrs.3
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 01:51:44 -0800 (PST)
References: <20181108134139.31666-1-peter.maydell@linaro.org>
	<CAKmqyKMaW0Ye5E_PMZXpnUpYZRGdwCBEOf9Qr_bzJpPR=-_p2A@mail.gmail.com>
	<CAFEAcA-tct9gOM-mShPXhaZvMK1o14K4dcK-QbNxR5r36_DM2g@mail.gmail.com>
	<086b3ab4-6845-3884-bdd8-7c776d2e5d00@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <086b3ab4-6845-3884-bdd8-7c776d2e5d00@gmail.com>
Date: Thu, 15 Nov 2018 09:51:42 +0000
Message-ID: <87lg5ud5xt.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Rob Herring <robh@kernel.org>, Thomas Huth <thuth@redhat.com>, Patch Tracking <patches@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Markus Armbruster <armbru@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, Jan Kiszka <jan.kiszka@web.de>, Antony Pavlov <antonynpavlov@gmail.com>, Philippe =?utf-8?Q?Mathieu-Daud?= =?utf-8?Q?=C3=A9?= <philmd@redhat.com>


Alistair Francis <alistair23@gmail.com> writes:

> On 14/11/2018 3:12 am, Peter Maydell wrote:
>> On 13 November 2018 at 20:10, Alistair Francis <alistair23@gmail.com> wr=
ote:
>>> These two and the Xilinx boards seem a little out of place in this
>>> patch. I agree they probably aren't maintained as well as they should
>>> be, but the patch talks about orphaned boards and these four all have
>>> active QEMU maintainers listed.
>>
>> Yeah, I was planning to improve the commit message,
>> something along the lines of an extra para:
>>
>> "The Xilinx boards are maintained, but patches to
>> them go via the target-arm tree, so add myself as a
>> maintainer there too."
>>
>> Really this is because we're overloading "maintainer"
>> to mean both "this person cares about and is the
>> primary reviewer and yes/no decision for them" and
>> also "this person is responsible for getting the
>> patches into the tree". Perhaps we should instead
>> define a new letter tag for the latter ?
>
> What about adding a "P:" tag for pull request sender?

Don't all pull requests generally come from the relevant T: (tree)? We
could either extend that or just state the first M: in the list is the
person who owns the relevant tree.

>
> Alistair
>
>>
>> thanks
>> -- PMM
>>


--
Alex Benn=C3=A9e
