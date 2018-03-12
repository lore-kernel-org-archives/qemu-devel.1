Received: from eggs.gnu.org ([2001:4830:134:3::10]:45630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evN7U-0000ay-Uq
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:04:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evN7O-0007Sq-Rn
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:04:04 -0400
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:32951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evN7O-0007Rk-L2
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:03:58 -0400
Received: by mail-oi0-x231.google.com with SMTP id e9so12222898oii.0
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 06:03:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180312070545.ktvvgp2kn2uxjpzk@sirius.home.kraxel.org>
References: <1520786414-8806-1-git-send-email-aishwaryakadlag@gmail.com>
	<6666720e-6f5c-0e8c-6c5a-ac36d708e314@redhat.com>
	<20180312070545.ktvvgp2kn2uxjpzk@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Mar 2018 13:03:37 +0000
Message-ID: <CAFEAcA8XSC1Tm_0AfQPA4Nz5sOZd3HLNDZD7jdBzmEzB5pEyzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V1]sm501: dead code removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Aishwarya Kadlag <aishwaryakadlag@gmail.com>

On 12 March 2018 at 07:05, Gerd Hoffmann <kraxel@redhat.com> wrote:
> Might be it actually is that easy.

In fact looking through the list archives I see you actually
sent a patchset to do this for the sm501 device back in March
last year:
http://lists.gnu.org/archive/html/qemu-devel/2017-03/msg01172.html

I think it didn't get applied mostly because it was on list
at the same time as a significant revamp of the sm501 device
code. So it probably won't apply cleanly to the current code,
but it looks like a good starting point for identifying what
the changes needed here are.

thanks
-- PMM
