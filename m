Received: from eggs.gnu.org ([2001:4830:134:3::10]:50379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cbqc0-0005IJ-FQ
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 10:26:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cbqbw-0003KV-Gs
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 10:26:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cbqbw-0003KO-BF
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 10:26:16 -0500
Message-ID: <1486653967.31104.37.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 09 Feb 2017 16:26:07 +0100
In-Reply-To: <1486652198.3641.45.camel@redhat.com>
References: <1486575331-14455-1-git-send-email-abologna@redhat.com>
	<1486575331-14455-3-git-send-email-abologna@redhat.com>
	<20170209094259.nmli6yd5swxdujkm@kamzik.brq.redhat.com>
	<CAFEAcA8bRHuF_to0+whEhNF5oXp5_O63H8EV2JTXBngffufz9Q@mail.gmail.com>
	<1486637473.3641.36.camel@redhat.com>
	<20170209122819.ajgatpsnxj7cdjq2@kamzik.brq.redhat.com>
	<1486646865.3641.41.camel@redhat.com>
	<20170209140804.onpj3pniqim3qxr4@kamzik.brq.redhat.com>
	<1486652198.3641.45.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 2/2] mach-virt: Provide sample
 configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: Andrew Jones <drjones@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

  Hi,

> By the way, switching between serial and monitor is not
> done with Ctrl+A but with Ctrl+A-c, which is not the most
> convenient shortcut if you're running your guests on a
> remote host due to GNU screen using the very same one ;)

And for the record: "Ctrl+a h" prints a list of hotkeys.

cheers,
  Gerd
