Received: from eggs.gnu.org ([2001:4830:134:3::10]:33963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffSEF-0003VE-FJ
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:49:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffSEE-0003Ha-Kj
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:49:31 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:34177)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffSEE-0003Gu-EP
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:49:30 -0400
Received: by mail-oi0-x241.google.com with SMTP id 13-v6so2944042ois.1
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 08:49:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1529699547-17044-3-git-send-email-alindsay@codeaurora.org>
References: <1529699547-17044-1-git-send-email-alindsay@codeaurora.org>
	<1529699547-17044-3-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jul 2018 16:49:09 +0100
Message-ID: <CAFEAcA-mywa80eTM6iJ0UDrFFYb3KZmhzEMz=OhhGTQd80JqbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 02/13] target/arm: Filter cycle counter
 based on PMCCFILTR_EL0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <aclindsa@gmail.com>

On 22 June 2018 at 21:32, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> The pmu_counter_enabled and pmu_op_start/finish functions are generic
> (as opposed to PMCCNTR-specific) to allow for the implementation of
> other events.
>
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
