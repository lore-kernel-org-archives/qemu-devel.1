Received: from eggs.gnu.org ([2001:4830:134:3::10]:56592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWO2s-0000iY-Ky
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:32:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWO2r-00006k-MI
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:32:18 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:38658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fWO2r-000068-GD
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:32:17 -0400
Received: by mail-ot0-x242.google.com with SMTP id p95-v6so7939461ota.5
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 08:32:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b80b128f-916a-a114-97e3-96705321503d@amsat.org>
References: <20180620120620.12806-1-yongbok.kim@mips.com>
	<263756cc-6869-de24-3f9b-140d24025829@amsat.org>
	<5d9fc1151a1045eab8c6ace71b772f94@mips.com>
	<b80b128f-916a-a114-97e3-96705321503d@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 16:31:56 +0100
Message-ID: <CAFEAcA9wYJpYTvMY4bVy4-NPputq4j-SwtqFYQFz4D_TjobANg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/35] nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Aleksandar Markovic <Aleksandar.Markovic@mips.com>, Yongbok Kim <Yongbok.Kim@mips.com>, James Hogan <James.Hogan@mips.com>, Paul Burton <Paul.Burton@mips.com>, Stefan Markovic <Stefan.Markovic@mips.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Matthew Fortune <Matthew.Fortune@mips.com>

On 22 June 2018 at 16:16, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> On 06/22/2018 11:39 AM, Aleksandar Markovic wrote:
>> If nobody objects, while integrating/applying, I am going to change all =
instances of "@imgtec.com" to "@mips.com" for this series.
>>
>> Some of the patches might have been developed while the company was part=
 of Imagination Technologies - however, I think it is reasonable to use ema=
il addresses at the moment of submitting changes to this list. This gets co=
mplicated if, for example, a person leaves the company before his/her email=
 address changes, but I think, in this case, using "@mips.com" is appropria=
te for all involved persons.
>
> Well, since imgtec.com entries are in .mailmap, and get_maintainer.pl
> parses it, maybe there is a bug in the script.
>
> The 'From' is used for the git author, and IMO should be @mips.com.
>
> To respect Imagination Technologies efforts, can this work?
>
> Signed-off-by: James Hogan <james.hogan@mips.com> for Imagination
> Technologies

That seems a bit weird to me. I would stick with just using
the mips addresses.

thanks
-- PMM
