Received: from eggs.gnu.org ([2001:4830:134:3::10]:55981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1eqIR8-0005pG-4E
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 08:03:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1eqIR7-0000W7-8i
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 08:03:22 -0500
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:37514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
	id 1eqIR7-0000Vf-34
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 08:03:21 -0500
Received: by mail-ot0-x229.google.com with SMTP id t2so1823669otj.4
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 05:03:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8kj_anJKOccobs25+dcENQ1Oc0DhiFFbb4A=wuJnk8UA@mail.gmail.com>
References: <1519344729-73482-1-git-send-email-mjc@sifive.com>
	<20180223101032.GA31076@redhat.com>
	<CAHNT7NvMMAD6sAT60RnLgFXwdFPWHEXtysMQt04Qejnpw30Bkg@mail.gmail.com>
	<20180226104723.GH14196@redhat.com>
	<CAFEAcA_Gwh3EpVVhZ_zU3LuogZXjh8cpRWrvtHbNdfgQmdzgJg@mail.gmail.com>
	<20180226120344.GN14196@redhat.com>
	<CAFEAcA8kj_anJKOccobs25+dcENQ1Oc0DhiFFbb4A=wuJnk8UA@mail.gmail.com>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Mon, 26 Feb 2018 14:03:18 +0100
Message-ID: <CABoDooPoqSciJLcGbPj=rWmHfYO=JMhkJJzaHKrehf29qW=pAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 00/23] RISC-V QEMU Port Submission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Clark <mjc@sifive.com>, RISC-V Patches <patches@groups.riscv.org>

On Mon, Feb 26, 2018 at 1:32 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> Paragraph (3) isn't saying "BSD license is special",
> it's saying "the TCG codegen code is special" -- it's a theoretically
> well-defined reusable subset of code that has its own tighter standards
> for what license we accept (see also tcg/LICENSE).

That tcg/LICENSE file has alas become obsolete since the AArch64
back-end and its GPLv2+ license was added.  That's quite unfortunate.


Laurent
