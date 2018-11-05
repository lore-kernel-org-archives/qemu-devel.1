Received: from eggs.gnu.org ([2001:4830:134:3::10]:54727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJj8V-0003Kd-5z
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 12:58:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJj8U-0001WW-Az
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 12:58:03 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:40827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gJj8U-0001TN-2t
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 12:58:02 -0500
Received: by mail-oi1-x242.google.com with SMTP id u130-v6so8265041oie.7
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 09:57:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB018970A4F8FA0E42B5DD48229ECA0@MWHPR21MB0189.namprd21.prod.outlook.com>
References: <20181102001303.32640-1-f4bug@amsat.org>
	<20181102001303.32640-2-f4bug@amsat.org>
	<CAFEAcA-DZMivo-epUmM6NxPzCUbGCfSU+SxEjszTNLdVaB8UxQ@mail.gmail.com>
	<MWHPR21MB018970A4F8FA0E42B5DD48229ECA0@MWHPR21MB0189.namprd21.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Nov 2018 17:57:38 +0000
Message-ID: <CAFEAcA-=Y80ZgFOJfVzCxqjaJvG1yO5aBR7efX4OGtOKSXeq2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for 3.1 v2 1/7] MAINTAINERS: Add an entry
 for the Raspberry Pi machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Guenter Roeck <linux@roeck-us.net>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 5 November 2018 at 17:06, Andrew Baumann
<Andrew.Baumann@microsoft.com> wrote:
> From: Peter Maydell <peter.maydell@linaro.org>
>> Andrew, as the original submitter of the Raspberry Pi code would you like to
>> be listed as a maintainer for it?
>
> Thanks for asking; probably not -- I'm happy to review the odd patch
> if my input would be helpful, but I haven't worked on it for years,
> and I don't have spare cycles, so I'd just be a bottleneck.

Sure, no problem. Would you like to be listed as a "reviewer"
(means people will CC you on patches, basically), or not at all?

We could maybe downgrade it to Orphan from Odd Fixes, unless
Philippe wants to volunteer as an "odd fixes" maintainer...

thanks
-- PMM
