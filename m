Received: from eggs.gnu.org ([209.51.188.92]:33833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gpbVo-0000XK-CF
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:17:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gpbVn-0007s4-Jh
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:17:52 -0500
References: <20190117185628.21862-1-crosa@redhat.com>
	<BN6PR2201MB1251E38EAEAFC4A8C0B13D31C69F0@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<f98bc26a-e0ed-9a45-46b0-331cce9bdc49@redhat.com>
	<352f7b14-0c91-67c6-0cea-5d2d15fb3060@redhat.com>
	<BN6PR2201MB1251AD11375F9590036D9D48C6920@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <18dc1822-da36-258f-5fe1-476e1569aaaa@redhat.com>
Date: Fri, 1 Feb 2019 11:17:27 -0500
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB1251AD11375F9590036D9D48C6920@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/18] Acceptance Tests: target
 architecture support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>



On 2/1/19 12:32 AM, Aleksandar Markovic wrote:
>>> I think, the term "arch" is a little problematic in QEMU parlance. IMHO,
>>> "target" should be used instead. ("arch" is used in Linux kernel community)
> 
>> Naming things is hard, so this is a valid discussion.  But, I have to
>> say that I also find "arch" in this context to be descriptive enough.
> 
> This is not a "naming" problem, but a fundamental terminology convention used in QEMU. I am truly dissapointed that you chose to disrespect it.
> 
> Aleksandar
> 

Hi Aleksandar,

I'm basically listening to more experienced people on the matter, as I
clearly lack the background on the "terminology conventions", and thus,
I'm unable to make the best naming choices by myself.

Now, we have had participation from few people, and there doesn't seem
to be consensus.  So, to make it clear, I didn't *choose* to disrespect
it, I chose to respect how I perceived the community input.

If this makes you truly disappointed, please ask more people to give
their input, and I'll gladly steer the direction of this humble ship, I
mean, patch series. :)

Regards,
- Cleber.
