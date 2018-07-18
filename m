Received: from eggs.gnu.org ([2001:4830:134:3::10]:51115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1ffsj2-0007Lr-0E
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 16:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1ffsiw-0003MV-Fs
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 16:07:03 -0400
Received: from relay3.mail.vrmd.de ([81.28.224.24]:39089)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mail@sebastianbauer.info>)
	id 1ffsiw-0003Il-74
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 16:06:58 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Jul 2018 22:06:49 +0200
From: Sebastian Bauer <mail@sebastianbauer.info>
In-Reply-To: <20180718023053.GD2102@umbus.fritz.box>
References: <alpine.BSF.2.21.1807151041060.88858@zero.eik.bme.hu>
	<20180716025346.GF2599@umbus.fritz.box>
	<alpine.BSF.2.21.1807162207210.15021@zero.eik.bme.hu>
	<CAFEAcA_3km1OB=7kqoZ6AvW0+G9FqfgD+go_KghFLDrgj2Xk+g@mail.gmail.com>
	<20180718023053.GD2102@umbus.fritz.box>
Message-ID: <ff5eefb78d7f075df404707d83ed5d95@sebastianbauer.info>
Subject: Re: [Qemu-devel] hw/display/sm501* status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, BALATON Zoltan <balaton@eik.bme.hu>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Hi,

Am 2018-07-18 04:30, schrieb David Gibson:
> On Mon, Jul 16, 2018 at 09:43:05PM +0100, Peter Maydell wrote:
>> On 16 July 2018 at 21:26, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> > I could list sm501 in the sam460ex section thus formally taking
>> > sub-maintainership but this would only go as far that I'll get cc-d on
>> > changes and try to review them. I still can't (and don't want to) maintain
>> > my own tree and send pull requests directly so I'd need someone's help with
>> > that who can take my patches and merge them via their tree. If it's OK to
>> > continue to use the PPC tree for that I'm fine with that if David agrees
>> > (which I think he did above).
>> >
>> > So is it OK to add sm501 to sam460ex section so I claim responsibility for
>> > changes and will continue sending patches cc-ing David (and maybe Gerd to
>> > help spotting problems) then David could take these via the PPC tree?
>> 
>> I think that makes sense. sh4 is pretty dead and if sm501's major
>> active user is the sam460ex then listing it there seems reasonable.
> 
> Sounds good to me.
> 
> Zoltan, can you send a patch adding sm501 to the sam460ex section of
> the MAINTAINERS file.  That will make you the right point of contact
> for it.
> 
> On the understanding that it's just about tree logistics, rather than
> review, I'll be happy to take sm501 patches from you through my tree.

Zoltan, if you like you can also add me as a possible reviewer for 
anything that is Sam460ex-related.

Bye
Sebastian
