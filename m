Received: from eggs.gnu.org ([2001:4830:134:3::10]:50577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQuJT-0003b6-Ty
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:46:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQuJT-0000Mu-1L
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:46:47 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:44812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQuJS-0000MC-SS
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:46:46 -0400
Received: by mail-oi0-x244.google.com with SMTP id c128-v6so8452922oig.11
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 05:46:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1528233505-25842-1-git-send-email-thuth@redhat.com>
References: <1528233505-25842-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Jun 2018 13:46:25 +0100
Message-ID: <CAFEAcA9kb-hjitW45FgiVmmUoyH=zTctEc0Z9ktQZOz=F6_eCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm: Remove the deprecated xlnx-ep108
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>

On 5 June 2018 at 22:18, Thomas Huth <thuth@redhat.com> wrote:
> It has been marked as deprecated since QEMU v2.11, so it is time to
> remove this now. The xlnx-zcu102 machine is very much the same and
> can be used as a replacement instead.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied to target-arm.next, thanks.

-- PMM
