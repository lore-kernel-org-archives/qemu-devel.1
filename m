Received: from eggs.gnu.org ([2001:4830:134:3::10]:51309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1em4Ms-00017V-Uh
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 16:13:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1em4Mq-0000nB-8R
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 16:13:30 -0500
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:45162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1em4Mq-0000mq-0f
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 16:13:28 -0500
Received: by mail-pg0-x22f.google.com with SMTP id e11so2534172pgq.12
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 13:13:27 -0800 (PST)
References: <1518053328-34687-1-git-send-email-mjc@sifive.com>
	<1518053328-34687-10-git-send-email-mjc@sifive.com>
	<20180213215541.GA1816@flamenco>
	<731db20e-4d86-e288-504c-30c83b56fd33@linaro.org>
	<20180214001053.GA23702@flamenco>
	<c2663cf3-54cc-d4fc-2cc5-151407d81c4b@linaro.org>
	<20180214195218.GA933@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <de71773f-08de-caf2-fdda-803760c79796@linaro.org>
Date: Wed, 14 Feb 2018 13:13:09 -0800
MIME-Version: 1.0
In-Reply-To: <20180214195218.GA933@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 09/23] RISC-V TCG Code Generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Michael Clark <mjc@sifive.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 02/14/2018 11:52 AM, Emilio G. Cota wrote:
> Should I send those patches to the list, or let Michael squash their changes?

That's up to you, I guess.  I don't mind if it goes in before or after merge.


r~
