Received: from eggs.gnu.org ([2001:4830:134:3::10]:58538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fD4fP-0002dN-3h
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fD4fO-0007D3-4P
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:00:15 -0400
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:34719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fD4fN-0007CP-SN
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:00:13 -0400
Received: by mail-oi0-x230.google.com with SMTP id l1-v6so6829300oii.1
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 02:00:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKdteOZt45ohyve_cgK6uarEiNiVOL2vVs=+GzENzFjg_1MM-w@mail.gmail.com>
References: <20180430080404.7323-1-christophe.lyon@st.com>
	<CAFEAcA80NBYJ6BkTMsfBBZN91oJw3zE6A_a7uA2ESCkwb1Vgew@mail.gmail.com>
	<CAKdteOZt45ohyve_cgK6uarEiNiVOL2vVs=+GzENzFjg_1MM-w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Apr 2018 09:59:52 +0100
Message-ID: <CAFEAcA_Aoe0Jcyn0e6Eir5T+KXtVdfjz2c-+HrtVNtaxgmDYFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [ARM/FDPIC v4 0/4] FDPIC ABI for ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe Lyon <christophe.lyon@linaro.org>
Cc: Christophe Lyon <christophe.lyon@st.com>, QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 30 April 2018 at 09:40, Christophe Lyon <christophe.lyon@linaro.org> wrote:
> On 30 April 2018 at 10:11, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 30 April 2018 at 09:03, Christophe Lyon <christophe.lyon@st.com> wrote:
>>> Hello,
>>>
>>> This patch series implements the QEMU contribution of the FDPIC
>>> ABI for ARM targets.
>>
>> Hi; I definitely reviewed at least some of these patches,
>> but this respin seems to have lost all the reviewed-by tags?
>>
> Indeed, I failed to include them.
> Shall I send a v5 including these tags?

No, but if you can check which ones should have them that would
be helpful.

thanks
-- PMM
