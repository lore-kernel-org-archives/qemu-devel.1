Received: from eggs.gnu.org ([2001:4830:134:3::10]:57350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gAIwM-0005dc-Vy
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 14:10:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gAIwL-0001VC-IL
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 14:10:34 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gAIwK-0001RK-Ho
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 14:10:33 -0400
Received: by mail-ot1-x342.google.com with SMTP id 14so2284845oth.2
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 11:10:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <mhng-99c18a25-be61-4fa6-93c6-313a0fa37372@palmer-si-x1c4>
References: <cover.1539023064.git.alistair.francis@wdc.com>
	<mhng-99c18a25-be61-4fa6-93c6-313a0fa37372@palmer-si-x1c4>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Oct 2018 19:10:07 +0100
Message-ID: <CAFEAcA_fmoBRTk0VKEjuu82eb7piCkq588+v7RT7r6f=_4=OVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 0/5] Misc RISC-V patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, Alistair Francis <alistair23@gmail.com>, Michael Clark <mjc@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>

On 10 October 2018 at 18:49, Palmer Dabbelt <palmer@sifive.com> wrote:
> we should really
> get the ball rolling on our big patch backlog.

Yes, please do. Softfreeze is not all that far away and I
would strongly prefer not to get an enormous sized pull
request at the last minute. The ideal pattern is that
code changes come in at a steady rate across the whole
of the 'open' part of the development cycle.

thanks
-- PMM
