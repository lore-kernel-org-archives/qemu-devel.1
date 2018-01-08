Received: from eggs.gnu.org ([2001:4830:134:3::10]:60658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYYNy-0001k7-7i
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:26:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYYNu-0004nX-BE
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:26:46 -0500
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:42486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYYNu-0004nC-5O
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:26:42 -0500
Received: by mail-oi0-x22a.google.com with SMTP id o64so7434738oia.9
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 06:26:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180102193622.27215-1-andrew.smirnov@gmail.com>
References: <20180102193622.27215-1-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2018 14:26:21 +0000
Message-ID: <CAFEAcA_0um53J-=KUecYpKc1ObaokO_sUjeXmQ0Z3EQY-tUn0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 00/11] i.MX FEC changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On 2 January 2018 at 19:36, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> Hi everyone,
>
> This patchset is v3 of a spin-off from original i.MX7 support submission
> found here [1], containing all of the patchest that are more or less
> agreed upon and are ready (hopefully!) for inclusion.

Thanks for the respin -- I've applied it to target-arm.next.

-- PMM
