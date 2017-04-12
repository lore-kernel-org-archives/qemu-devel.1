Received: from eggs.gnu.org ([2001:4830:134:3::10]:38041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cyIyw-0006SR-Jt
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 10:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cyIyr-0002Vz-LX
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 10:10:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cyIyr-0002VT-9E
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 10:10:45 -0400
Message-ID: <1492006239.4848.7.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 12 Apr 2017 16:10:39 +0200
In-Reply-To: <CAJ+F1CLF1DLBD7HwegMzFPW13AkTUyt=g27hr_ObwLFaucM_iA@mail.gmail.com>
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<20170308102009.GF7470@redhat.com>
	<1488971976.6514.54.camel@redhat.com>
	<CAJ+F1CLF1DLBD7HwegMzFPW13AkTUyt=g27hr_ObwLFaucM_iA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] What's the next QEMU version after 2.9 ? (or: when
 is a good point in time to get rid of old interfaces)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

  Hi,

> What about deprecating GTK 2.0 ? SDL (1.2 or all?)

gtk2 + sdl1 makes sense.

sdl2 proably has too many users to drop it.  Not everybody prefers the
gtk ui ...

cheers,
  Gerd
