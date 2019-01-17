Received: from eggs.gnu.org ([209.51.188.92]:47481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gkBpW-0005N3-9o
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:51:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gkBpU-0005CJ-UR
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:51:50 -0500
References: <CALvuzg43uSodseEHjNaRcPFBKKPTY2mcppUbYgiLL=QO9RxX_Q@mail.gmail.com>
	<e62bbdda-2ab9-b9a1-7843-0a3a40f56282@vivier.eu>
	<4cfad0f8-1b66-b6be-693e-ba439e81f171@sysgo.com>
	<f36c1752-98ad-7c44-4637-7186c7511f38@vivier.eu>
	<20190111003527.GO6682@umbus.fritz.box>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <1bbc0576-8371-3cd3-bce9-1374e852fc78@vivier.eu>
Date: Thu, 17 Jan 2019 18:51:29 +0100
MIME-Version: 1.0
In-Reply-To: <20190111003527.GO6682@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] ppc: e6500 registers SPR 604 twice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Jon Diekema <jon.diekema@gmail.com>, Roman Kapl <rka@sysgo.com>, qemu-trivial@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>, Roman Kapl <roman.kapl@sysgo.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On 11/01/2019 01:35, David Gibson wrote:
> On Wed, Jan 09, 2019 at 11:17:00AM +0100, Laurent Vivier wrote:
>> David,
>>
>> will you take this through your ppc branch?
> 
> Somehow I missed this one, sorry.  Even when I look back through my
> mail archives I can't see the original message of this thread.  Can
> you resend please?

As it is in the qemu-trivial ML, I've applied this patch to the 
trivial-patches branch.

Thanks,
Laurent
