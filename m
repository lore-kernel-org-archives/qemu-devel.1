Received: from eggs.gnu.org ([2001:4830:134:3::10]:52932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1em6P9-00087y-Bi
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 18:24:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1em6P6-0008Jj-7e
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 18:23:59 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:58017)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1em6P6-0008Ix-0m
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 18:23:56 -0500
Date: Wed, 14 Feb 2018 18:23:54 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180214232354.GA1264@flamenco>
References: <1518053328-34687-1-git-send-email-mjc@sifive.com>
	<1518053328-34687-10-git-send-email-mjc@sifive.com>
	<20180213215541.GA1816@flamenco>
	<731db20e-4d86-e288-504c-30c83b56fd33@linaro.org>
	<20180214001053.GA23702@flamenco>
	<c2663cf3-54cc-d4fc-2cc5-151407d81c4b@linaro.org>
	<20180214195218.GA933@flamenco>
	<de71773f-08de-caf2-fdda-803760c79796@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de71773f-08de-caf2-fdda-803760c79796@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v5 09/23] RISC-V TCG Code Generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Michael Clark <mjc@sifive.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On Wed, Feb 14, 2018 at 13:13:09 -0800, Richard Henderson wrote:
> On 02/14/2018 11:52 AM, Emilio G. Cota wrote:
> > Should I send those patches to the list, or let Michael squash their changes?
> 
> That's up to you, I guess.  I don't mind if it goes in before or after merge.

OK, will send to the list once the merge is complete.

Thanks,

		Emilio
