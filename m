Received: from eggs.gnu.org ([2001:4830:134:3::10]:44273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffAL9-0006i3-D6
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 16:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffAL8-0001WZ-Nj
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 16:43:27 -0400
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:38956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffAL8-0001Vb-I5
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 16:43:26 -0400
Received: by mail-oi0-x234.google.com with SMTP id d189-v6so77359810oib.6
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 13:43:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1807162207210.15021@zero.eik.bme.hu>
References: <alpine.BSF.2.21.1807151041060.88858@zero.eik.bme.hu>
	<20180716025346.GF2599@umbus.fritz.box>
	<alpine.BSF.2.21.1807162207210.15021@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jul 2018 21:43:05 +0100
Message-ID: <CAFEAcA_3km1OB=7kqoZ6AvW0+G9FqfgD+go_KghFLDrgj2Xk+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] hw/display/sm501* status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: David Gibson <david@gibson.dropbear.id.au>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Gerd Hoffmann <kraxel@redhat.com>, Sebastian Bauer <mail@sebastianbauer.info>, QEMU Developers <qemu-devel@nongnu.org>

On 16 July 2018 at 21:26, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> I could list sm501 in the sam460ex section thus formally taking
> sub-maintainership but this would only go as far that I'll get cc-d on
> changes and try to review them. I still can't (and don't want to) maintain
> my own tree and send pull requests directly so I'd need someone's help with
> that who can take my patches and merge them via their tree. If it's OK to
> continue to use the PPC tree for that I'm fine with that if David agrees
> (which I think he did above).
>
> So is it OK to add sm501 to sam460ex section so I claim responsibility for
> changes and will continue sending patches cc-ing David (and maybe Gerd to
> help spotting problems) then David could take these via the PPC tree?

I think that makes sense. sh4 is pretty dead and if sm501's major
active user is the sam460ex then listing it there seems reasonable.

thanks
-- PMM
