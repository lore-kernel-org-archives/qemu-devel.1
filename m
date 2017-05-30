Received: from eggs.gnu.org ([2001:4830:134:3::10]:57430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFjiL-0007t7-0S
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:09:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFjiK-0000Z2-7r
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:09:44 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:36030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dFjiK-0000Yo-2J
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:09:44 -0400
Received: by mail-wm0-x231.google.com with SMTP id 7so96007248wmo.1
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 09:09:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1494697399-352-1-git-send-email-eric.auger@redhat.com>
References: <1494697399-352-1-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2017 17:09:22 +0100
Message-ID: <CAFEAcA_LNipd3oxtcLdm7g_65E39YHKxkd--1Tf6LhVOytgY=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v4 0/5] ARM SMMUv3 Emulation Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, prem.mallappa@gmail.com, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, Radha Mohan <mohun106@gmail.com>, Trey Cain <tcain@qti.qualcomm.com>

On 13 May 2017 at 18:43, Eric Auger <eric.auger@redhat.com> wrote:
> This series introduces the emulation code for ARM SMMUv3.
> This is the continuation of Prem's work [1].
>
> This v4 is yet another visibility step as many restrictions apply
> to the model at the moment:

I had a quick scan through to see if anything leapt out
as odd, and have sent a few comments, but I'm assuming
you don't want in-depth review at this time (and hoping
that somebody else will provide it when you do want it ;-)).

thanks
-- PMM
