Received: from eggs.gnu.org ([2001:4830:134:3::10]:55919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cim5p-000655-2J
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:01:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cim5n-0007xD-Vs
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:01:45 -0500
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:35992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cim5n-0007wV-Pd
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:01:43 -0500
Received: by mail-wr0-x22b.google.com with SMTP id u108so14206124wrb.3
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 10:01:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170228142918.GA7745@pacoca>
References: <1488224492-20316-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1488224492-20316-3-git-send-email-joserz@linux.vnet.ibm.com>
	<CAFEAcA_DD1KmSR+U-4jSVbycO+QwZ9ebc_k4RJ2+TqZD2jiB5w@mail.gmail.com>
	<20170228142918.GA7745@pacoca>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Feb 2017 18:01:20 +0000
Message-ID: <CAFEAcA8=WFvjU1tON50ve8DLFm-4uh+APbBPoZCdR2vurGHLuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH Risu 2/5] risu_reginfo_ppc64le: Remove
 unused code from PPC64 register comparison
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

On 28 February 2017 at 14:29,  <joserz@linux.vnet.ibm.com> wrote:
> On Tue, Feb 28, 2017 at 01:43:22PM +0000, Peter Maydell wrote:
>> I have a variation on this patch already in my set of refactoring
>> patches that I posted last week:
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg06152.html
>
> Sorry, I missed that commit. I'll send a v2 with the fix suggested by
> Nikunj and without this one.

No problem. I've just pushed that refactoring series to risu master
so you probably want to rebase on that. I've also grabbed patch 5
of this series because it was an obvious change.

thanks
-- PMM
