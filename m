Received: from eggs.gnu.org ([2001:4830:134:3::10]:37737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fD57M-00054T-7c
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:29:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fD57I-0007os-UP
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:29:08 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:59647)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fD57I-0007oM-Kh
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:29:04 -0400
References: <20180430080404.7323-1-christophe.lyon@st.com>
	<CAFEAcA80NBYJ6BkTMsfBBZN91oJw3zE6A_a7uA2ESCkwb1Vgew@mail.gmail.com>
	<CAKdteOZt45ohyve_cgK6uarEiNiVOL2vVs=+GzENzFjg_1MM-w@mail.gmail.com>
	<CAFEAcA_Aoe0Jcyn0e6Eir5T+KXtVdfjz2c-+HrtVNtaxgmDYFw@mail.gmail.com>
	<CAKdteOY3FyXokDoViQWTL++EQ79sxNOuCgZeAxxakAQj8p2H5g@mail.gmail.com>
	<CAFEAcA-fOHNfBJnZfcPMj53v3Dc0anYptPcw7nyBBJBdFKUZpg@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <767f617b-82fc-f256-e339-6927d0c7ba59@vivier.eu>
Date: Mon, 30 Apr 2018 11:28:51 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-fOHNfBJnZfcPMj53v3Dc0anYptPcw7nyBBJBdFKUZpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [ARM/FDPIC v4 0/4] FDPIC ABI for ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Christophe Lyon <christophe.lyon@linaro.org>
Cc: Christophe Lyon <christophe.lyon@st.com>, QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

Le 30/04/2018 à 11:12, Peter Maydell a écrit :
> On 30 April 2018 at 10:08, Christophe Lyon <christophe.lyon@linaro.org> wrote:
>> On 30 April 2018 at 10:59, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> On 30 April 2018 at 09:40, Christophe Lyon <christophe.lyon@linaro.org> wrote:
>>>> On 30 April 2018 at 10:11, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>>> On 30 April 2018 at 09:03, Christophe Lyon <christophe.lyon@st.com> wrote:
>>>>>> Hello,
>>>>>>
>>>>>> This patch series implements the QEMU contribution of the FDPIC
>>>>>> ABI for ARM targets.
>>>>>
>>>>> Hi; I definitely reviewed at least some of these patches,
>>>>> but this respin seems to have lost all the reviewed-by tags?
>>>>>
>>>> Indeed, I failed to include them.
>>>> Shall I send a v5 including these tags?
>>>
>>> No, but if you can check which ones should have them that would
>>> be helpful.
>>>
>> OK, so all 4 patches have
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> (you added it to patch 3/4, provided I fixed the nits, which I did in v4).
> 
> Great. Riku/Laurent -- I'm assuming you're going to take this set
> via the linux-user tree.

I just sent a pull request without it...

Do you prefer I update this one or I send another one later?

Thanks,
Laurent
