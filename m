Received: from eggs.gnu.org ([2001:4830:134:3::10]:34745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fmuOi-000274-C0
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 01:19:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fmuOh-0005V2-Bg
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 01:19:08 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230]:40554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1fmuOh-0005Tm-2r
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 01:19:07 -0400
Received: by mail-lj1-x230.google.com with SMTP id j19-v6so12374470ljc.7
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 22:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <1533177924-24765-1-git-send-email-whois.zihan.yang@gmail.com>
	<1533177924-24765-2-git-send-email-whois.zihan.yang@gmail.com>
	<91bb56d1-39bb-813a-55e6-67020670e94d@gmail.com>
In-Reply-To: <91bb56d1-39bb-813a-55e6-67020670e94d@gmail.com>
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Tue, 7 Aug 2018 13:18:53 +0800
Message-ID: <CAKwiv-jmuFNb=v52L=asRtcL7Ohe3zSCjChegQcUk7GWofEeKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v3 1/6] pci_expander_bridge: add type
 TYPE_PXB_PCIE_HOST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>

Marcel Apfelbaum <marcel.apfelbaum@gmail.com> =E4=BA=8E2018=E5=B9=B48=E6=9C=
=886=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=887:46=E5=86=99=E9=81=93=EF=
=BC=9A
>
>
>
> On 08/02/2018 05:45 AM, Zihan Yang wrote:
> > The inner host bridge created by pxb-pcie is TYPE_PXB_PCI_HOST by defau=
lt,
> > change it to a new type TYPE_PXB_PCIE_HOST to better utilize ECAM of PC=
Ie
>
> After an offline conversation we decided to not review this version
> and wait for the next one, that will come with a SeaBIOS counterpart seri=
es.

Yes, there are also a few trivial bugs that I fix later. I'm preparing
for a new patch set,
and a patch set in seabios.

> Zihan, please be sure to add 'patch 0 ' to the series where we can discus=
s
> the series status.

There actually is a patch 0, but it seems the cccmd does not apply the
patch 0 automatically,
I will cc you the cover letter too next time.

Thanks,
Zihan
