Received: from eggs.gnu.org ([2001:4830:134:3::10]:47946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGSoN-0001Sq-4u
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 12:19:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGSoL-0007jx-O3
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 12:18:59 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:35637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dGSoL-0007jG-Ge
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 12:18:57 -0400
Received: by mail-wm0-x22a.google.com with SMTP id b84so164969632wmh.0
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 09:18:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1494827476-1487-1-git-send-email-clg@kaod.org>
References: <1494827476-1487-1-git-send-email-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Jun 2017 17:18:35 +0100
Message-ID: <CAFEAcA9ex_kcN8JRcBw7M-cz9mZvQDb4AsD-3ra+97aui0qFfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/6] aspeed: I2C controller fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 15 May 2017 at 06:51, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> Hello,
>
> The new Linux driver for the Aspeed I2C controller revealed some
> serious limitations in the QEMU model. This series fixes these issues
> and also adds a couple of well-know I2C devices to the Aspeed
> machines.
>
> The QEMU model now supports the recent Linux driver and the older one.



Applied to target-arm.next, thanks.

-- PMM
