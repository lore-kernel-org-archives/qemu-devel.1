Received: from eggs.gnu.org ([2001:4830:134:3::10]:38748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1fZOC1-0001Eq-KX
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 18:18:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1fZOBy-0002KN-FM
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 18:18:09 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:52649)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1fZOBy-0002Jb-8w
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 18:18:06 -0400
References: <20180626215955.18933-1-jcd@tribudubois.net>
	<CAFEAcA_w7XjKyQZAB91ma-X89H5YhG-EU63RM+8E-hYbX02iaw@mail.gmail.com>
From: Jean-Christophe DUBOIS <jcd@tribudubois.net>
Message-ID: <f9de5386-a33b-de53-44e9-cad0ca3ec77d@tribudubois.net>
Date: Sun, 1 Jul 2018 00:18:01 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_w7XjKyQZAB91ma-X89H5YhG-EU63RM+8E-hYbX02iaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 0/3] i.mx7d fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Chubb <peter.chubb@nicta.com.au>, QEMU Developers <qemu-devel@nongnu.org>

Le 28/06/2018 à 17:13, Peter Maydell a écrit :
> On 26 June 2018 at 22:59, Jean-Christophe Dubois <jcd@tribudubois.net> wrote:
>> Small fixes in the i.mx7d code.
>>
>> Jean-Christophe Dubois (3):
>>    i.mx7d: Remove unused header files
>>    i.mx7d: Change SRC unimpleted device name from sdma to src
>>    i.mx7d: Change IRQ number type from hwaddr to int
>>
>>   hw/arm/fsl-imx7.c      | 8 ++++----
>>   hw/arm/mcimx7d-sabre.c | 2 --
>>   2 files changed, 4 insertions(+), 6 deletions(-)
> Thanks, applied all to target-arm.next.
>
> Something seems to have gone wrong with posting of this series:
> the patches didn't get sent as followups to the cover letter
> (missing In-reply-to: headers). You might want to look into that
> for future patch postings.
Thank Peter,

Yes, something went wrong (I think this is the piece between the chair 
and the keyboard).

I'll try to be better next time.

JC

>
> -- PMM
>
>
