Received: from eggs.gnu.org ([209.51.188.92]:39734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h0rrN-00084S-T6
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:58:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h0rrN-0001P7-4l
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:58:41 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:45758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1h0rrM-0001N0-U5
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:58:41 -0500
Date: Mon, 4 Mar 2019 18:58:36 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <e72fd744-3440-a684-38c4-75d6d604cddb@redhat.com>
Message-ID: <alpine.BSF.2.21.9999.1903041858020.32794@zero.eik.bme.hu>
References: <alpine.BSF.2.21.9999.1811292101280.5887@zero.eik.bme.hu>
	<alpine.BSF.2.21.9999.1901151926320.72972@zero.eik.bme.hu>
	<e72fd744-3440-a684-38c4-75d6d604cddb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Booting Raspbian on RPi emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org

Hello,

On Tue, 15 Jan 2019, Philippe Mathieu-Daud=E9 wrote:
> On 1/15/19 7:29 PM, BALATON Zoltan wrote:
>> On Thu, 29 Nov 2018, BALATON Zoltan wrote:
>>> Then I've tried the same with the pll patches posted by Philippe
>>> Mathieu-Daud=E9 here:
>>>
>>> http://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg00191.html
>>>
>>> on top of v3.1.0-rc3 which helped to get rid of the cprman warnings
>>
>> Will these patches be merged eventually? These seem to at least get ri=
d
>> of some annoying warnings in Linux boot dmesg.
>
> I'll respin this series addressing Peter's comments.
>
> Thanks for reminding me ;)

What happened to these? Will they make it in master before the freeze?

Regards,
BALATON Zoltan
