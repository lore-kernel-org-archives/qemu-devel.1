Received: from eggs.gnu.org ([2001:4830:134:3::10]:58942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1er0YJ-00066a-Tz
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 07:09:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1er0YJ-0008BQ-3Z
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 07:09:43 -0500
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:35423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1er0YI-0008BG-UJ
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 07:09:43 -0500
Received: by mail-ot0-x22f.google.com with SMTP id w2so1998102otg.2
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 04:09:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-kUW+cKPiwzkhLm=+3f-HnkeOCURR73JkFNtd9LE-ABA@mail.gmail.com>
References: <1519690504-37792-1-git-send-email-mjc@sifive.com>
	<CAFEAcA_0qNcikG2iLii=4zEPYvhz1koEbhCCrCXssdKYv06OJA@mail.gmail.com>
	<CADJ6UvPQMDq_RES_u6WUmXHsita+On4oLu-V=emp3MnmmzjHhQ@mail.gmail.com>
	<CAHNT7Nv04hScm7QDtJMhFZeB=WOyOQ6HW1J-xOEO11GM1xFqyA@mail.gmail.com>
	<CAFEAcA-kUW+cKPiwzkhLm=+3f-HnkeOCURR73JkFNtd9LE-ABA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Feb 2018 12:09:21 +0000
Message-ID: <CAFEAcA8dMT_KK53c=pS1g_x5LPhi=ZBxo2Wjuihu6tg-w_mz=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [patches] Re: [PULL] RISC-V QEMU Port Submission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: Stef O'Rear <sorear2@gmail.com>, RISC-V Patches <patches@groups.riscv.org>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On 28 February 2018 at 11:53, Peter Maydell <peter.maydell@linaro.org> wrote:
> With my 'upstream dev' hat on, I tend to be suspicious of this
> line of argument, because in a lot of cases what tends to happen
> is that the code for some new target or device goes in-tree, and
> then the people who worked on submitting it disappear, or never
> actually do get round to refactoring[*]. You get more leeway for
> making this argument the longer you've been around and participating
> in QEMU development, because then you have a track record of
> following up on things.

That said, I can probably live with it in this particular instance,
given when the 2.12 codefreeze deadline is.

thanks
-- PMM
